

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../router/route_constants.dart';
import '../../screen/Sign_Up/sign_up_contraller.dart';
import '../../screen/login/login_contraller.dart';

import '../../../Constants.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/menu_widget.dart';
import '../../widget/my_colors.dart';
import '../../widget/my_text.dart';
import '../Sign_Up/sign_up.dart';
import '../notifications/notifications_contraller.dart';
class signUpScreen extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  bool _isHidden =true;
  final zoomDrawerController=ZoomDrawerController();
  final signUpController controller=Get.put(signUpController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final isRtl = Localizations.localeOf(context).languageCode=='ar';
    return
      Scaffold(

        appBar: AppBar(
          title: Text("انشاء حساب"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),

        body:  SingleChildScrollView(
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Form(
                key:  _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFieldWidget(
                        controller: controller.name,
                        hint: 'اسم المستخدم',
                        requirement: true,
                        iconData: Icons.person,
                        textInputType: TextInputType.text,
                        maxLine: 1,
                        minLine: 1,
                      ),
                      TextFieldWidget(
                        controller: controller.pass,
                        // text: 'Password'.tr,
                        hint: 'Password'.tr,
                        requirement: true,
                        iconData: Icons.lock,
                        maxLine: 1,
                        minLine: 1,
                        //  inkell: InkWell(child: Icon(_isHidden?Icons.visibility_off:Icons.remove_red_eye,color:kColorsWhite,size: 35.r,),onTap: _togglePasswordView,),
                        isHidden: true,
                      ),
                      Container(height: 10),
                      TextFieldWidget(
                        controller: controller.email,
                        hint: 'البريد الالكتروني',
                        requirement: true,
                        textInputType: TextInputType.emailAddress,
                        iconData: Icons.email,
                        maxLine: 1,
                        minLine: 1,
                      ),
                      Container(height: 10),
                      TextFieldWidget(
                        controller: controller.phone,
                        hint: 'رقم الجوال',
                        requirement: true,
                        iconData: Icons.phone,
                        maxLine: 1,
                        minLine: 1,
                      ),
                      Container(height: 10),
                      CustomButton(
                        text: 'تسجيل',
                        color:  Color(0xFF9169DA),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            //  GetStorage().write(token,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsTmFtZSI6Itix2KPZgdiqIiwiR3JvdXBfSUQiOiIyMCIsIkN1c3RvbWVyX0lEIjoiMjM1MSIsIlVTRVJfSUQiOiIxODI0MCIsIkRlcHRfSUQiOiIwIiwiQlJBTkNIU19JRCI6IjEiLCJCcmFuY2hfSUQiOiIxIiwiTG9jYXRpb24iOiIwIiwiRmFjaWxpdHlfSUQiOiIxIiwiRmluX1llYXIiOiIyMSIsIkVycFVybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjAwNjkvIiwiREJVcmwiOiIxMzQuMTE5LjIxNy4xMzkiLCJEQk5hbWUiOiJzczRpdGxnbl9FUlAiLCJEQlVzZXJuYW1lIjoic2EiLCJEQlBhc3N3b3JkIjoiU1M0SVRAU3RhbmQjOUAjIiwiVXNlcl9UeXBlIjoiY3VzdG9tZXIiLCJVc2VyX1R5cGVfSUQiOiIyIiwibmJmIjoxNjM3NDgyNzE4LCJleHAiOjI1ODQxNjc1MTgsImlhdCI6MTYzNzQ4MjcxOH0.mBmkFV_yElKgOpffDdj2a71iA_PZ93JjTYlX9o91xRo' );
                            controller.postApi();

                          }

                        },
                      ),
                      Container(height: 10),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      );


  }


// _togglePasswordView() {
//   setState(() {
//     _isHidden = !_isHidden;
//     print(_isHidden);
//   });
// }
}
