// import 'package:dio/dio.dart';
// var baseurl="http://10.0.2.2/roqsal_frha_flutter_admin_2026/PHP/apiii.php";
// class Ai {
//   static Future<Response?> getai() async {
//     try {
//       final response = await Dio().get(baseurl);
//       print("mhmd");
//       print(response.toString());
//       return response.data;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }}

// class ServiceModel {
//   final String message;
//   final List<Service> services;
//   final int totalCost;
//   final int remainingBudget;
//
//   ServiceModel({
//     required this.message,
//     required this.services,
//     required this.totalCost,
//     required this.remainingBudget,
//   });
//
//   factory ServiceModel.fromJson(Map<String, dynamic> json) {
//     return ServiceModel(
//       message: json['message'] ?? '',
//       services: (json['services'] as List)
//           .map((service) => Service.fromJson(service as Map<String, dynamic>))
//           .toList(),
//       totalCost: json['total_cost'] ?? 0,
//       remainingBudget: json['remaining_budget'] ?? 0,
//     );
//   }
// }
//
// class Service {
//   final String category;
//   final String name;
//   final int price;
//   final String image;
//
//   Service({
//     required this.category,
//     required this.name,
//     required this.price,
//     required this.image,
//   });
//
//   factory Service.fromJson(Map<String, dynamic> json) {
//     return Service(
//       category: json['category']?.toString() ?? '',
//       name: json['name']?.toString() ?? '',
//       price: json['price'] is int
//           ? json['price']
//           : int.tryParse(json['price'].toString()) ?? 0,
//       image: json['image']?.toString() ?? '',
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'dart:convert';

var baseurl = "http://127.0.0.1:8088/roqsal_frha_flutter_admin_2026/PHP/apii.php";
var url="http://127.0.0.1:8088/roqsal_frha_flutter_admin_2026/PHP/";

class Get_data {
  static Future<Response?> getdata({required id}) async {
    try {
      print(id);
      final response = await Dio().get(
        '$url/get_data.php',
        data: {'id': id},
      );
      print(response);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }}

class Ai {
  static Future<ServiceModel?> getai({String? userMessage}) async {
    try {
      print("محاولة الاتصال بـ: $baseurl");

      // طباعة رسالة المستخدم إذا وجدت
      if (userMessage != null) {
        print("رسالة المستخدم: $userMessage");
      }

      // إعداد Dio بدون timeout (غير محدود)
      Dio dio = Dio(
        BaseOptions(
          connectTimeout: null, // إلغاء مهلة الاتصال
          receiveTimeout: null, // إلغاء مهلة الاستلام
          sendTimeout: null, // إلغاء مهلة الإرسال
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain,
          validateStatus: (status) {
            return true; // قبول جميع الحالات
          },
        ),
      );

      print("جاري الاتصال...");

      // تجهيز البيانات للإرسال
      Map<String, dynamic> requestData = {};
      if (userMessage != null && userMessage.isNotEmpty) {
        requestData['message'] = userMessage;
      }

      // إرسال الطلب مع البيانات إذا وجدت
      final response = await dio.get(
        baseurl,
        data: requestData.isNotEmpty ? json.encode(requestData) : null,
        options: Options(
          method: 'POST', // تغيير الطريقة إلى POST لإرسال البيانات
        ),
      );

      print("تم الاتصال بنجاح");
      print("حالة الاتصال: ${response.statusCode}");
      print("البيانات المستلمة: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data is String) {
          try {
            var jsonData = json.decode(response.data);
            if (jsonData is Map<String, dynamic>) {
              ServiceModel model = ServiceModel.fromJson(jsonData);
              print("تم تحميل ${model.services.length} خدمة بنجاح");
              return model;
            } else {
              print("البيانات المحولة ليست Map: ${jsonData.runtimeType}");
            }
          } catch (e) {
            print("خطأ في تحويل JSON: $e");
            print("البيانات الخام: ${response.data}");
          }
        } else if (response.data is Map<String, dynamic>) {
          ServiceModel model = ServiceModel.fromJson(response.data);
          print("تم تحميل ${model.services.length} خدمة بنجاح");
          return model;
        } else {
          print("نوع البيانات غير متوقع: ${response.data.runtimeType}");
        }
      } else {
        print("فشل الطلب - رمز الحالة: ${response.statusCode}");
      }

      return null;

    } on DioException catch (e) {
      print("خطأ Dio: ${e.type} - ${e.message}");
      if (e.response != null) {
        print("بيانات الرد: ${e.response?.data}");
        print("حالة الرد: ${e.response?.statusCode}");
      }
      return null;
    } catch (e) {
      print("خطأ غير متوقع: $e");
      print("نوع الخطأ: ${e.runtimeType}");
      return null;
    }
  }

  // دالة مساعدة للاختبار بدون رسالة
  static Future<ServiceModel?> getaiWithoutMessage() async {
    return await getai();
  }
}

// ServiceModel و Service كلاسات كما هي...
class ServiceModel {
  final String message;
  final List<Service> services;
  final int totalCost;
  final int remainingBudget;

  ServiceModel({
    required this.message,
    required this.services,
    required this.totalCost,
    required this.remainingBudget,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      message: json['message'] ?? '',
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
      totalCost: json['total_cost'] ?? 0,
      remainingBudget: json['remaining_budget'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'ServiceModel(message: $message, services: ${services.length}, totalCost: $totalCost, remainingBudget: $remainingBudget)';
  }
}

class Service {
  final int id;
  final String category;
  final String name;
  final String address;
  final int price;
  final String image;
  final String rating;

  Service({
    required this.id,
    required this.category,
    required this.name,
    required this.address,
    required this.price,
    required this.image,
    required this.rating,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] is int
          ? json['id']: int.tryParse(json['id'].toString()) ?? 0,
      category: json['category']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
      image: json['image']?.toString() ?? '',
      rating: json['rating_Admin']?.toString() ?? '',
    );
  }

  @override
  String toString() {
    return 'Service(id:$id,category: $category,name: $name, address: $address, price: $price, image: $image,rating:$rating)';
  }
}