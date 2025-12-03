import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/section/section_controller.dart';
import '../../apiservice/url.dart';
import '../../widget/colleges_item..dart';
import '../../widget/noitem.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class sectionScreen extends GetWidget<sectionController> {
  get alignment => null;

  @override
  Widget build(BuildContext context) {
    return  controller.obx((data)
        => data!.section!.length > 0 ?

        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // primary: false,
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
        padding: EdgeInsets.all(10),
    // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    // maxCrossAxisExtent: 200,
    // childAspectRatio: 6/ 9,
    // // mainAxisSpacing: 10,
    // // crossAxisSpacing: 10,
    // ),
    children: data.section!.map((item) =>
    Item(item))
        .toList(),

    ):noItem(),
      )
    ;
      }
        }
