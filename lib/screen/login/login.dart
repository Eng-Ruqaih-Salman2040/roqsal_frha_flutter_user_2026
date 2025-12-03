

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
import '../../screen/login/login_contraller.dart';

import '../../../Constants.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/menu_widget.dart';
import '../../widget/my_colors.dart';
import '../../widget/my_text.dart';
import '../Sign_Up/sign_up.dart';
import '../notifications/notifications_contraller.dart';
class LoginScreen extends StatelessWidget{

  final _formKey = GlobalKey<FormState>();
  bool _isHidden =true;
  final zoomDrawerController=ZoomDrawerController();
  final LoginController controller=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final isRtl = Localizations.localeOf(context).languageCode=='ar';
    return Scaffold(
        appBar: AppBar(

            title: Text("تسجيل الدخول",style:MyText.title(context)?.copyWith(
              color: Color(0xFFFFFFFF),
              fontSize: 20,
              fontWeight: FontWeight.w800,),),

            actions: <Widget>[

              InkWell(
                onTap: (){
                  Get.offAllNamed(RoutingApp.dashBoardScreenRoute,);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("ضيف", style: TextStyle(color: Colors.white))),
                ),
              )
            ]),

        body:
        SingleChildScrollView(
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: Form(
                key: _formKey,
                child:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 30),
                      Container(
                          child: Center(
                            child: Image.asset(
                              "assets/logoo.png",
                              width: 150, height: 150,
                            ),
                          ) ),
                      Container(height: 15),
                      Text("wlcome".tr, style: MyText.title(context)?.copyWith(
                          color: Color(0xFFAC7FFF),
                          fontWeight: FontWeight.bold
                      )),
                      Container(height: 5),
                      Text("تسجيل الدخول", style: MyText.subhead(context)?.copyWith(
                          color: Colors.white,

                          fontWeight: FontWeight.bold
                      )),

                      TextFieldWidget(
                        controller: controller.name,
                        hint: 'اسم المستخدم',
                        requirement: true,
                        iconData: Icons.person,
                        maxLine: 1,
                        minLine: 1,
                      ),
                      TextFieldWidget(
                        controller: controller.password,
                        // text: 'Password'.tr,
                        hint: 'Password'.tr,
                        requirement: true,
                        iconData: Icons.lock,
                        maxLine: 1,
                        minLine: 1,
                        //  inkell: InkWell(child: Icon(_isHidden?Icons.visibility_off:Icons.remove_red_eye,color:kColorsWhite,size: 35.r,),onTap: _togglePasswordView,),
                        isHidden: true,
                      ),
                      Container(height: 20),
                      CustomButton(
                        text: 'Sign in'.tr,
                        color:  Color(0xFFAC7FFF),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            //  GetStorage().write(token,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsTmFtZSI6Itix2KPZgdiqIiwiR3JvdXBfSUQiOiIyMCIsIkN1c3RvbWVyX0lEIjoiMjM1MSIsIlVTRVJfSUQiOiIxODI0MCIsIkRlcHRfSUQiOiIwIiwiQlJBTkNIU19JRCI6IjEiLCJCcmFuY2hfSUQiOiIxIiwiTG9jYXRpb24iOiIwIiwiRmFjaWxpdHlfSUQiOiIxIiwiRmluX1llYXIiOiIyMSIsIkVycFVybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjAwNjkvIiwiREJVcmwiOiIxMzQuMTE5LjIxNy4xMzkiLCJEQk5hbWUiOiJzczRpdGxnbl9FUlAiLCJEQlVzZXJuYW1lIjoic2EiLCJEQlBhc3N3b3JkIjoiU1M0SVRAU3RhbmQjOUAjIiwiVXNlcl9UeXBlIjoiY3VzdG9tZXIiLCJVc2VyX1R5cGVfSUQiOiIyIiwibmJmIjoxNjM3NDgyNzE4LCJleHAiOjI1ODQxNjc1MTgsImlhdCI6MTYzNzQ4MjcxOH0.mBmkFV_yElKgOpffDdj2a71iA_PZ93JjTYlX9o91xRo' );
                            controller.loginApi();

                          }

                        },
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          child: Text("مستخدم جديد؟ اشتراك.......",
                            style: TextStyle(color: Color(0xFF4697FF)),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,),
                          onPressed: () {
                            Get.to(signUpScreen());
                          },
                        ),
                      ),
                      Container(height: 50),
                    ],
                  ),
                ),


                // Container(
                //   width: double.infinity,
                //   child: FlatButton(
                //     child: Text("تسجيل الدخول",
                //       style: TextStyle(color: Colors.white),),
                //     color: Color(0xFF16AE94),
                //     onPressed: () {
                //       if (_formKey.currentState!.validate()) {
                //         controller.loginApi();
                //       }
                //     },
                //   ),
                // ),



              ),
            ),
          ),
        )

    );


  }


// _togglePasswordView() {
//   setState(() {
//     _isHidden = !_isHidden;
//     print(_isHidden);
//   });
// }
}
