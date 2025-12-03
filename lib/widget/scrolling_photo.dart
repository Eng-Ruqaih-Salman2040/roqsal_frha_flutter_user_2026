import 'package:flutter/material.dart';
import 'dart:async';

import '../widget/my_text.dart';

class SliderImageHeaderAutoRoute extends StatefulWidget {
  SliderImageHeaderAutoRoute();

  @override
  SliderImageHeaderAutoRouteState createState() =>
      new SliderImageHeaderAutoRouteState();
}

class ModelImage {
  late String image;
  late String name;
  late String brief;
  int counter = -1;
}

class SliderImageHeaderAutoRouteState extends State<SliderImageHeaderAutoRoute> {
  static const List<String> images_header_auto = [
    "assets/this_app/noor.png",
    "assets/this_app/noor.png",
    "assets/this_app/noor.png"
  ];

  static const List<String> title_header_auto = [
    "Dui fringilla ornare finibus, orci odio",
    "Mauris sagittis non elit quis fermentum",
    "Mauris ultricies augue sit amet est sollicitudin"
  ];
  static const List<String> subtitle_header_auto = [
    "Foggy Hill",
    "The Backpacker",
    "River Forest"
  ];

  static List<ModelImage> getModelImage() {
    final List<ModelImage> items = [];
    for (int i = 0; i < images_header_auto.length; i++) {
      ModelImage obj = new ModelImage();
      obj.image = images_header_auto[i];
      obj.name = title_header_auto[i];
      obj.brief = subtitle_header_auto[i];
      items.add(obj);
    }
    return items;
  }

  static const int MAX = 3;

  List<ModelImage> items = getModelImage();
  int page = 0;
  late Timer timer;
  late ModelImage curObj;

  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    curObj = items[0];
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      page = page + 1;
      if (page >= MAX) page = 0;
      pageController.animateToPage(page,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
      print("animateToPage");
      setState(() {
        curObj = items[page];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null && timer.isActive) timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10000)),
            elevation: 2,
            margin: EdgeInsets.all(15),
            child: Container(
              height: 160,
              child: Stack(

                children: <Widget>[
                  PageView(
                    controller: pageController,
                    children: getImagesHeader(),
                    onPageChanged: onPageViewChange,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.6)
                                ])),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(15),

                      // child: Column(
                      //    crossAxisAlignment: CrossAxisAlignment.start,
                      //    mainAxisSize: MainAxisSize.min,
                      //    children: <Widget>[
                      // Text(curObj.name, style: MyText.medium(context).copyWith(color: Colors.white)),
                      //Container(height: 10),
                      // Row(
                      //   children: <Widget>[
                      //     Icon(Icons.location_on, size: 10, color: Colors.white),
                      //     Container(width: 5),
                      //     Text(curObj.brief, style: TextStyle(color: Colors.white)),
                      //     Spacer(),
                      //     buildDots(context)
                      //   ],
                      // )

                      // ],
                      //),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    setState(() {});
  }

  List<Widget> getImagesHeader() {
    List<Widget> lw = [];
    for (ModelImage mi in items) {
      lw.add(Image.asset(mi.image, fit: BoxFit.cover));
    }
    return lw;
  }

  Widget buildDots(BuildContext context) {
    Widget widget;

    List<Widget> dots = [];
    for (int i = 0; i < MAX; i++) {
      Widget w = Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 9,
        width: 9,
        decoration: BoxDecoration(
            color: page == i ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 1.5)),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisSize: MainAxisSize,
      children: dots,
    );
    return widget;
  }
}
