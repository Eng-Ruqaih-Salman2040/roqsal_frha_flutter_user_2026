
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/checkInterNet.dart';
import '../../screen/section/section_model.dart';
import '../../screen/shop/shop_model.dart';
import '../../screen/shop_details/shop_details_model.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';

class shopDetailsController extends GetxController with StateMixin<shopDetailsModel> {

  shopDetailsModel? model;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();



  }



  getGalleryApi(String id,String customers_id){

    change(null, status: RxStatus.loading());
    ApiService().getData('?checkopration=gallery&shop_id=${id}'+'&customers_id=${customers_id}').then((value) {


      if(value.statusCode==200) {
        print("aa");

        print(value.data);

        shopDetailsModel data =  shopDetailsModel.fromJson(json.decode(value.data));


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