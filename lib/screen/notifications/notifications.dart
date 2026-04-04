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
      body: Container(
        // color: Color(0xFFF8F9FA),
        child: controller.obx(
              (notifications) => notifications!.notifications!.isNotEmpty
              ? RefreshIndicator(
            color: Colors.deepPurple,
            backgroundColor: Colors.white,
            onRefresh: () async {
              await controller.getNotificationsApi();
            },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: notifications.notifications!.length,
              separatorBuilder: (context, index) => SizedBox(height: 8.h),
              itemBuilder: (ctx, index) {
                return _buildNotificationCard(
                  context: context,
                  notification: notifications.notifications![index],
                  index: index,
                );
              },
            ),
          )
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: 50.w,
                    color: Colors.deepPurple.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'لا توجد إشعارات',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(0xFF2D3748),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    'ستظهر هنا جميع الإشعارات عند توفرها',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF718096),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onLoading: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'جاري التحميل...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          onError: (error) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 60.w,
                  color: Colors.red,
                ),
                SizedBox(height: 16.h),
                Text(
                  'حدث خطأ في التحميل',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF2D3748),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    error ?? 'يرجى المحاولة مرة أخرى',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xFF718096),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () {
                    controller.getNotificationsApi();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text('إعادة المحاولة'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required dynamic notification,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // يمكن إضافة تفعيل للإشعار عند الضغط
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.r),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.notifications_active_rounded,
                        color: Colors.deepPurpleAccent,
                        size: 22.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.note.toString(),
                          style: MyText.title(context)!.copyWith(
                            color: Color(0xFF2D3748),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14.sp,
                              color: Color(0xFF718096),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              notification.date_create.toString() + " • " + notification.time_create.toString(),
                              style: MyText.subhead(context)!.copyWith(
                                color: Color(0xFF718096),
                                fontSize: 12.sp,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}