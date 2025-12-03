/*

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
import 'favorite_model.dart';

class favoriteController extends GetxController with StateMixin<favoriteModel> {

  favoriteModel? model;
  void onInit() async{
    super.onInit();

  }

  delete_favorite_postApi(String shop_id,String customers_id,var data){


    // Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)));
    Get.dialog(Center(child: CircularProgressIndicator(),));

    ApiService().postDataForm(url:'?checkopration=delete_favorite&shop_id=${shop_id}'+'&customers_id=${customers_id}').then((value) {
      Get.back();
      GetSnackMsg(msg: 'تم حذفة من المفضلة'.tr,bgClr:Colors.green ,txClr:kColorsWhite ).showTxt();

      Get.put(favoriteController()).getFavoriteApi(customers_id);
      Get.put(shopDetailsController()).getGalleryApi(shop_id,customers_id);
      Get.to(() => shop_detailsScreen(data));
      if(value.statusCode==200) {
        // GetSnackMsg(msg: 'تم اضافة الى المفضلة'.tr,bgClr:Colors.green ,txClr:kColorsWhite ).showTxt();
        //
        // print(value.data);
        // //   print(value.data["success"]);
        // favoriteModel loginModel =  favoriteModel.fromJson(json.decode(value.data));
        // print(value.data);
        // print(loginModel.success);
        // if(loginModel.success==true){
        //
        //   Get.back();
        //   update();
        // }
        // else{
        //   print('errr');
        // }


      }
      else{


      }}

    );
  }


  add_favorite_postApi(String shop_id,String customers_id,var data){


    // Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)));
    Get.dialog(Center(child: CircularProgressIndicator(),));

    ApiService().postDataForm(url:'?checkopration=add_favorite&shop_id=${shop_id}'+'&customers_id=${customers_id}').then((value) {
      Get.back();
      Get.put(favoriteController()).getFavoriteApi(customers_id);
      Get.put(shopDetailsController()).getGalleryApi(shop_id,customers_id);
      Get.to(() => shop_detailsScreen(data));
      GetSnackMsg(msg: 'تم اضافة الى المفضلة'.tr,bgClr:Colors.green ,txClr:kColorsWhite ).showTxt();

      if(value.statusCode==200) {
        // GetSnackMsg(msg: 'تم اضافة الى المفضلة'.tr,bgClr:Colors.green ,txClr:kColorsWhite ).showTxt();
        //
        // print(value.data);
        // //   print(value.data["success"]);
        // favoriteModel loginModel =  favoriteModel.fromJson(json.decode(value.data));
        // print(value.data);
        // print(loginModel.success);
        // if(loginModel.success==true){
        //
        //   Get.back();
        //   update();
        // }
        // else{
        //   print('errr');
        // }


      }
      else{


      }}

    );
  }

  getFavoriteApi(String customers_id){




    change(null, status: RxStatus.loading());
    ApiService().getData('?checkopration=load_Data_shop_favorite&customers_id=$customers_id').then((value) {

      if(value.statusCode==200) {
 print("aa");

print(value.data);

 favoriteModel data =  favoriteModel.fromJson(json.decode(value.data));


        print(value.data);



        update();
        change(data, status: RxStatus.success());


      }
      else{
        print("ee");
        change(null, status: RxStatus.error());

      }}

    );
  }
}*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../apiservice/api_service.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../shop_details/shop_details.dart';
import '../shop_details/shop_details_controller.dart';
import 'favorite_model.dart';

class favoriteController extends GetxController with StateMixin<favoriteModel> {

  favoriteModel? model;

  @override
  void onInit() async {
    super.onInit();
  }

  delete_favorite_postApi(String shop_id, String customers_id, var data) {
    Get.dialog(Center(child: CircularProgressIndicator()));

    ApiService().postDataForm(url: '?checkopration=delete_favorite&shop_id=$shop_id&customers_id=$customers_id').then((value) {
      Get.back();
      if (value.statusCode == 200) {
        GetSnackMsg(
            msg: 'تم حذفة من المفضلة'.tr,
            bgClr: Colors.green,
            txClr: kColorsWhite
        ).showTxt();

        Get.put(favoriteController()).getFavoriteApi(customers_id);
        Get.put(shopDetailsController()).getGalleryApi(shop_id, customers_id);
        Get.to(() => shop_detailsScreen(data));
      } else {
        GetSnackMsg(
            msg: 'خطأ في الاتصال'.tr,
            bgClr: Colors.red,
            txClr: kColorsWhite
        ).showTxt();
      }
    }).catchError((error) {
      Get.back();
      GetSnackMsg(
          msg: 'خطأ في الاتصال'.tr,
          bgClr: Colors.red,
          txClr: kColorsWhite
      ).showTxt();
    });
  }

  add_favorite_postApi(String shop_id, String customers_id, var data) {
    Get.dialog(Center(child: CircularProgressIndicator()));

    ApiService().postDataForm(url: '?checkopration=add_favorite&shop_id=$shop_id&customers_id=$customers_id').then((value) {
      Get.back();
      if (value.statusCode == 200) {
        GetSnackMsg(
            msg: 'تم اضافة الى المفضلة'.tr,
            bgClr: Colors.green,
            txClr: kColorsWhite
        ).showTxt();

        Get.put(favoriteController()).getFavoriteApi(customers_id);
        Get.put(shopDetailsController()).getGalleryApi(shop_id, customers_id);
        Get.to(() => shop_detailsScreen(data));
      } else {
        GetSnackMsg(
            msg: 'خطأ في الاتصال'.tr,
            bgClr: Colors.red,
            txClr: kColorsWhite
        ).showTxt();
      }
    }).catchError((error) {
      Get.back();
      GetSnackMsg(
          msg: 'خطأ في الاتصال'.tr,
          bgClr: Colors.red,
          txClr: kColorsWhite
      ).showTxt();
    });
  }

  getFavoriteApi(String customers_id) {
    change(null, status: RxStatus.loading());

    ApiService().getData('?checkopration=load_Data_shop_favorite&customers_id=$customers_id').then((value) {
      if (value.statusCode == 200) {
        print("API Response: ${value.data}");

        // Check if response is empty or null
        if (value.data == null || value.data.toString().isEmpty) {
          print("Empty response received");
          change(null, status: RxStatus.empty());
          return;
        }

        try {
          // Handle different response formats
          dynamic responseData;
          if (value.data is String) {
            // Check if string is empty before parsing
            if (value.data.trim().isEmpty) {
              change(null, status: RxStatus.empty());
              return;
            }
            responseData = json.decode(value.data);
          } else {
            responseData = value.data;
          }

          // Check if responseData is null or empty
          if (responseData == null || (responseData is Map && responseData.isEmpty)) {
            change(null, status: RxStatus.empty());
            return;
          }

          favoriteModel data = favoriteModel.fromJson(responseData);
          print("Parsed data: ${data.toJson()}");

          // Check if shop list is empty
          if (data.shop == null || data.shop!.isEmpty) {
            change(data, status: RxStatus.empty());
          } else {
            change(data, status: RxStatus.success());
          }

        } catch (e) {
          print("Error parsing JSON: $e");
          print("Raw response that caused error: ${value.data}");
          change(null, status: RxStatus.error("خطأ في تحليل البيانات"));
        }
      } else {
        print("API Error: ${value.statusCode}");
        change(null, status: RxStatus.error("خطأ في الاتصال: ${value.statusCode}"));
      }
    }).catchError((error) {
      print("API Call Error: $error");
      change(null, status: RxStatus.error("خطأ في الاتصال بالخادم"));
    });
  }
}
