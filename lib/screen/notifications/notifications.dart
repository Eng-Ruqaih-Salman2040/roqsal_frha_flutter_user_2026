import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/my_text.dart';
import '../../widget/noitem.dart';
import 'notifications_contraller.dart';


class NotificationsScreen extends GetWidget<NotificationsController> {

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar:   AppBar(
        title: Text( 'الأشعارات',style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,

        // leading:    Center(child: InkWell(
        //   //onTap: () => zoomDrawerController.toggle!(),
        //     child:  Image.asset('assets/menu.png',width: 30.r,height: 30.r,))),
      ),
      drawer: drawerWidget(),
      body: controller.obx((notifications)=>
      notifications!.notifications!.isNotEmpty ?ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(width: 20),
                      Container(
                          child:  Icon(
                            Icons.notifications_active_outlined,
                            color: Colors.deepPurpleAccent,
                            size: 25.r,
                          ),

                          width: 50,
                          height: 50
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              notifications.notifications![index].note.toString(),
                              style: MyText.title(context)!.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            Container(height: 5),
                            Text(
                              notifications.notifications![index].date_create.toString()+"    "+notifications.notifications![index].time_create.toString(),
                              maxLines: 2,
                              style: MyText.subhead(context)!.copyWith(
                                  color: Colors.grey
                              ),
                            ),
                            Container(height: 15),
                            Divider(color: Colors.grey[300], height: 0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: notifications.notifications!.length,
          )
              :noItem(),
      ),
    );
  }
}
