
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apiservice/checkInterNet.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import '../login/login_model.dart';
import 'reserve_shop_model.dart';

class reserveShopController extends GetxController with StateMixin<reserveShopModel> {


  reserveShopModel?connect_with_usModel ;
  late TextEditingController bond_no;
  late TextEditingController booking_date;
  late TextEditingController note;

  late LoginModel loginModle;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    loginModle=   LoginModel.fromJson(GetStorage().read('store'));
    print(loginModle.id);

    bond_no=TextEditingController();
    booking_date=TextEditingController();
    note=TextEditingController();

  }


  postApi(String shop_id,String bank_id,String customers_id){


    // Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)));
    Get.dialog(Center(child: CircularProgressIndicator(),));

    ApiService().postDataForm(url:'?checkopration=Reserve_shop&customers_id=${customers_id.trim()}'+'&bank_id=${bank_id.trim()}'+'&bond_no=${bond_no.text.trim()}'+'&shop_id=${shop_id.trim()}'+'&note=${note.text.trim()}'+'&booking_date=${booking_date.text.trim()}').then((value) {
      if(value.statusCode==200) {
        print(value.data);
        //   print(value.data["success"]);
        reserveShopModel loginModel =  reserveShopModel.fromJson(json.decode(value.data));
        print(value.data);
        print(loginModel.success);
        if(loginModel.success==true){
          //reserveShopModel loginModel =  reserveShopModel.fromJson(json.decode(value.data));
          // Get.back();
          Get.offAllNamed(RoutingApp.dashBoardScreenRoute,);
          print("aaaaa");
          print(value.data);



          update();}else{
          print('errr');
        }


      }
      else{


      }}

    );
  }
}