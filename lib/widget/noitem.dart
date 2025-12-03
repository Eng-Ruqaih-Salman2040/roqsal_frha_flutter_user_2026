import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Constants.dart';
import '../language/controller/app_language.dart';
import '../screen/about_screen.dart';
import '../screen/card_wizard_overlap.dart';
import '../screen/connect_with_us/connect_with_us.dart';
import '../screen/developer.dart';
import '../screen/login/login_model.dart';
import '../screen/notifications/notifications.dart';
import '../screen/notifications/notifications_contraller.dart';
import '../screen/reservations/reservations.dart';
import '../screen/reservations/reservations_controller.dart';
import 'customButton.dart';
import 'my_text.dart';

class noItem extends StatelessWidget {

  @override
  Widget build(BuildContext context){

  return  Align(
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      width: 220,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
              ),
              Container(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 10, width : 80, color: Colors.grey[300]),
                  Container(height: 10),
                  Container(height: 10, width : 145, color: Colors.grey[300]),
                  Container(height: 10),
                  Container(height: 10, width : 40, color: Colors.grey[300])
                ],
              )
            ],
          ),
          Container(height: 20),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[200],
              ),
              Container(width: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 10, width : 100, color: Colors.grey[200]),
                  Container(height: 10),
                  Container(height: 10, width : 145, color: Colors.grey[200]),
                  Container(height: 10),
                  Container(height: 10, width : 40, color: Colors.grey[200])
                ],
              )
            ],
          ),
          Container(height: 25),
          Text("There is no data".tr, style: MyText.subhead(context)?.copyWith(
              color: Colors.white70,
          )),
        ],
      ),
    ),
  );
  }
}
