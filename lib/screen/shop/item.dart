import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import '../../screen/section/section_model.dart';
import '../../apiservice/url.dart';
import '../../widget/customButton.dart';
import '../../widget/my_data.dart';
import '../../widget/my_text.dart';
import '../login/login_model.dart';
import '../shop_details/shop_details.dart';
import '../shop_details/shop_details_controller.dart';

class Item extends StatelessWidget {
  final dynamic data;

  Item(this.data);

  void select(BuildContext ctx) {
    if (MyData.auth_user) {
      late LoginModel loginModel = LoginModel.fromJson(GetStorage().read('store'));
      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(), loginModel.id.toString());
      Get.to(() => shop_detailsScreen(this.data));
    } else {
      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(), "0");
      Get.to(() => shop_detailsScreen(this.data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => select(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        children: [
          SizedBox(height: 15),
          Card(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(27, 0, 27, 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  child: Image.network(
                    Url_shop + data.image.toString(),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(height: 20),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.nameShop.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.call, size: 12),
                                SizedBox(width: 5),
                                Text(
                                  data.phone.toString(),  // تم التحويل إلى نص
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.alternate_email_sharp, size: 12),
                                SizedBox(width: 5),
                                Text(
                                  data.email.toString(),  // تم التحويل إلى نص
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              sizeHeight: 20,
                              sizeWidth: 90,
                              color: Color(0xFF15BE77),
                              text: data.price.toString() + " ريال",  // تم التحويل إلى نص
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                            Container(height: 7),
                            Row(
                              children: [
                                CustomButton(
                                  color: Color(0xFFF3F5FE),
                                  sizeHeight: 15,
                                  sizeWidth: 30,
                                  row: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Icon(Icons.remove_red_eye_outlined, size: 12),
                                            SizedBox(width: 5),
                                            Text(
                                              data.viewer.toString(),  // تم التحويل إلى نص
                                              style: TextStyle(fontSize: 9.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomButton(
                                  color: Color(0xFFF3F5FE),
                                  sizeHeight: 15,
                                  sizeWidth: 130,
                                  row: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_pin, size: 12),
                                            SizedBox(width: 10),
                                            Text(
                                              data.cityName.toString() + " - " + data.adress.toString(),  // تم التحويل إلى نص
                                              style: TextStyle(fontSize: 9.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(height: 8)
              ],
            ),
          ),
        ],
      ),
    );
  }
}