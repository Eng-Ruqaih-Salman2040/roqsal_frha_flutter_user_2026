import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../screen/shop/shop_controller.dart';
import '../../screen/shop_details/shop_details_controller.dart';

import '../../Constants.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../favorite/favorite_controller.dart';
import '../login/login_model.dart';
import 'details.dart';
import 'item.dart';


// ignore: use_key_in_widget_constructors
class shop_detailsScreen extends GetWidget<shopDetailsController> {

  var data;
  shop_detailsScreen(this.data);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            title: Text(this.data.nameShop),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              controller.obx((data)
              => data!.favorite == true ?IconButton(
                icon: const Icon(Icons.favorite,color: Colors.red),
                onPressed: () {
                  if(MyData.auth_user){
                    late LoginModel loginModle = LoginModel.fromJson(GetStorage().read('store'));

                    Get.put(favoriteController()).delete_favorite_postApi(this.data.id,loginModle.id.toString(),this.data);

                  }else {
                    GetSnackMsg(msg: "يجب تسجيل الدخول لاستكمال العملية",
                        bgClr: kColorRed,
                        txClr: kColorsWhite).showTxt();

                  }

                },
              ):IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  if(MyData.auth_user){
                    late LoginModel loginModle = LoginModel.fromJson(GetStorage().read('store'));

                    Get.put(favoriteController()).add_favorite_postApi(this.data.id,loginModle.id.toString(),this.data);

                  }else {
                    GetSnackMsg(msg: "يجب تسجيل الدخول لاستكمال العملية",
                        bgClr: kColorRed,
                        txClr: kColorsWhite).showTxt();

                  }

                },
              )

              ),

            ]
            ),
      body: controller.obx((data)
        => SliderImageHeaderRoute(this.data,data!.gallery)

    ),
    );
      }
        }
