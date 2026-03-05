
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/checkInterNet.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import 'connect_with_us_model.dart';

class connect_with_usController extends GetxController with StateMixin<Connect_with_usModel> {


  Connect_with_usModel?connect_with_usModel ;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController subject;
  late TextEditingController message;

  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    name=TextEditingController();
    email=TextEditingController();
    subject=TextEditingController();
    message=TextEditingController();

  }


  postApi(){


    // Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)));
    Get.dialog(Center(child: CircularProgressIndicator(),));

    ApiService().postDataForm(url:'?checkopration=Technical_Support&students_id=1'+'&name=${name.text.trim()}'+'&email=${email.text.trim()}'+'&subject=${subject.text.trim()}'+'&message=${message.text.trim()}').then((value) {
      if(value.statusCode==200) {
        print(value.data);
        //   print(value.data["success"]);
        Connect_with_usModel loginModel =  Connect_with_usModel.fromJson(json.decode(value.data));
        print(value.data);
        print(loginModel.success);
        if(loginModel.success==true){
          Connect_with_usModel loginModel =  Connect_with_usModel.fromJson(json.decode(value.data));
          Get.back();
          //Get.offAllNamed(RoutingApp.dashBoardScreenRoute,);
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