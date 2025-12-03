import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetSnackMsg{

  String msg;
  Color bgClr;
  Color txClr;
  GetSnackMsg({required this.msg,this.bgClr=Colors.red,this.txClr=Colors.white, });
  showTxt(){
    return Get.showSnackbar(GetBar(
      messageText: Text(
         msg,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
      //padding: const EdgeInsets.symmetric(vertical: 10),
     // margin: EdgeInsets.all(20.r),
      duration: const Duration(milliseconds: 2000),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: bgClr,
      //borderRadius: 20.r,
      //reverseAnimationCurve: Curves.easeOutBack,
      //forwardAnimationCurve: Curves.easeOutBack,

      //animationDuration: const Duration(seconds: 1),
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}