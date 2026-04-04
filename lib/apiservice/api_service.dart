import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apiservice/url.dart';

import '../Constants.dart';

class ApiService extends GetConnect {
  dio.Dio _dio = dio.Dio();

  // Constructor لتهيئة الإعدادات
  ApiService() {
    _dio.options.connectTimeout = Duration(seconds: 30);
    _dio.options.receiveTimeout = Duration(seconds: 30);
    _dio.options.sendTimeout = Duration(seconds: 30);
  }

  // دالة GET الأساسية
  Future<dio.Response> getData(String url) async {
    dio.Response response;

    try {
      print('🌐 GET Request: $urlBase$url');
      response = await _dio.get(
        urlBase + url,
      );
      print('✅ GET Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ GET Error: ${error.message}');
      if (error.response != null) {
        print('❌ Response Data: ${error.response?.data}');
        return error.response!;
      }
      rethrow;
    }
  }

  // ✅ دالة GET مع معاملات (query parameters) - أضف هذه الدالة
  Future<dio.Response> getDataWithParams(Map<String, dynamic> params) async {
    dio.Response response;

    try {
      String queryString = Uri(queryParameters: params).query;
      String url = '$urlBase?$queryString';
      print('🌐 GET Request with Params: $url');

      response = await _dio.get(url);
      print('✅ GET Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ GET Error: ${error.message}');
      if (error.response != null) {
        return error.response!;
      }
      rethrow;
    }
  }

  // دالة POST مع FormData (للملفات والبيانات)
  Future<dio.Response> postData({
    required String url,
    Map<String, dynamic>? header,
    required Map<String, dynamic> body,
  }) async {
    dio.Response response;

    try {
      print('🌐 POST Request: $urlBase$url');
      print('📦 Body: $body');

      // تحويل البيانات إلى FormData
      dio.FormData formData = dio.FormData.fromMap(body);

      response = await _dio.post(
        urlBase + url,
        options: dio.Options(headers: header ?? {}),
        data: formData,
        onSendProgress: (count, total) {
          double progress = (count / total) * 100;
          print('📤 Upload Progress: ${progress.toStringAsFixed(2)}%');
        },
      );

      print('✅ POST Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ POST Error: ${error.message}');
      if (error.response != null) {
        print('❌ Response Data: ${error.response?.data}');
        return error.response!;
      }
      rethrow;
    }
  }

  // دالة POST بسيطة (للبيانات العادية)
  Future<dio.Response> postDataSimple({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    dio.Response response;

    try {
      print('🌐 POST Simple Request: $urlBase$url');
      print('📦 Body: $body');

      response = await _dio.post(
        urlBase + url,
        data: body,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      print('✅ POST Simple Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ POST Simple Error: ${error.message}');
      if (error.response != null) {
        return error.response!;
      }
      rethrow;
    }
  }

  // دالة POST للـ Login (محسنة)
  Future<dio.Response> postDataLogin({required String url}) async {
    dio.Response response;

    try {
      print('🌐 Login Request: $urlBase$url');
      response = await _dio.post(
        urlBase + url,
        onSendProgress: (count, total) {
          // يمكن إضافة مؤشر تقدم هنا
        },
      );
      print('✅ Login Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ Login Error: ${error.message}');
      if (error.response != null) {
        return error.response!;
      }
      rethrow;
    }
  }

  // دالة POST للـ Form
  Future<dio.Response> postDataForm({required String url}) async {
    dio.Response response;

    try {
      print('🌐 Form Request: $urlBase$url');
      response = await _dio.post(
        urlBase + url,
        onSendProgress: (count, total) {
          // يمكن إضافة مؤشر تقدم هنا
        },
      );
      print('✅ Form Response Status: ${response.statusCode}');
      return response;
    } on dio.DioError catch (error) {
      print('❌ Form Error: ${error.message}');
      if (error.response != null) {
        return error.response!;
      }
      rethrow;
    }
  }

  // دالة خاصة للتقييمات - جلب التقييمات
  Future<dio.Response> getRatings(String shopId, {int page = 1}) async {
    return getDataWithParams({
      'checkopration': 'get_ratings',
      'shop_id': shopId,
      'page': page.toString(),
    });
  }

  // دالة خاصة للتقييمات - إضافة تقييم
  Future<dio.Response> addRating({
    required String shopId,
    required String customerId,
    required double ratingValue,
    String? reviewComment,
    List<dio.MultipartFile>? images,
  }) async {
    Map<String, dynamic> body = {
      'checkopration': 'add_rating',
      'shop_id': shopId,
      'customer_id': customerId,
      'rating_value': ratingValue.toString(),
    };

    if (reviewComment != null && reviewComment.isNotEmpty) {
      body['review_comment'] = reviewComment;
    }

    // إذا كانت هناك صور، نستخدم postData مع FormData
    if (images != null && images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        body['rating_images[$i]'] = images[i];
      }
      return postData(url: '', body: body);
    } else {
      // بدون صور، نستخدم postDataSimple
      return postDataSimple(url: '', body: body);
    }
  }

  // دالة خاصة للتقييمات - حذف تقييم
  Future<dio.Response> deleteRating(String reviewId) async {
    return postDataSimple(url: '', body: {
      'checkopration': 'delete_rating',
      'review_id': reviewId,
    });
  }

  // دالة لرفع صورة واحدة (يمكن استخدامها مع التقييمات)
  Future<dio.Response> uploadImage({
    required String filePath,
    required Map<String, dynamic> additionalData,
  }) async {
    try {
      String fileName = filePath.split('/').last;
      dio.FormData formData = dio.FormData.fromMap({
        ...additionalData,
        'image': await dio.MultipartFile.fromFile(filePath, filename: fileName),
      });

      return await _dio.post(
        urlBase,
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
        onSendProgress: (count, total) {
          double progress = (count / total) * 100;
          print('📤 Upload Image Progress: ${progress.toStringAsFixed(2)}%');
        },
      );
    } catch (e) {
      print('❌ Upload Image Error: $e');
      rethrow;
    }
  }

  // دالة لرفع عدة صور (يمكن استخدامها مع التقييمات)
  Future<dio.Response> uploadMultipleImages({
    required List<String> filePaths,
    required Map<String, dynamic> additionalData,
  }) async {
    try {
      dio.FormData formData = dio.FormData.fromMap(additionalData);

      for (int i = 0; i < filePaths.length; i++) {
        String fileName = filePaths[i].split('/').last;
        formData.files.add(
          MapEntry(
            'images[$i]',
            await dio.MultipartFile.fromFile(filePaths[i], filename: fileName),
          ),
        );
      }

      return await _dio.post(
        urlBase,
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
        onSendProgress: (count, total) {
          double progress = (count / total) * 100;
          print('📤 Upload Multiple Images Progress: ${progress.toStringAsFixed(2)}%');
        },
      );
    } catch (e) {
      print('❌ Upload Multiple Images Error: $e');
      rethrow;
    }
  }

  // دالة مساعدة لتحويل الخطأ إلى رسالة مفهومة
  String handleError(dynamic error) {
    if (error is dio.DioError) {
      switch (error.type) {
        case dio.DioErrorType.connectionTimeout:
          return 'انتهت مهلة الاتصال';
        case dio.DioErrorType.sendTimeout:
          return 'انتهت مهلة الإرسال';
        case dio.DioErrorType.receiveTimeout:
          return 'انتهت مهلة الاستقبال';
        case dio.DioErrorType.badResponse:
          return 'خطأ في الاستجابة من الخادم';
        case dio.DioErrorType.cancel:
          return 'تم إلغاء الطلب';
        case dio.DioErrorType.connectionError:
          return 'خطأ في الاتصال بالإنترنت';
        default:
          return 'حدث خطأ غير متوقع';
      }
    }
    return 'حدث خطأ: $error';
  }
}