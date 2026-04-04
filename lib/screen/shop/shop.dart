import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../screen/shop/shop_controller.dart';

import '../../widget/noitem.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class shopScreen extends GetWidget<shopController> {
  get alignment => null;
  late String id;
  late String title;
  shopScreen(this.id, this.title);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(this.title,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
