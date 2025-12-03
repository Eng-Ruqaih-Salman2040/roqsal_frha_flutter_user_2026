/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/noitem.dart';
import 'favorite_controller.dart';
import 'item.dart';


class favoriteScreen extends GetWidget<favoriteController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: kColorsPrimary,
          title: Text("favorite".tr),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),

        ),
        drawer: drawerWidget(),
      body: controller.obx((data)
        =>  data!.shop!.length > 0 ? ListView.builder(
          itemBuilder: (ctx, index) {
    return Item (
    data.shop![index]);
    },
      itemCount: data.shop!.length,
    ):noItem(),

      )
    );
      }
        }
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/noitem.dart';
import 'favorite_controller.dart';
import 'item.dart';

class favoriteScreen extends GetWidget<favoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "favorite".tr,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,
      ),
      drawer: drawerWidget(),
      body: controller.obx(
            (data) {
          if (data?.shop == null || data!.shop!.isEmpty) {
            return noItem();
          }
          return ListView.builder(
            itemBuilder: (ctx, index) {
              return Item(data.shop![index]);
            },
            itemCount: data.shop!.length,
          );
        },
        onLoading: Center(child: CircularProgressIndicator()),
        onEmpty: noItem(),
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error ?? 'حدث خطأ'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // You might want to reload or go back
                  Get.back();
                },
                child: Text('حاول مرة أخرى'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
