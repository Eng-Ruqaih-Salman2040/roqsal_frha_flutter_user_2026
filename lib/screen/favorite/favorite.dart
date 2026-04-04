import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Constants.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/my_data.dart';
import '../../widget/noitem.dart';
import 'favorite_controller.dart';
import '../login/login_model.dart';
import 'package:get_storage/get_storage.dart';
import 'favorite_item.dart'; // تأكد من اسم الملف

class favoriteScreen extends GetWidget<favoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "favorite".tr,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: kColorsWhite),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              String customers_id = '0';
              if (MyData.auth_user) {
                try {
                  LoginModel loginModle = LoginModel.fromJson(
                    GetStorage().read('store'),
                  );
                  customers_id = loginModle.id.toString();
                } catch (e) {
                  print('خطأ في جلب customer_id: $e');
                }
              }
              controller.getFavoriteApi(customers_id);
            },
          ),
        ],
      ),
      drawer: drawerWidget(),
      body: controller.obx(
            (data) {
          if (data?.data == null || data!.data!.isEmpty) {
            return noItem();
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.w),
            itemBuilder: (ctx, index) {
              return FavoriteItem(data.data![index]);
            },
            itemCount: data.data!.length,
          );
        },
        onLoading: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('جاري تحميل المفضلة...'),
            ],
          ),
        ),
        onEmpty: noItem(),
        onError: (error) => Center(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                SizedBox(height: 20.h),
                Text(
                  error ?? 'حدث خطأ في تحميل المفضلة',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    String customers_id = '0';
                    if (MyData.auth_user) {
                      try {
                        LoginModel loginModle = LoginModel.fromJson(
                          GetStorage().read('store'),
                        );
                        customers_id = loginModle.id.toString();
                      } catch (e) {
                        print('خطأ في جلب customer_id: $e');
                      }
                    }
                    controller.getFavoriteApi(customers_id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorsPrimary,
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                  ),
                  child: const Text('إعادة المحاولة'),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('العودة للخلف'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}