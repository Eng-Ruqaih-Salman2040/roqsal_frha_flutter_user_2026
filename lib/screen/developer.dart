import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/my_colors.dart';
import '../widget/my_text.dart';

class DeveloperRoute extends StatefulWidget {

  DeveloperRoute();

  @override
  DeveloperRouteState createState() => new DeveloperRouteState();
}

class DeveloperRouteState extends State<DeveloperRoute> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.grey_5,
      appBar: AppBar(

          title: Text("المطورين"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("فريق المشروع", style: MyText.medium(context).copyWith(color: MyColors.grey_90, fontWeight: FontWeight.w500)),
                      Container(height: 5),
                      Center(
                        child: Container(width: 30, height: 5, decoration: BoxDecoration(
                          color: Color(0xFF1D98B3),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                      ),
                      Container(height: 15),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/developer.png'),
                                ),
                                Container(height: 8),
                                Text("وسام الشيباني", style: MyText.caption(context)?.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.w600)),
                                Container(height: 4),
                                Text("مطور التطبيق", style: MyText.caption(context)?.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/developer.png'),
                                ),
                                Container(height: 8),
                                Text("محمد عبدالواسع", style: MyText.caption(context)?.copyWith(color: MyColors.grey_90, fontWeight: FontWeight.w600)),
                                Container(height: 4),
                                Text("مطور الويب", style: MyText.caption(context)?.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(height: 15),

                    ],
                  ),
                ),
              ),
              Container(height: 15),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(2),),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("عن المطورين", style: MyText.medium(context).copyWith(color: MyColors.grey_90, fontWeight: FontWeight.w500)),
                      Container(height: 5),
                      Center(
                        child: Container(width: 30, height: 5, decoration: BoxDecoration(
                          color: Color(0xFF1D98B3),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        )),
                      ),
                      Container(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text("طلاب جامعة الرازي ...........................", textAlign : TextAlign.justify, style: MyText.body2(context)?.copyWith(
                          color: MyColors.grey_60, fontWeight: FontWeight.w300,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Container(height: 15),

            ],
          ),
        ),
      ),
    );
  }
}

