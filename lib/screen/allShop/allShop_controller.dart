/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/checkInterNet.dart';
import '../../screen/section/section_model.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import 'allShop_model.dart';

class allShopController extends GetxController with StateMixin<allShopModel> {

  allShopModel? model;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getAll_sectionApi();



  }

  @override
  void onReady() {

    super.onReady();
    ever( Get.find<CheckInterNet>().connectionInterNet, (_)async {
      if(Get.find<CheckInterNet>().connectionInterNet.value!=0) {
        await getAll_sectionApi();
      }
    });
  }

  getAll_sectionApi(){



    change(null, status: RxStatus.loading());
    ApiService().getData('?checkopration=load_Data_All_section').then((value) {


      if(value.statusCode==200) {
 print("aa");

print(value.data);

 allShopModel data =  allShopModel.fromJson(json.decode(value.data));


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
import '../../apiservice/api_service.dart';
import '../../apiservice/checkInterNet.dart';
import 'allShop_model.dart';

class allShopController extends GetxController with StateMixin<allShopModel> {

  allShopModel? model;

  @override
  void onInit() async {
    super.onInit();
    await getAll_sectionApi();
  }

  @override
  void onReady() {
    super.onReady();
    ever(Get.find<CheckInterNet>().connectionInterNet, (_) async {
      if (Get.find<CheckInterNet>().connectionInterNet.value != 0) {
        await getAll_sectionApi();
      }
    });
  }

  getAll_sectionApi() {
    change(null, status: RxStatus.loading());

    ApiService().getData('?checkopration=load_Data_All_section').then((value) {
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

          allShopModel data = allShopModel.fromJson(responseData);
          print("Parsed data successfully");

          // Check if sections are empty
          if (data.section == null || data.section!.isEmpty) {
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
