/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../screen/section/section_model.dart';
import '../../apiservice/url.dart';
import '../../widget/my_text.dart';
import '../shop/shop.dart';
import '../shop/shop_controller.dart';

class  Item extends StatelessWidget {
    var data;

  Item(  this.data );

  void select(BuildContext ctx){



    Get.put(shopController()).getShopApi( data.id.toString());
    Get.to(() => shopScreen(data.id,data.name));

  }
  @override
  Widget build(BuildContext context) {
    return 
      InkWell(
        onTap:()=> select(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius:BorderRadius.circular(15) ,
        child:

        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(25)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 7,),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      Url_section+data.image.toString(),
                      height: 55.0,
                      width: 55.0,
                    ),
                  ),
                ),
                // Center(
                //   child:    Container(
                //     width: 55.0,
                //     height: 55.0,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                //       color: Colors.redAccent,
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Image.network(
                //
                //         Url_section+data.image.toString(),
                //         height: 55.0,
                //         width: 55.0,
                //       ),
                //     ),),
                // ),
                Container(width: 15),
                Center(
                  child: Text(data.name.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.grey[900])
                  ),
                ),
              ],
            ),
          ),
        ),

        // Container(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.max,
        //     children: <Widget>[
        //       Expanded(
        //         child: Image.network(
        //           Url_section+data.image.toString(),
        //     fit: BoxFit.cover,
        //   ),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(15),
        //         width: double.infinity,
        //         color: Colors.blueGrey[800],
        //         child: Row(
        //           children: <Widget>[
        //             Expanded(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   Text(data.name.toString(), style: MyText.subhead(context)?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        //                   Container(height: 2),
        //                   Text(data.countShop.toString(), style: MyText.caption(context)?.copyWith(color: Colors.white)),
        //                 ],
        //               ),
        //             ),
        //             Icon(Icons.star_border, color: Colors.white)
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // )

      );
        
  }
}

  

*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../apiservice/url.dart';
import '../shop/shop.dart';
import '../shop/shop_controller.dart';

class Item extends StatelessWidget {
  final dynamic data;

  Item(this.data);

  void select(BuildContext ctx) {
    Get.put(shopController()).getShopApi(data.id.toString());
    Get.to(() => shopScreen(data.id, data.name));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => select(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: Color(0xF59197CF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 7),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      Url_section + (data.image?.toString() ?? ''),
                      height: 90.0,
                      width: 90.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback when image fails to load
                        return Container(
                          height: 90.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[600],
                            size: 24,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        // Show loading indicator while image is loading
                        return Container(
                          height: 55.0,
                          width: 55.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  data.name?.toString() ?? 'No Name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 4),
              // Optional: Show count if available
              /*if (data.countShop != null && data.countShop != "0")
                Center(
                  child: Text(
                    '${data.countShop} items',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
