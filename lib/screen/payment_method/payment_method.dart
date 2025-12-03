import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/payment_method/payment_method_controller.dart';
import '../../screen/shop/shop_controller.dart';

import '../../widget/noitem.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class paymentMethodScreen extends GetWidget<paymentMethodController> {
  get alignment => null;

  var data_shop;
  paymentMethodScreen(this.data_shop);









  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            title: Text(this.data_shop.nameShop),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ),
      body: controller.obx((data)
        =>  data!.paymentMethod!.length > 0 ? ListView.builder(
          itemBuilder: (ctx, index) {
            return Item (
                data.paymentMethod![index],this.data_shop);
          },
          itemCount: data.paymentMethod!.length,
        ):noItem(),
      )
    );
      }
        }
