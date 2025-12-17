
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../apiservice/checkInterNet.dart';

import '../../Constants.dart';
import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/route_constants.dart';
import '../../widget/dailog_widget.dart';
import '../login/login.dart';
import 'sign_up_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
class signUpController extends GetxController with StateMixin<signUpModel> {



  signUpModel?signModel ;
  late TextEditingController name;
  late TextEditingController pass;
  late TextEditingController phone;
  late TextEditingController email;

  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    name=TextEditingController();
    pass=TextEditingController();
    phone=TextEditingController();
    email=TextEditingController();

  }


  postApi(){

   // Get.dialog(Center(child: Container(height: 100,width: 100,child: CircularProgressIndicator(),)));
   //   Get.dialog(Center(child: CircularProgressIndicator(),));

     Get.dialog(Center(
       child: Container(
         width: 80.w,
         height: 80.w,
         child: Center(child: LoadingIndicator(
           indicatorType: Indicator.ballPulseSync, /// Required, The loading type of the widget
           colors: const [kColorsPrimary],       /// Optional, The color collections
           /// Optional, The stroke of the line, only applicable to widget which contains line
           /// Optional, the stroke backgroundColor
         ),),
       ),
     ));

    // showDialog(context: ,builder: (_) => CustomEventDialog() );
    ApiService().postDataForm(url:'?checkopration=Sign_Up&name=${name.text.trim()}'+'&pass=${pass.text.trim()}'+'&phone=${phone.text.trim()}'+'&email=${email.text.trim()}').then((value) {
      print('errruu');
     // Get.back();
      //  loginErrorModel=LoginErrorModel.fromJson(value.data);
   //   GetSnackMsg(msg: "hg",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
      print(value.data);
      if(value.statusCode==200) {
        print(value.data);
     //   print(value.data["success"]);
        signUpModel loginModel =  signUpModel.fromJson(json.decode(value.data));
     //   print(value.data);
        print(loginModel.success);
if(loginModel.success==true){
 // signUpModel loginModel =  signUpModel.fromJson(json.decode(value.data));
  Get.back();
  change(null,status: RxStatus.success());
  Get.to(LoginScreen());
  // Get.offAllNamed(RoutingApp.dashBoardScreenRoute,);
  print("aaaaa");
        print(value.data);



        update();}else{
  print('errrd');
}


      }
      else{
        print('ff');
        Get.back();
      //  loginErrorModel=LoginErrorModel.fromJson(value.data);
      //   GetSnackMsg(msg: "hg",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
        print(value.data);
      }}

    );
  }
}