
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../Constants.dart';
import '../language/controller/app_language.dart';
import '../screen/about_screen.dart';
import '../screen/card_wizard_overlap.dart';
import '../screen/connect_with_us/connect_with_us.dart';
import '../screen/developer.dart';

import '../screen/login/login_model.dart';
import '../screen/notifications/notifications.dart';
import '../screen/notifications/notifications_contraller.dart';
import '../screen/reservations/reservations.dart';
import '../screen/reservations/reservations_controller.dart';
import 'customButton.dart';
class MenuWidgetLogin extends StatefulWidget {

  final ZoomDrawerController zoomDrawerController;
  MenuWidgetLogin({Key? key,required this.zoomDrawerController}) : super(key: key);

  @override
  State<MenuWidgetLogin> createState() => _MenuWidgetLoginState();
}

class _MenuWidgetLoginState extends State<MenuWidgetLogin> with TickerProviderStateMixin {
  final AppLanguage controller = Get.put(AppLanguage());
  bool expand1 = false, expand2 = false, expand3 = false;
  late AnimationController controller1, controller2, controller3;
  late Animation<double> animation1, animation1View;
  late Animation<double> animation2, animation2View;
  late Animation<double> animation3, animation3View;
  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);
    controller2 = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);
    controller3 = AnimationController(vsync: this, duration: Duration(milliseconds: 200),);

    animation1 = Tween(begin: 0.0, end: 180.0).animate(controller1);
    animation1View = CurvedAnimation(parent: controller1, curve: Curves.linear);

    animation2 = Tween(begin: 0.0, end: 180.0).animate(controller2);
    animation2View = CurvedAnimation(parent: controller2, curve: Curves.linear);

    animation3 = Tween(begin: 0.0, end: 180.0).animate(controller3);
    animation3View = CurvedAnimation(parent: controller3, curve: Curves.linear);

    controller1.addListener(() { setState(() {}); });
    controller2.addListener(() { setState(() {}); });
    controller3.addListener(() { setState(() {}); });

  }
  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode=='ar';
    return SingleChildScrollView(
      child: Container(
        //color: kColorRed,
        alignment: Alignment.topCenter,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

         Container(

           width: .45.sw,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,

             children: [
           // CircleAvatar(radius: 50.r,backgroundColor: kColorsWhite,),
             SizedBox(
               height: 20.h,
             ),
            Row(
              children: [
                Image.asset('assets/.png',width: 150.w,height: 120.w,),
              ],
            ),


               Text(
                 'فرحة',
               style:
                  Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite)
                  ),
               SizedBox(
                 height: 10.h,
               ),

               Divider(color: kColorsWhite,)
           ],),
         ),
            SizedBox(
              height: 20,
            ),
            // sliderItem('الرئيسية'.tr, 'assets/home.png',context,(){
            //   zoomDrawerController.close!();
            //
            //
            // })
            ListTile(
                title: Text(
                    "حجوزاتي",
                    style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                ),
                leading:Icon(Icons.arrow_drop_down,color: kColorsWhite,),
                onTap:(){
                  togglePanel3();
                  // Get.to(DeveloperRoute());
                }),
            SizeTransition(
              sizeFactor: animation3View,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 20),
                        Flexible(flex: 1, child:
                        ListTile(
                            title: Text(
                                "حجوزات مؤكدة",
                                style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                            ),
                            leading:Icon(Icons.article,color: kColorsWhite,),

                            onTap:(){
                              LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                              print(loginModle.id);

                              Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"1");
                              Get.to(() => reservationsScreen("الحجوزات المؤكدة"));
                            }),
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 20),
                        Flexible(flex: 1, child:
                        ListTile(
                            title: Text(
                                "حجوزات قيد الانتظار",
                                style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                            ),
                            leading:Icon(Icons.warning_amber_outlined,color: kColorsWhite,),

                            onTap:(){
                              LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                              print(loginModle.id);
                              Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"0");
                              Get.to(() => reservationsScreen("الحجوزات قيد الانتظار"));

                            }),
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(width: 20),
                        Flexible(flex: 1, child:
                        ListTile(
                            title: Text(
                                "حجوزات ملغية",
                                style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                            ),
                            leading:Icon(Icons.stop_circle_outlined,color: kColorsWhite,),

                            onTap:(){
                              LoginModel  loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                              print(loginModle.id);
                              Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"2");
                              Get.to(() => reservationsScreen("الحجوزات الملغية"));

                            }),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),

            ListTile(
                title: Text(
                    "المطورون".tr,
                    style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                ),
                leading:Icon(Icons.people_alt,color: kColorsWhite,),
                onTap:(){
                  widget.zoomDrawerController.close!();
                  Get.to(DeveloperRoute());
                }),

            ListTile(
                title: Text(
                    "الاشعارات".tr,
                    style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                ),
                leading:Icon(Icons.notifications_active_outlined,color: kColorsWhite,),
                onTap:(){
                  widget.zoomDrawerController.close!();
                  Get.put(NotificationsController()).getNotificationsApi();
                  Get.to(NotificationsScreen());



                }),



            ListTile(
                title: Text(
                    "Connect with us".tr,
                    style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                ),
                leading:Icon(Icons.call,color: kColorsWhite,),
                onTap:(){
                  togglePanel3();
                  widget.zoomDrawerController.close!();
                  Get.to(ConnectWithUsScreen());
                }),


            ListTile(
                title: Text(
                    "حول التطبيق".tr,
                    style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
                ),
                leading:Icon(Icons.mobile_screen_share_sharp,color: kColorsWhite,),
                onTap:(){
                  widget.zoomDrawerController.close!();
                  Get.to(AboutScreen());

                }),

            !isRtl? sliderItem('عربي'.tr,'assets/icon/language.png',context,(){
               print('ar');
              controller.changeLanguage(arabic);

              Get.updateLocale(Locale(controller.appLocale.value));
            }):sliderItem('English'.tr,'assets/icon/language.png',context,(){

              controller.changeLanguage(english);

              Get.updateLocale(Locale(controller.appLocale.value));
            }),

            SizedBox(
              height: 30.w,
            ),
            Row(

              children: [
                SizedBox(width: 20.w,),
                CustomButton(style:  Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite),borderColor: kColorsOrange,text: 'Sign out'.tr,onPress: () {


                  GetStorage().remove('store');

                  Get.to(CardWizardOverlapRoute());


                },color: Colors.transparent,sizeWidth: 120.w,sizeHeight: 30.w,),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget sliderItem(String title, String icons ,BuildContext context,Function() onPress) => ListTile(
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsWhite)
      ),
      leading:Icon(Icons.language,color: kColorsWhite,),
      onTap:onPress);


  void togglePanel1(){
    if(!expand1){
      controller1.forward();
    } else {
      controller1.reverse();
    }
    expand1 = !expand1;
  }

  void togglePanel2(){
    if(!expand2){
      controller2.forward();
    } else {
      controller2.reverse();
    }
    expand2 = !expand2;
  }

  void togglePanel3(){
    if(!expand3){
      controller3.forward();
    } else {
      controller3.reverse();
    }
    expand3 = !expand3;
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}
