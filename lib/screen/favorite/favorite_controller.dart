import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../apiservice/checkInterNet.dart';
import '../../screen/section/section_model.dart';
import '../../screen/shop/shop_model.dart';
import '../../Constants.dart';
import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../shop_details/shop_details.dart';
import '../shop_details/shop_details_controller.dart';
import 'favorite.dart';
import 'favorite_model.dart';

class favoriteController extends GetxController with StateMixin<favoriteModel> {
  favoriteModel? model;
  RxBool isLoading = false.obs;

  void onInit() async {
    super.onInit();
  }

  Future<void> delete_favorite_postApi(String shop_id, String customers_id, var data) async {
    try {
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      var response = await ApiService().postDataForm(url: '?checkopration=delete_favorite&shop_id=$shop_id&customers_id=$customers_id');

      Get.back(); // إغلاق الـ Dialog

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        if (responseData['success'] == true) {
          GetSnackMsg(
              msg: responseData['message'] ?? 'تم الحذف من المفضلة',
              bgClr: Colors.green,
              txClr: kColorsWhite
          ).showTxt();

          // تحديث البيانات
          await getFavoriteApi(customers_id);
          await Get.put(shopDetailsController()).getGalleryApi(shop_id, customers_id);

          // العودة للصفحة السابقة
          Get.back();
        } else {
          GetSnackMsg(
              msg: responseData['message'] ?? 'حدث خطأ',
              bgClr: Colors.red,
              txClr: kColorsWhite
          ).showTxt();
        }
      }
    } catch (e) {
      Get.back();
      GetSnackMsg(
          msg: 'حدث خطأ: $e',
          bgClr: Colors.red,
          txClr: kColorsWhite
      ).showTxt();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> add_favorite_postApi(String shop_id, String customers_id, var data) async {
    try {
      isLoading.value = true;
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      var response = await ApiService().postDataForm(url: '?checkopration=add_favorite&shop_id=$shop_id&customers_id=$customers_id');

      Get.back(); // إغلاق الـ Dialog

      if (response.statusCode == 200) {
        var responseData = json.decode(response.data);
        if (responseData['success'] == true) {
          GetSnackMsg(
              msg: responseData['message'] ?? 'تمت الإضافة إلى المفضلة',
              bgClr: Colors.green,
              txClr: kColorsWhite
          ).showTxt();

          // تحديث البيانات
          await getFavoriteApi(customers_id);
          await Get.put(shopDetailsController()).getGalleryApi(shop_id, customers_id);

          // العودة للصفحة السابقة
          Get.off(() => shop_detailsScreen(data));
        } else {
          GetSnackMsg(
              msg: responseData['message'] ?? 'حدث خطأ',
              bgClr: Colors.orange,
              txClr: kColorsWhite
          ).showTxt();
        }
      }
    } catch (e) {
      Get.back();
      GetSnackMsg(
          msg: 'حدث خطأ: $e',
          bgClr: Colors.red,
          txClr: kColorsWhite
      ).showTxt();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFavoriteApi(String customers_id) async {
    try {
      change(null, status: RxStatus.loading());

      var response = await ApiService().getData('?checkopration=load_Data_shop_favorite&customers_id=$customers_id');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.data);

        if (jsonData['success'] == true) {
          favoriteModel data = favoriteModel.fromJson(jsonData);
          model = data;

          print('✅ تم تحميل المفضلة: ${model?.data?.length ?? 0} عنصر');
          print('✅ البيانات: ${jsonEncode(model?.data)}');

          update();
          change(data, status: RxStatus.success());
        } else {
          print('❌ فشل تحميل المفضلة: ${jsonData['message']}');
          change(null, status: RxStatus.error());
        }
      } else {
        print('❌ خطأ في الاتصال بالخادم');
        change(null, status: RxStatus.error());
      }
    } catch (e) {
      print('❌ استثناء: $e');
      change(null, status: RxStatus.error());
    }
  }

  // دالة للتحقق مما إذا كان المتجر في المفضلة
  bool isFavorite(String shop_id) {
    if (model?.data == null || model!.data!.isEmpty) return false;
    return model!.data!.any((item) => item.shopId == shop_id);
  }

  // دالة للحصول على ID المفضلة لمتجر معين
  String? getFavoriteId(String shop_id) {
    if (model?.data == null || model!.data!.isEmpty) return null;
    try {
      var favorite = model!.data!.firstWhere(
            (item) => item.shopId == shop_id,
      );
      return favorite.favoriteId;
    } catch (e) {
      return null;
    }
  }

  // دالة للحصول على عدد عناصر المفضلة
  int get favoriteCount {
    return model?.data?.length ?? 0;
  }

  // دالة للحصول على قائمة المتاجر المفضلة
  List<FavoriteShop>? get favoriteList {
    return model?.data;
  }
}