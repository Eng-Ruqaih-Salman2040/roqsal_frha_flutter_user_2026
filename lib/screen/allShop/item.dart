import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../screen/section/section_model.dart';
import '../../apiservice/url.dart';
import '../../widget/my_text.dart';
import '../../widget/noitem.dart';
import '../shop/shop.dart';
import '../shop/shop_controller.dart';
import 'item3.dart';

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
      Column(
        children: [
          Row(
            children: [
              SizedBox(width: 15,),
              Text(data.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black)
              ),
              Spacer(),
              InkWell(
                onTap:()=> select(context),
                child: Text("مشاهدة الكل", maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)
                ),
              ),
              SizedBox(width: 15,),
            ],
          ),
          SizedBox(
              height: 270,
              child:
              data!.shop!.length > 0 ? ListView.builder(

                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return Item3(
                      data.shop![index]);
                },
                itemCount: data.shop!.length,
              ):noItem()



          ),
        ],
      );
        
  }
}

  

