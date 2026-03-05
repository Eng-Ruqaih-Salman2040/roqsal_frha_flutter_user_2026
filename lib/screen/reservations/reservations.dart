import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../screen/reservations/reservations_controller.dart';


import '../../widget/noitem.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class reservationsScreen extends GetWidget<reservationsController> {
  get alignment => null;
  late String title;
  reservationsScreen(this.title);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(this.title,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: controller.obx((data)
        =>  data!.reservations!.length > 0 ?ListView.builder(
          itemBuilder: (ctx, index) {
            return Item (
                data.reservations![index]);
          },
          itemCount: data.reservations!.length,
        ):noItem(),
        )
    );
  }
}
