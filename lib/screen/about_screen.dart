import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../Constants.dart';


class AboutScreen extends StatefulWidget {
  AboutScreen();

  @override
  TabsScrollRouteState createState() => new TabsScrollRouteState();
}

class TabsScrollRouteState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

          title: Text("حول التطبيق"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {},
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings"),
                ),
              ],
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/logo.png',
                          ),
                          width: 50,
                          height: 50,
                        ),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("فرحة",
                            ),
                            Container(height: 2),
                            Text("FARHAH",
                            ),
                            SizedBox(
                              height: 30,
                            ),



                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.info,),
                            width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("الاصدار",
                            ),
                            Container(height: 2),
                            Text("1.0",
                            )
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.sync,),
                            width: 50),
                        Container(width: 15),
                        Text("Changelog",
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.book, ),
                            width: 50),
                        Container(width: 15),
                        Text("الترخيص",
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),
                        Text("تواصل معنا",
                        )
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.laptop_chromebook,),
                            width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("الموقع الاكتروني",
                            ),
                            Container(height: 2),
                            Text("https://FARHAH.com/",
                            )
                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.email_outlined,),
                            width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(height: 2),

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.white,
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(width: 6),

                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child:
                            Icon(Icons.business, ),
                            width: 50),
                        Container(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                          ],
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                        Container(
                            child: Icon(Icons.location_on,
                            ),
                            width: 50),
                        Container(width: 15),
                        Expanded(
                          child: Text(
                            "3265  Hinkle Deegan Lake Road, Dundee New York, United State",

                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}
