import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../apiservice/url.dart';
import '../../widget/my_colors.dart';
import '../../widget/my_text.dart';
import '../reserve_shop/reserve_shop.dart';


class  Item extends StatelessWidget {
  var data_payment;
  var data_shop;

  Item(this.data_payment,this.data_shop,);

  void select(BuildContext ctx){


    Get.to(() => reserveShopScreen(this.data_payment,this.data_shop));

  }
  @override
  Widget build(BuildContext context) {
    return
      InkWell(


        onTap: () =>select(context),

        child: Card(

          color: Color(0xF59197CF),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 7,
          margin: EdgeInsets.all(10),
          child:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(

                leading: Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage( Url_bank+data_payment.imge.toString()),
                      child: Image.network(
                        Url_bank+data_payment.imge.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 35,
                    height: 35
                ),
                title:Text(data_payment.accountName+' \n '+data_payment.accountNumber, style: MyText.medium(context).copyWith(color: Colors.white)),
                trailing: Icon(Icons.chevron_right, color: MyColors.grey_40),
              ),
            ],
          ),
        ),
      );

  }
}



