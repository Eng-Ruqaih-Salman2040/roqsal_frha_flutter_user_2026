import 'dart:convert';
import 'package:get/get.dart';
import '../../apiservice/api_service.dart';
import '../../widget/dailog_widget.dart';
import '../../Constants.dart';
import 'rating_model.dart';

class RatingController extends GetxController {
  var ratings = <Review>[].obs;
  var summary = RatingSummary().obs;
  var isLoading = false.obs;
  var isSubmitting = false.obs;
  var errorMessage = ''.obs; // لإضافة رسالة الخطأ

  // Pagination
  var currentPage = 1.obs;
  var hasMorePages = true.obs;
  var totalPages = 1.obs;
  var totalItems = 0.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    // يمكن إضافة أي تهيئة هنا
  }

  @override
  void onClose() {
    // تنظيف الموارد إذا لزم الأمر
    super.onClose();
  }

  // لجلب التقييمات
  Future<void> getRatings(String shopId, {int page = 1}) async {
    if (shopId.isEmpty) {
      errorMessage.value = 'معرف المتجر مطلوب';
      return;
    }

    try {
      if (page == 1) {
        isLoading.value = true;
        ratings.clear();
      }

      final response = await _apiService.getRatings(shopId, page: page);

      if (response.statusCode == 200) {
        await _handleRatingResponse(response, page);
      } else {
        errorMessage.value = 'خطأ في الاتصال بالخادم (${response.statusCode})';
        print('❌ HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage.value = 'حدث خطأ: $e';
      print('❌ Error getting ratings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // دالة مساعدة لمعالجة استجابة التقييمات
  Future<void> _handleRatingResponse(dynamic response, int page) async {
    try {
      final dynamic responseData = response.data is String
          ? json.decode(response.data)
          : response.data;

      if (responseData is Map<String, dynamic>) {
        final ratingModel = RatingModel.fromJson(responseData);

        if (ratingModel.success == true) {
          // إضافة التقييمات
          if (ratingModel.reviews != null) {
            if (page == 1) {
              ratings.value = ratingModel.reviews!;
            } else {
              ratings.addAll(ratingModel.reviews!);
            }
          }

          // تحديث الملخص
          if (ratingModel.summary != null) {
            summary.value = ratingModel.summary!;
          }

          // تحديث معلومات الصفحات
          if (ratingModel.pagination != null) {
            currentPage.value = ratingModel.pagination!.currentPage ?? page;
            totalPages.value = ratingModel.pagination!.totalPages ?? 1;
            totalItems.value = ratingModel.pagination!.totalItems ?? 0;
            hasMorePages.value = currentPage.value < totalPages.value;
          }

          errorMessage.value = '';
        } else {
          errorMessage.value = ratingModel.message ?? 'حدث خطأ في تحميل التقييمات';
          print('❌ API returned error: ${ratingModel.message}');
        }
      } else {
        errorMessage.value = 'تنسيق استجابة غير صحيح';
        print('❌ Invalid response format: $responseData');
      }
    } catch (e) {
      errorMessage.value = 'خطأ في تحليل البيانات';
      print('❌ Error parsing JSON: $e');
      print('❌ Raw response: ${response.data}');
    }
  }

  // إضافة تقييم
  Future<bool> addRating({
    required String shopId,
    required String customerId,
    required double ratingValue,
    String? reviewComment,
  }) async {
    if (shopId.isEmpty || customerId.isEmpty) {
      GetSnackMsg(
        msg: 'البيانات المطلوبة غير مكتملة',
        bgClr: kColorRed,
        txClr: kColorsWhite,
      ).showTxt();
      return false;
    }

    try {
      isSubmitting.value = true;

      final response = await _apiService.addRating(
        shopId: shopId,
        customerId: customerId,
        ratingValue: ratingValue,
        reviewComment: reviewComment,
      );

      if (response.statusCode == 200) {
        return await _handleAddRatingResponse(response, shopId);
      } else {
        GetSnackMsg(
          msg: 'خطأ في الاتصال بالخادم (${response.statusCode})',
          bgClr: kColorRed,
          txClr: kColorsWhite,
        ).showTxt();
      }
    } catch (e) {
      print('❌ Error adding rating: $e');
      GetSnackMsg(
        msg: 'حدث خطأ في الاتصال',
        bgClr: kColorRed,
        txClr: kColorsWhite,
      ).showTxt();
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }

  // دالة مساعدة لمعالجة استجابة إضافة التقييم
  Future<bool> _handleAddRatingResponse(dynamic response, String shopId) async {
    try {
      final dynamic responseData = response.data is String
          ? json.decode(response.data)
          : response.data;

      if (responseData is Map<String, dynamic>) {
        if (responseData['success'] == true) {
          // إعادة تحميل التقييمات
          await refreshRatings(shopId);

          GetSnackMsg(
            msg: responseData['message'] ?? 'تم إضافة التقييم بنجاح',
            bgClr: kColorsPrimary,
            txClr: kColorsWhite,
          ).showTxt();
          return true;
        } else {
          GetSnackMsg(
            msg: responseData['message'] ?? 'حدث خطأ أثناء إضافة التقييم',
            bgClr: kColorRed,
            txClr: kColorsWhite,
          ).showTxt();
        }
      }
    } catch (e) {
      print('❌ Error parsing response: $e');
      print('❌ Raw response: ${response.data}');

      GetSnackMsg(
        msg: 'خطأ في استجابة الخادم',
        bgClr: kColorRed,
        txClr: kColorsWhite,
      ).showTxt();
    }
    return false;
  }

  // تحميل المزيد من التقييمات
  Future<void> loadMoreRatings(String shopId) async {
    if (hasMorePages.value && !isLoading.value && shopId.isNotEmpty) {
      currentPage.value++;
      await getRatings(shopId, page: currentPage.value);
    }
  }

  // تحديث التقييمات
  Future<void> refreshRatings(String shopId) async {
    if (shopId.isEmpty) return;

    try {
      isLoading.value = true;
      currentPage.value = 1;
      ratings.clear();

      final response = await _apiService.getRatings(shopId, page: 1);

      if (response.statusCode == 200) {
        await _handleRatingResponse(response, 1);
      }
    } catch (e) {
      print('❌ Error refreshing ratings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // إعادة تعيين الصفحات
  void resetPagination() {
    currentPage.value = 1;
    hasMorePages.value = true;
    totalPages.value = 1;
    totalItems.value = 0;
  }

  // مسح التقييمات
  void clearRatings() {
    ratings.clear();
    resetPagination();
    summary.value = RatingSummary();
    errorMessage.value = '';
  }

  // دالة للحصول على متوسط التقييم كـ String
  String getAverageRatingAsString() {
    final avg = summary.value.averageRating ?? 0.0;
    return avg.toStringAsFixed(1);
  }

  // دالة للحصول على إجمالي التقييمات كـ String
  String getTotalReviewsAsString() {
    final total = summary.value.totalReviews ?? 0;
    return '$total تقييم${total != 1 ? 'ات' : ''}';
  }

  // دالة للتحقق من وجود تقييمات
  bool get hasRatings => ratings.isNotEmpty;

  // دالة للتحقق من وجود أخطاء
  bool get hasError => errorMessage.isNotEmpty;

  // دالة لحساب النسبة المئوية لعدد معين من النجوم
  double getStarPercentage(int starCount) {
    final total = summary.value.totalReviews ?? 0;
    if (total == 0) return 0.0;

    switch (starCount) {
      case 5: return (summary.value.fiveStar ?? 0) / total;
      case 4: return (summary.value.fourStar ?? 0) / total;
      case 3: return (summary.value.threeStar ?? 0) / total;
      case 2: return (summary.value.twoStar ?? 0) / total;
      case 1: return (summary.value.oneStar ?? 0) / total;
      default: return 0.0;
    }
  }
}