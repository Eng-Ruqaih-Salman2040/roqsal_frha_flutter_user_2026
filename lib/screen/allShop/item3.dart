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

class  Item3 extends StatelessWidget {
    var data;

  Item3(  this.data );

  void select(BuildContext ctx){
    if(MyData.auth_user){
      late LoginModel loginModle = LoginModel.fromJson(GetStorage().read('store'));

      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(),loginModle.id.toString());
      Get.to(() => shop_detailsScreen(this.data));
    }else {
      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(),"0");
      Get.to(() => shop_detailsScreen(this.data));

    }

    // Get.to(() => MajorScreen(), arguments: [
    // {"id": data.id},
    // {"title": data.name}
    // ]);
    // Get.put(MagerController()).getMajerApi(id);

  }
  @override
  Widget build(BuildContext context) {
    return 
      InkWell(
        onTap:()=> select(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius:BorderRadius.circular(15) ,
        child:
        Column(
          children: [
            SizedBox(height: 15,),
            Card(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(27, 0, 27, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(8),topLeft:Radius.circular(8) ),
                    child: Image.network(

                      Url_shop+data.image.toString(),

                      height: 150 ,
                      // width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(height: 20 ),
                  Row(
                    children: [
                      SizedBox(width: 15,),

                      Center(
                        //  padding: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(data.nameShop.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(Icons.call,size: 12),
                                SizedBox(width: 5,),
                                Text(
                                  data.phone,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[500]),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.alternate_email_sharp,size: 12),
                                SizedBox(width: 5,),
                                Text(
                                  data.email,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),//
                      // Spacer(),
                      Container(
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              sizeHeight: 20 ,
                              sizeWidth: 90,
                              color: Color(0xFF15BE77),

                              text: data.price+" ريال",
                              style: TextStyle(
                                color: Colors.white,

                                fontSize: 11 ,
                                // height: 2
                              ),

                            ),


                            Container(height: 7 ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  color: Color(0xFFF3F5FE),
                                  sizeHeight: 15 ,
                                  sizeWidth: 30 ,


                                  row: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Row(

                                          children: [
                                            Icon(Icons.remove_red_eye_outlined,size: 12),
                                            SizedBox(width: 5),
                                            Text(data.viewer,style: (
                                                TextStyle(
                                                    fontSize: 9.5
                                                )
                                            ),

                                            ),
                                          ],
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                                Container(width: 5),
                                CustomButton(
                                  color: Color(0xFFF3F5FE),
                                  sizeHeight: 15 ,
                                  sizeWidth: 130 ,
                                  row: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Row(

                                          children: [
                                            Icon(Icons.location_pin,size: 12),

                                            SizedBox(width: 10 ),
                                            Text(data.cityName+" - "+data.adress,style: (
                                                TextStyle(
                                                    fontSize: 9.5
                                                )
                                            ),

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
                      ),//buttons




                    ],
                  ),
                  Container(height: 8 )
                ],
              ),
            ),
          ],
        )



      );
        
  }
}

  

