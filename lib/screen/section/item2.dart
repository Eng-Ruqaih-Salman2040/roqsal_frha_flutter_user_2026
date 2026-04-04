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
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(Url_section+data.image.toString(),
                height: 180, width: double.infinity, fit: BoxFit.cover,
              ),
              Container(height: 15),
              Row(
                children: <Widget>[
                  Container(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.name.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[900])
                        ),
                        Text(data.countShop.toString(), style: TextStyle(
                            fontSize: 16, color: Colors.grey[500]
                        )),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_sharp, color: Colors.grey[500], size: 25),
                  Container(width: 10),
                ],
              ),
              Container(height: 15),
            ],
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

  

