import 'dart:async';

//import 'package:android_studio_projects/screen/card_wizard_overlap.dart' show CardWizardOverlapRoute;
import 'screen/card_wizard_overlap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../router/route_constants.dart';
import '../../screen/allShop/allShop_controller.dart';
import '../../screen/favorite/favorite_controller.dart';
import '../../screen/login/login.dart';
import '../../screen/login/login_model.dart';
import '../../screen/notifications/notifications_contraller.dart';
import '../../screen/section/section_controller.dart';
import '../../screen/sliderAds/ads_controller.dart';
import '../../widget/my_data.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   true;
    GetStorage().read('store')!=null? MyData.auth_user=true:  MyData.auth_user=false;
    // GetStorage().read('store')!=null? MyData.auth_user=true:  MyData.auth_user=false;
    Timer(
        Duration(seconds: 2),
            () =>
            MyData.auth_user? Get.offAllNamed(RoutingApp.dashBoardScreenRoute,):  Get.to(CardWizardOverlapRoute(),transition: Transition.leftToRight,duration:Duration(seconds: 1 )));


    Get.put(sectionController());
    Get.put(adsController());
    Get.put(allShopController());
    Get.put(NotificationsController());
    if(MyData.auth_user){
      late LoginModel loginModle = LoginModel.fromJson(GetStorage().read('store'));
      Get.put(favoriteController()).getFavoriteApi(loginModle.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:   Container(
        height: 1.sh,
    width: 1.sw,
    decoration: BoxDecoration(
    image:DecorationImage(image: AssetImage('assets/splash1.png'),fit: BoxFit.cover,)
    ),),
    );
  }
}
