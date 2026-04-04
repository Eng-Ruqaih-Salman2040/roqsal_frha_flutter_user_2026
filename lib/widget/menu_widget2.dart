import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  LoginModel loginModle=MyData.auth_user? LoginModel.fromJson(GetStorage().read('store')):LoginModel(id: "0",name: "1");

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    final primaryColor = kColorsPrimary ?? Color(0xFF6C63FF);
    final backgroundColor = Colors.white;
    final textColor = Color(0xFF2D3748);
    final secondaryTextColor = Color(0xFF718096);
    final dividerColor = Colors.grey[200]!;

    //     loginModle=  LoginModel(id: "0",name: "1");
    //
    // //    loginModle=  MyData.auth_user? LoginModel.fromJson(GetStorage().read('store')):loginModle;

    final isRtl = Localizations.localeOf(context).languageCode=='ar';
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              child: Stack(
                children: <Widget>[            _buildHeader(context, primaryColor, textColor, secondaryTextColor),
                  SizedBox(width: 0,),

                  // Image.asset('assets/material_bg_1.png',
                  //   width: double.infinity, height: double.infinity, fit: BoxFit.cover,
                  // ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MyData.auth_user ? Text(loginModle.name.toString(), style: MyText.body2(context)?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)):Text("زائر", style: MyText.body2(context)?.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
                                  MyData.auth_user ? Container(height: 5):SizedBox(width: 0,),
                                  MyData.auth_user ? Text(loginModle.phone.toString(), style: MyText.body2(context)?.copyWith(
                                      color: Colors.white
                                  )):SizedBox(width: 0,)

                                ],
                              ),
                            ),

                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),

            Container(height: 8),
            ListTile(
              title: Text("حجوزات مؤكدة", style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.bold
              )),

              leading: Icon(Icons.check_circle_outline_rounded,
                color: Colors.green,),
              trailing: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                color: Colors.green.withOpacity(0.6),
                child: Text(MyData.Number_of_Reservations_1, style: TextStyle(color: Colors.white)),
              ),
              onTap: (){

                if(MyData.auth_user){
                  LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                  print(loginModle.id);
                  Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"1");
                  Get.to(() => reservationsScreen("الحجوزات المؤكدة"));
                }else{
                  GetSnackMsg(msg: "يجب تسجيل الدخول لاستعراض الحجوزات",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
                }

              },
            ),
            // Divider(),
            ListTile(
              title: Text("حجوزات قيد الانتظار", style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.bold
              )),
              leading: Icon( Icons.access_time_rounded,
                color: Colors.amber,),
              trailing: Container(

                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                color: Colors.yellowAccent.withOpacity(0.5),
                child: Text(MyData.Number_of_Reservations_0, style: TextStyle(color: Colors.black87)),
              ),
              onTap: (){

                if(MyData.auth_user){
                  LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                  print(loginModle.id);
                  Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"0");
                  Get.to(() => reservationsScreen("الحجوزات قيد الانتظار"));

                }else{
                  GetSnackMsg(msg: "يجب تسجيل الدخول لاستعراض الحجوزات",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
                }

              },
            ),
            ListTile(
              title: Text("حجوزات ملغية", style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.bold
              )),
              leading: Icon(Icons.cancel_outlined,
                color: Colors.red,),
              trailing: Container(


                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                color: Colors.red.withOpacity(0.5),


                child: Text(MyData.Number_of_Reservations_2, style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold)),

              ),
              onTap: (){
                if(MyData.auth_user){
                  LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
                  print(loginModle.id);
                  Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"2");
                  Get.to(() => reservationsScreen("الحجوزات الملغية"));

                }else{
                  GetSnackMsg(msg: "يجب تسجيل الدخول لاستعراض الحجوزات",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
                }
              },
            ),
            Divider(),
            ListTile(
              title: Text("المطورون".tr, style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.bold
              )),
              leading: Icon(Icons.people_alt_rounded, size: 25.0, color: Colors.grey[600]),

              onTap: (){
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
              title: Text( "حول التطبيق".tr, style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[800], fontWeight: FontWeight.bold
              )),
              leading: Icon(Icons.info_outline_rounded, size: 25.0, color: Colors.grey[600]),

              onTap: (){
                Get.to(AboutScreen());
              },
            ),
            !isRtl? sliderItem('عربي'.tr,'assets/icon/language.png',context,(){
              print('ar');
              controller.changeLanguage(arabic);

              Get.updateLocale(Locale(controller.appLocale.value));
            }):sliderItem('English'.tr,'assets/icon/language.png',context,(){

              controller.changeLanguage(english);

              Get.updateLocale(Locale(controller.appLocale.value));
            }),

            SizedBox(
              height: 10.w,
            ),
            Row(

              children: [
                SizedBox(width: 80.w,),

                MyData.auth_user==true?

                CustomButton(style:  Theme.of(context).textTheme.titleLarge!.copyWith(color:  Color(
                    0xffe32626)),borderColor: Color(
                    0xffe32626),text: 'Sign out'.tr,onPress: () {


                  GetStorage().remove('store');

                  Get.to(CardWizardOverlapRoute());


                }


                  ,color: Colors.transparent,sizeWidth: 120.w,sizeHeight: 30.w,)
                    :  CustomButton(style:  Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsPrimary),borderColor:  Color(
                    0xffe32626),text: 'sign in'.tr,
                  onPress: () {


                    GetStorage().remove('store');

                    Get.to(LoginScreen());


                  }


                  ,color: Colors.transparent,sizeWidth: 120.w,sizeHeight: 30.w,)


                ,
                SizedBox(height: 80.w,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

Widget sliderItem(String title, String icons ,BuildContext context,Function() onPress) => ListTile(
    title: Text(
        title,
        style:
        Theme.of(context).textTheme.titleLarge!.copyWith(color: kColorsBlack)
    ),
    leading:Icon(Icons.language,color: kColorsBlack,),
    onTap:onPress);
// ✅ Header محسّن مع خلفية متدرجة
Widget _buildHeader(BuildContext context, Color primaryColor,
    Color textColor, Color secondaryTextColor) {
  return Container(
    height: 190.h,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor,
          primaryColor.withOpacity(0.8),
          Color(0xFF5A52D9),
        ],
      ),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(24),
      ),
    ),
    child: Stack(
      children: [
        // خلفية بنقوش خفيفة (اختياري)
        Positioned(
          right: -20.w,
          top: -20.h,
          child: Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        Positioned(
          left: -30.w,
          bottom: -30.h,
          child: Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
        ),

        // صورة المستخدم
        Positioned(
          top: 30.h,
          right: 14.w,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 36.r,
              backgroundColor: Colors.grey[100],
              child: CircleAvatar(
                radius: 33.r,
                backgroundImage: const AssetImage("assets/prson.png"),

              ),
            ),
          ),
        ),



      ],
    ),
  );
}


/////////////////////////////////////////////////////


//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:badges/badges.dart' as badges;
//
// import '../Constants.dart';
// import '../language/controller/app_language.dart';
// import '../screen/about_screen.dart';
// import '../screen/card_wizard_overlap.dart';
// import '../screen/developer.dart';
// import '../screen/login/login.dart';
// import '../screen/login/login_model.dart';
// import '../screen/reservations/reservations.dart';
// import '../screen/reservations/reservations_controller.dart';
// import 'customButton.dart';
// import 'dailog_widget.dart';
// import 'my_data.dart';
// import 'my_text.dart';
//
// class drawerWidget extends StatelessWidget {
//   final AppLanguage controller = Get.put(AppLanguage());
//   late LoginModel loginModel;
//
//   drawerWidget({Key? key}) {
//     loginModel = MyData.auth_user
//         ? LoginModel.fromJson(GetStorage().read('store'))
//         : LoginModel(id: "0", name: "زائر");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isRtl = Localizations.localeOf(context).languageCode == 'ar';
//     final theme = Theme.of(context);
//     final primaryColor = kColorsPrimary ?? Color(0xFF6C63FF);
//     final backgroundColor = Colors.white;
//     final textColor = Color(0xFF2D3748);
//     final secondaryTextColor = Color(0xFF718096);
//     final dividerColor = Colors.grey[200]!;
//
//     return Drawer(
//       width: MediaQuery.of(context).size.width * 0.85,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(24),
//           bottomRight: Radius.circular(24),
//         ),
//       ),
//       elevation: 0,
//       child: Container(
//         color: backgroundColor,
//         child: Column(
//           children: [
//             // Header مع صورة المستخدم (محسّن)
//             _buildHeader(context, primaryColor, textColor, secondaryTextColor),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 padding: EdgeInsets.symmetric(vertical: 8.h),
//                 child: Column(
//                   children: [
//                     // قسم الحجوزات
//                     _buildSectionTitle('الحجوزات', context),
//                     SizedBox(height: 8.h),
//
//                     _buildReservationItem(
//                       context: context,
//                       title: 'حجوزات مؤكدة',
//                       icon: Icons.check_circle_outline_rounded,
//                       count: MyData.Number_of_Reservations_1,
//                       color: Colors.green,
//                       status: '1',
//                       textColor: textColor,
//                     ),
//
//                     _buildReservationItem(
//                       context: context,
//                       title: 'حجوزات قيد الانتظار',
//                       icon: Icons.access_time_rounded,
//                       count: MyData.Number_of_Reservations_0,
//                       color: Colors.amber,
//                       status: '0',
//                       textColor: textColor,
//                     ),
//
//                     _buildReservationItem(
//                       context: context,
//                       title: 'حجوزات ملغية',
//                       icon: Icons.cancel_outlined,
//                       count: MyData.Number_of_Reservations_2,
//                       color: Colors.red,
//                       status: '2',
//                       textColor: textColor,
//                     ),
//
//                     _buildDivider(dividerColor),
//
//                     // قسم التطبيق
//                     _buildSectionTitle('التطبيق', context),
//                     SizedBox(height: 8.h),
//
//                     _buildMenuItem(
//                       context: context,
//                       title: 'المطورون',
//                       icon: Icons.people_alt_rounded,
//                       iconColor: Color(0xFF6C63FF),
//                       onTap: () => Get.to(DeveloperRoute()),
//                       textColor: textColor,
//                       secondaryTextColor: secondaryTextColor,
//                     ),
//
//                     _buildMenuItem(
//                       context: context,
//                       title: 'حول التطبيق',
//                       icon: Icons.info_outline_rounded,
//                       iconColor: Color(0xFF36B37E),
//                       onTap: () => Get.to(AboutScreen()),
//                       textColor: textColor,
//                       secondaryTextColor: secondaryTextColor,
//                     ),
//
//                     _buildDivider(dividerColor),
//
//                     // تغيير اللغة
//                     _buildMenuItem(
//                       context: context,
//                       title: isRtl ? 'English' : 'عربي',
//                       icon: Icons.language_rounded,
//                       iconColor: Color(0xFF9575CD),
//                       onTap: () {
//                         if (isRtl) {
//                           controller.changeLanguage('en');
//                         } else {
//                           controller.changeLanguage('ar');
//                         }
//                         Get.updateLocale(Locale(controller.appLocale.value));
//                         Navigator.pop(context);
//                       },
//                       textColor: textColor,
//                       secondaryTextColor: secondaryTextColor,
//                     ),
//
//                     SizedBox(height: 20.h),
//
//                     // زر تسجيل الدخول/الخروج (محسّن)
//                     _buildAuthButton(context, primaryColor),
//
//                     SizedBox(height: 20.h),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ Header محسّن مع خلفية متدرجة
//   Widget _buildHeader(BuildContext context, Color primaryColor,
//       Color textColor, Color secondaryTextColor) {
//     return Container(
//       height: 190.h,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             primaryColor,
//             primaryColor.withOpacity(0.8),
//             Color(0xFF5A52D9),
//           ],
//         ),
//         borderRadius: const BorderRadius.only(
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Stack(
//         children: [
//           // خلفية بنقوش خفيفة (اختياري)
//           Positioned(
//             right: -20.w,
//             top: -20.h,
//             child: Container(
//               width: 120.w,
//               height: 120.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.1),
//               ),
//             ),
//           ),
//           Positioned(
//             left: -30.w,
//             bottom: -30.h,
//             child: Container(
//               width: 150.w,
//               height: 150.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.05),
//               ),
//             ),
//           ),
//
//           // صورة المستخدم
//           Positioned(
//             top: 40.h,
//             right: 14.w,
//             child: Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 3.w,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 8.r,
//                     offset: Offset(0, 4.h),
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 radius: 36.r,
//                 backgroundColor: Colors.grey[100],
//                 child: CircleAvatar(
//                   radius: 33.r,
//                   backgroundImage: const AssetImage("assets/prson.png"),
//                   onBackgroundImageError: (_, __) {},
//                   child: const Icon(Icons.person, size: 30),
//                 ),
//               ),
//             ),
//           ),
//
//           // معلومات المستخدم
//           Positioned(
//             bottom: 18.h,
//             left: 20.w,
//             right: 20.w,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   MyData.auth_user ? loginModel.name.toString() : "زائر",
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//                 if (MyData.auth_user && loginModel.phone != null) ...[
//                   SizedBox(height: 4.h),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.phone_rounded,
//                         size: 14.sp,
//                         color: Colors.white70,
//                       ),
//                       SizedBox(width: 6.w),
//                       Text(
//                         loginModel.phone.toString(),
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ✅ عنوان القسم
//   Widget _buildSectionTitle(String title, BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 13.sp,
//               color: Color(0xFF718096),
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//             ),
//           ),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: Divider(
//               color: Colors.grey[200],
//               thickness: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ✅ خط فاصل
//   Widget _buildDivider(Color dividerColor) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//       child: Divider(
//         color: dividerColor,
//         thickness: 1,
//       ),
//     );
//   }
//
//   // ✅ عنصر الحجز المحسّن
//   Widget _buildReservationItem({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required String count,
//     required Color color,
//     required String status,
//     required Color textColor,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.02),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12.r),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12.r),
//           onTap: () {
//             if (MyData.auth_user) {
//               LoginModel loginModel = LoginModel.fromJson(GetStorage().read('store'));
//               Get.put(reservationsController()).getReservationsApi(
//                 loginModel.id.toString(),
//                 status,
//               );
//
//               String screenTitle = "";
//               if (status == "1") screenTitle = "الحجوزات المؤكدة";
//               if (status == "0") screenTitle = "الحجوزات قيد الانتظار";
//               if (status == "2") screenTitle = "الحجوزات الملغية";
//
//               Get.to(() => reservationsScreen(screenTitle));
//               Navigator.pop(context);
//             } else {
//               GetSnackMsg(
//                 msg: "يجب تسجيل الدخول لاستعراض الحجوزات",
//                 bgClr: kColorRed,
//                 txClr: kColorsWhite,
//               ).showTxt();
//             }
//           },
//           child: Padding(
//             padding: EdgeInsets.all(12.w),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40.w,
//                   height: 40.w,
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color,
//                     size: 22.w,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: textColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Text(
//                     count,
//                     style: TextStyle(
//                       fontSize: 13.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ عنصر القائمة المحسّن
//   Widget _buildMenuItem({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required Color iconColor,
//     required VoidCallback onTap,
//     required Color textColor,
//     required Color secondaryTextColor,
//   }) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.02),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12.r),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12.r),
//           onTap: () {
//             onTap();
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: EdgeInsets.all(12.w),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40.w,
//                   height: 40.w,
//                   decoration: BoxDecoration(
//                     color: iconColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10.r),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: iconColor,
//                     size: 22.w,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: textColor,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.chevron_left_rounded,
//                   color: secondaryTextColor,
//                   size: 20.w,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ زر تسجيل الدخول/الخروج المحسّن
//   Widget _buildAuthButton(BuildContext context, Color primaryColor) {
//     final bool isLoggedIn = MyData.auth_user;
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: (isLoggedIn ? Color(0xFFF44336) : primaryColor).withOpacity(0.3),
//             blurRadius: 8.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(12.r),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12.r),
//           onTap: () {
//             if (isLoggedIn) {
//               GetStorage().remove('store');
//               Get.offAll(() => CardWizardOverlapRoute());
//             } else {
//               Get.to(() => LoginScreen());
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 14.h),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: isLoggedIn
//                     ? [Color(0xFFF44336), Color(0xFFD32F2F)]
//                     : [primaryColor, primaryColor.withOpacity(0.9)],
//               ),
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   isLoggedIn ? Icons.logout_rounded : Icons.login_rounded,
//                   color: Colors.white,
//                   size: 20.w,
//                 ),
//                 SizedBox(width: 8.w),
//                 Text(
//                   isLoggedIn ? 'تسجيل الخروج' : 'تسجيل الدخول',
//                   style: TextStyle(
//                     fontSize: 15.sp,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }}
