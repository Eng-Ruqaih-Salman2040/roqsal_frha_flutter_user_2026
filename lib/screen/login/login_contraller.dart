/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../apiservice/checkInterNet.dart';
import '../../Constants.dart';
import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {


  LoginModel?levelsModel ;
  late TextEditingController name;
  late TextEditingController password;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

name=TextEditingController();
password=TextEditingController();

  }


  loginApi(){


Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)),);

    ApiService().postDataLogin(url:'?checkopration=Login&name=${name.text.trim()}'+'&password=${password.text.trim()}').then((value) {
      Get.back();
      if(value.statusCode==200) {
    //    print(value.data);
     //   print(value.data["success"]);
        LoginModel loginModel =  LoginModel.fromJson(json.decode(value.data));
        print(value.data);
        print(loginModel.success);
if(loginModel.success==true){
       GetStorage().write('store', loginModel.toJson());
       MyData.auth_user=true;

        Get.toNamed(RoutingApp.dashBoardScreenRoute,);

        print(value.data);



        update();}else{
  LoginModel loginModel =  LoginModel.fromJson(json.decode(value.data));
  print(value.data);
  print(loginModel.success);
  GetSnackMsg(msg:loginModel.message.toString() ,bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();

  print('errr');
}


      }
      else{


      }}

    );
  }
}*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../apiservice/checkInterNet.dart';
import '../../Constants.dart';
import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import 'login_model.dart';

class LoginController extends GetxController with StateMixin<LoginModel> {
  LoginModel? levelsModel;
  late TextEditingController name;
  late TextEditingController password;

  @override
  void onInit() async {
    super.onInit();
    name = TextEditingController();
    password = TextEditingController();
  }

  loginApi() {
    Get.dialog(
      Center(
        child: Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );

    ApiService().postDataLogin(
        url: '?checkopration=Login&name=${name.text.trim()}&password=${password.text.trim()}'
    ).then((value) {
      Get.back();
      if (value.statusCode == 200) {
        try {
          print("Raw response: ${value.data}");

          // Handle different response formats
          dynamic responseData;
          if (value.data is String) {
            responseData = json.decode(value.data);
          } else {
            responseData = value.data;
          }

          LoginModel loginModel = LoginModel.fromJson(responseData);
          print("Parsed success: ${loginModel.success}");
          print("Parsed message: ${loginModel.message}");

          if (loginModel.success == true) {
            GetStorage().write('store', loginModel.toJson());
            MyData.auth_user = true;
            Get.toNamed(RoutingApp.dashBoardScreenRoute);
          } else {
            GetSnackMsg(
                msg: loginModel.message.toString(),
                bgClr: kColorRed,
                txClr: kColorsWhite
            ).showTxt();
          }
        } catch (e) {
          print("Error parsing response: $e");
          GetSnackMsg(
              msg: "خطأ في معالجة الاستجابة",
              bgClr: kColorRed,
              txClr: kColorsWhite
          ).showTxt();
        }
      } else {
        GetSnackMsg(
            msg: "خطأ في الاتصال: ${value.statusCode}",
            bgClr: kColorRed,
            txClr: kColorsWhite
        ).showTxt();
      }
    }).catchError((error) {
      Get.back();
      print("API Error: $error");
      GetSnackMsg(
          msg: "خطأ في الاتصال بالخادم",
          bgClr: kColorRed,
          txClr: kColorsWhite
      ).showTxt();
    });
  }
}
