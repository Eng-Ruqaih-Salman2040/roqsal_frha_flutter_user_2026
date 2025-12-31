import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants.dart';
import '../language/controller/app_language.dart';
import '../screen/about_screen.dart';
import '../screen/card_wizard_overlap.dart';
import '../screen/connect_with_us/connect_with_us.dart';
import '../screen/developer.dart';
import '../screen/login/login.dart';
import '../screen/login/login_model.dart';
import '../screen/notifications/notifications.dart';
import '../screen/notifications/notifications_contraller.dart';
import '../screen/reservations/reservations.dart';
import '../screen/reservations/reservations_controller.dart';
import 'customButton.dart';
import 'dailog_widget.dart';
import 'my_data.dart';
import 'my_text.dart';

class drawerWidget extends StatelessWidget {
  final AppLanguage controller = Get.put(AppLanguage());
  LoginModel loginModle = MyData.auth_user
      ? LoginModel.fromJson(GetStorage().read('store'))
      : LoginModel(id: "0", name: "1");

  @override
  Widget build(BuildContext context) {
    //     loginModle=  LoginModel(id: "0",name: "1");
    //
    // //    loginModle=  MyData.auth_user? LoginModel.fromJson(GetStorage().read('store')):loginModle;

    final isRtl = Localizations.localeOf(context).languageCode == 'ar';
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              child: Stack(
                children: <Widget>[
                  // Image.asset('assets/material_bg_1.png',
                  //   width: double.infinity, height: double.infinity, fit: BoxFit.cover,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 14),
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey[100],
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: AssetImage("assets/prson.png"),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                MyData.auth_user
                                    ? Text(
                                        loginModle.name.toString(),
                                        style: MyText.body2(context)?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "زائر",
                                        style: MyText.body2(context)?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                MyData.auth_user
                                    ? Container(height: 5)
                                    : SizedBox(width: 0),
                                MyData.auth_user
                                    ? Text(
                                        loginModle.phone.toString(),
                                        style: MyText.body2(
                                          context,
                                        )?.copyWith(color: Colors.white),
                                      )
                                    : SizedBox(width: 0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Color(0xFFFFFFFF)),
            Container(height: 8),
            ListTile(
              title: Text(
                "sure".tr,
                style: MyText.subhead(
                  context,
                )?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.article, size: 25.0, color: Colors.white70),
              trailing: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(7),
                ),

                child: Text(
                  MyData.Number_of_Reservations_1,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                if (MyData.auth_user) {
                  LoginModel loginModle = LoginModel.fromJson(
                    GetStorage().read('store'),
                  );
                  print(loginModle.id);
                  Get.put(
                    reservationsController(),
                  ).getReservationsApi(loginModle.id.toString(), "1");
                  Get.to(() => reservationsScreen("الحجوزات المؤكدة"));
                } else {
                  GetSnackMsg(
                    msg: "يجب تسجيل الدخول لاستعراض الحجوزات",
                    bgClr: kColorRed,
                    txClr: kColorsWhite,
                  ).showTxt();
                }
              },
            ),
            // Divider(),
            ListTile(
              title: Text(
                "waitr".tr,
                style: MyText.subhead(
                  context,
                )?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.warning_amber_outlined,
                size: 25.0,
                color: Colors.white70,
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(7),
                ),

                child: Text(
                  MyData.Number_of_Reservations_0,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              onTap: () {
                if (MyData.auth_user) {
                  LoginModel loginModle = LoginModel.fromJson(
                    GetStorage().read('store'),
                  );
                  print(loginModle.id);
                  Get.put(
                    reservationsController(),
                  ).getReservationsApi(loginModle.id.toString(), "0");
                  Get.to(() => reservationsScreen("الحجوزات قيد الانتظار"));
                } else {
                  GetSnackMsg(
                    msg: "يجب تسجيل الدخول لاستعراض الحجوزات",
                    bgClr: kColorRed,
                    txClr: kColorsWhite,
                  ).showTxt();
                }
              },
            ),
            ListTile(
              title: Text(
                "canc".tr,
                style: MyText.subhead(
                  context,
                )?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.stop_circle_outlined,
                size: 25.0,
                color: Colors.white70,
              ),
              trailing: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(7),
                ),

                child: Text(
                  MyData.Number_of_Reservations_2,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                if (MyData.auth_user) {
                  LoginModel loginModle = LoginModel.fromJson(
                    GetStorage().read('store'),
                  );
                  print(loginModle.id);
                  Get.put(
                    reservationsController(),
                  ).getReservationsApi(loginModle.id.toString(), "2");
                  Get.to(() => reservationsScreen("الحجوزات الملغية"));
                } else {
                  GetSnackMsg(
                    msg: "يجب تسجيل الدخول لاستعراض الحجوزات",
                    bgClr: kColorRed,
                    txClr: kColorsWhite,
                  ).showTxt();
                }
              },
            ),
            Divider(color: Color(0xFFFFFFFF)),
            ListTile(
              title: Text(
                "div".tr,
                style: MyText.subhead(
                  context,
                )?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.people_alt,
                size: 25.0,
                color: Colors.white70,
              ),

              onTap: () {
                Get.to(DeveloperRoute());
              },
            ),

            // ListTile(
            //   title: Text("الاشعارات".tr, style: MyText.subhead(context)?.copyWith(
            //       color: Colors.grey[800], fontWeight: FontWeight.bold
            //   )),
            //   leading: Icon(Icons.notifications_active_outlined, size: 25.0, color: Colors.grey[600]),
            //   onTap: (){
            //     Get.put(NotificationsController()).getNotificationsApi();
            //     Get.to(NotificationsScreen());
            //
            //   },
            //   trailing:
            //
            //   Card(
            //       color: Colors.orange,
            //       margin: EdgeInsets.all(0), elevation: 0,
            //       shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(22),),
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       child: Container(width: 25,height: 25,child: Center(child: Text(MyData.Number_of_notifications, style: TextStyle(color: Colors.white))))
            //   ),
            //
            //   // Container(
            //   //   padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            //   //   color: Colors.orange,
            //   //   child: Text("2", style: TextStyle(color: Colors.white)),
            //   // )
            // ),
            // ListTile(
            //   title: Text("Connect with us".tr, style: MyText.subhead(context)?.copyWith(
            //       color: Colors.grey[800], fontWeight: FontWeight.bold
            //   )),
            //   leading: Icon(Icons.call, size: 25.0, color: Colors.grey[600]),
            //   onTap: (){
            //     Get.to(ConnectWithUsScreen());
            //
            //   },
            // ),
            ListTile(
              title: Text(
                "abou".tr,
                style: MyText.subhead(
                  context,
                )?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.mobile_screen_share_sharp,
                size: 25.0,
                color: Colors.white70,
              ),

              onTap: () {
                Get.to(AboutScreen());
              },
            ),
            !isRtl
                ? sliderItem(
                    'عربي'.tr,
                    'assets/icon/language.png',
                    context,
                    () {
                      print('ar');
                      controller.changeLanguage(arabic);

                      Get.updateLocale(Locale(controller.appLocale.value));
                    },
                  )
                : sliderItem(
                    'English'.tr,
                    'assets/icon/language.png',
                    context,
                    () {
                      controller.changeLanguage(english);

                      Get.updateLocale(Locale(controller.appLocale.value));
                    },
                  ),

            SizedBox(height: 10.w),
            Row(
              children: [
                SizedBox(width: 80.w),

                MyData.auth_user == true
                    ? CustomButton(
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        borderColor: Colors.red,
                        text: 'Sign out'.tr,
                        onPress: () {

                          GetStorage().remove('store');

                          Get.to(CardWizardOverlapRoute());
                        },
                        color: Colors.transparent,
                        sizeWidth: 120.w,
                        sizeHeight: 30.w,
                      )
                    : CustomButton(
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(color: Colors.white),
                        borderColor: Colors.greenAccent,
                        text: 'sign in'.tr,
                        onPress: () {
                          GoogleSignIn googleSinIn = GoogleSignIn();
                        googleSinIn.disconnect();
                          GetStorage().remove('store');

                          Get.to(LoginScreen());
                        },
                        color: Colors.transparent,
                        sizeWidth: 120.w,
                        sizeHeight: 30.w,
                      ),
                SizedBox(height: 80.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget sliderItem(
  String title,
  String icons,
  BuildContext context,
  Function() onPress,
) => ListTile(
  title: Text(
    title,
    style: Theme.of(
      context,
    ).textTheme.titleLarge!.copyWith(color: Colors.white),
  ),
  leading: Icon(Icons.language, color: Colors.white70),
  onTap: onPress,
);
