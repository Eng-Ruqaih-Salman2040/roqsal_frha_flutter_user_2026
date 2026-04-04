
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/checkInterNet.dart';
import '../../screen/section/section_model.dart';
import '../../screen/shop/shop_model.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';

class shopController extends GetxController with StateMixin<shopModel> {

  shopModel? model;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();



  }



  getShopApi(String id){





    change(null, status: RxStatus.loading());
    ApiService().getData('?checkopration=load_Data_shop&section_id=$id').then((value) {


      if(value.statusCode==200) {
        print("aa");

        print(value.data);

        shopModel data =  shopModel.fromJson(json.decode(value.data));


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
}