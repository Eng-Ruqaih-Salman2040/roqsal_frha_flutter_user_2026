import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/section/section_controller.dart';
import '../../apiservice/url.dart';
import '../../widget/colleges_item..dart';
import 'ads_controller.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class adsScreen extends GetWidget<adsController> {
  get alignment => null;

  @override
  Widget build(BuildContext context) {
    return  controller.obx((data)
        => data!.ads!.length > 0 ? Container(
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items:   data.ads!.map((item) =>
                  Item(item))
                  .toList(),
            )):SizedBox(width: 0,));
      }
        }
