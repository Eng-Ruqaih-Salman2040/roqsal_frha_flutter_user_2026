

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../screen/reservations/reservations_controller.dart';
import '../../screen/section/section_controller.dart';
import '../../screen/sliderAds/ads.dart';
import '../../screen/sliderAds/ads_controller.dart';
import '../../Constants.dart';
import '../widget/customButton.dart';
import '../widget/menu_widget2.dart';
import '../widget/my_text.dart';
import '../widget/scrolling_photo.dart';
import 'allShop/allShop.dart';
import 'allShop/allShop_controller.dart';
import 'login/login_model.dart';
import 'notifications/notifications.dart';
import 'notifications/notifications_contraller.dart';
import 'section/section.dart';
import 'package:carousel_slider/carousel_slider.dart';

class  HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = 0;


    // LoginModel   loginModle=   LoginModel.fromJson(GetStorage().read('store'));
    // print(loginModle.id);
    // Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"0");
    // Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"1");
    // Get.put(reservationsController()).getReservationsApi(loginModle.id.toString(),"2");
    // Get.put(NotificationsController()).getNotificationsApi();


    // Get.put(NotificationsController()).getNotificationsApi("0");

  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }
  final _formKey = GlobalKey<FormState>();

  bool _isHidden =true;

  final zoomDrawerController=ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = Theme.of(context);
    final isRtl = Localizations.localeOf(context).languageCode=='ar';
    return Scaffold(

      // backgroundColor:Theme.of(context).primaryColor,
        appBar: new AppBar(
            title: Text( 'الصفحة الرئيسية',style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,

            // backgroundColor: Colors.pink[600],
          actions: <Widget>[
            IconButton(
      icon: const Icon(Icons.notifications_active_outlined,color: Colors.white,),
              onPressed: () {
                Get.put(NotificationsController()).getNotificationsApi();
                Get.to(NotificationsScreen());
                },
            ),
          ]
        ),
        drawer: drawerWidget(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              adsScreen(),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 15,),
                            Text("الأقسام", maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.white)
                            ),
                          ],
                        ),
               sectionScreen(),
              allShopScreen(),

              // Flexible(
              //   child: ListView.builder(
              //     itemCount: 15,
              //     physics: NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) => ListTile(
              //       title: Text("List $index"),
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),


      // Column(
      //         children: [
      //           adsScreen(),
      //           SizedBox(height: 10,),
      //           Row(
      //             children: [
      //               SizedBox(width: 15,),
      //               Text("الأقسام", maxLines: 1, overflow: TextOverflow.ellipsis,
      //                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)
      //               ),
      //             ],
      //           ),
      //           Expanded(child: sectionScreen()),
      //
      //         ],
      //       ),
            


    );


  }
}




