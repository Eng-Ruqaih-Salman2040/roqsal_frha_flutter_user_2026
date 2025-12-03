import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/noitem.dart';
import '../Constants.dart';
import 'my_text.dart';

class authFavorite extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: kColorsPrimary,
          title: Text( "favorite".tr,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),

        ),
        drawer: drawerWidget(),
      body: Align(
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
              Text("يجب تسجيل الدخول لاستعراض المفضلة", style: MyText.subhead(context)?.copyWith(
                  color: Colors.grey[700]
              )),
            ],
          ),
        ),
      ),

    );
      }
        }
