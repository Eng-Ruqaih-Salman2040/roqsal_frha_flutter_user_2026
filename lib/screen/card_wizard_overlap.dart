import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../screen/wizard.dart';

import '../router/route_constants.dart';

class CardWizardOverlapRoute extends StatefulWidget {

  CardWizardOverlapRoute();

  @override
  CardWizardOverlapRouteState createState() => new CardWizardOverlapRouteState();
}


class CardWizardOverlapRouteState extends State<CardWizardOverlapRoute> {
  static  const String screenRoute='CardWizardOverlapRouteState';
  List<Wizard> wizardData = getWizard() ;

  static List<Wizard> getWizard() {
    List<Wizard> items = [];





    const List<String> wizard_title = [
      "FARHA",
      "فرحة",
      "FARHA",
      "فرحة"
    ];

    const List<String> wizard_image = [
      "logoo.png", "img_wizard_2.png","img_wizard_2.png","img_wizard_2.png",
    ];
    const List<String> wizard_background = [
      "مرحبا بكم في تطبيق  FARHA. عندك مناسبة ومحتار اي قاعة تختار.مرحبا بكم في تطبيق  FARHA. عندك مناسبة ومحتار اي قاعة تختار.",
      "في FARHA توفير المال والوقت والجهد مع FARHA الحياة اسهل. اليمن - صنعاء.",
      "تقدم FARHA العديد من الخدمات",
      "نتمنى ان ينال التطبيق اعجابكم !",
    ];
    const List<String> wizard_brief = [
      "مرحبا بكم في تطبيق  FARHA. عندك مناسبة ومحتار اي قاعة تختار.مرحبا بكم في تطبيق  FARHA. عندك مناسبة ومحتار اي قاعة تختار.",
      "في FARHA توفير المال والوقت والجهد مع FARHA الحياة اسهل. اليمن - صنعاء.",
      "تقدم FARHA العديد من الخدمات",
      "نتمنى ان ينال التطبيق اعجابكم !",
    ];







    List<Color> wizard_color = [
      Colors.red,
      Colors.blueGrey,
      Colors.purple,
      Colors.orange,
      Colors.orange,
      Colors.orange,
      Colors.orange,
      Colors.orange,
    ];

    for (int i = 0; i < wizard_title.length; i++) {

      Wizard obj = new Wizard();
      obj.image = wizard_image[i];
      obj.background = wizard_background[i];
      obj.title = wizard_title[i];
      obj.brief = wizard_brief[i];
      obj.color = wizard_color[i];
      items.add(obj);
    }

    return items;
  }

  PageController pageController = PageController(
    initialPage: 0,
  );
  int page = 0;
  bool isLast = false;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      backgroundColor: Color(0xFFF8F8F8),
      appBar: PreferredSize(preferredSize: Size.fromHeight(0), child: Container(color: Colors.grey[100])),
      body: Container(
        width: double.infinity, height: double.infinity,
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[
              Row(
                children: [
                  SizedBox(width: 15,),
                  InkWell(
                    onTap:(){
                      Get.offAllNamed(RoutingApp.loginRoute);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("تخطي",style:TextStyle(color:Colors.black) ,),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  onPageChanged: onPageViewChange,
                  controller: pageController,
                  children: buildPageViewItem(),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: buildDots(context),
                  ),
                ),
              ),
              Container(
                width: double.infinity, height: 50,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                child: TextButton(
                  child: Text(isLast ? "البدء" : "التالي", style: Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.white),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(
                          0xF59197CF)),
                  onPressed: (){
                    if(isLast){
                      // GetStorage().write(intro, true);
                      Get.offAllNamed(RoutingApp.loginRoute);
                      return;
                    }
                    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                  },
                ),
              )
            ]),
          ],
        ),


      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    isLast = _page == wizardData.length-1;
    setState(() {});
  }

  List<Widget> buildPageViewItem(){
    List<Widget> widgets = [];
    for(Wizard wz in wizardData){
      Widget wg = Container(
        alignment: Alignment.center,
        width: double.infinity, height: double.infinity,
        child: Wrap(
          children : <Widget>[
            Container(
                width: 280, height: 370,
                child: Stack(
                  children: <Widget>[
                    // Image.asset("assets/"+wz.background, width: double.infinity, height: double.infinity, fit: BoxFit.cover),

                    Column(
                      children: <Widget>[
                        Container(height: 30),
                        Expanded(
                          child: Image.asset("assets/"+wz.image, width: 150, height: 150,color: Color(
                              0xF59197CF),),
                        ),
                        Text(wz.title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color:Colors.black87),),
                        Container(height: 10),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          child: Text(wz.brief, textAlign : TextAlign.center, style: Theme.of(context).textTheme.titleMedium!.copyWith(color:Colors.black87),),
                        ),
                        Container(height: 20),

                      ],
                    )
                  ],
                )
            )
          ],
        ),
      );
      widgets.add(wg);
    }
    return widgets;
  }
  List<Widget> buildPageViewItem2(){
    List<Widget> widgets = [];
    for(Wizard wz in wizardData){
      Widget wg = Container(
        alignment: Alignment.center,
        width: double.infinity, height: double.infinity,
        child: Wrap(
          children : <Widget>[
            Container(
                width: 280, height: 370,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Stack(
                    children: <Widget>[
                      Image.asset("assets/"+wz.background, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                      Container(color: Colors.white),
                      Column(
                        children: <Widget>[
                          Container(height: 30),
                          Expanded(
                            child: Image.asset("assets/"+wz.image, width: 150, height: 150,color: Color(
                                0xF59197CF),),
                          ),
                          Text(wz.title, style: Theme.of(context).textTheme.titleLarge),
                          Container(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            child: Text(wz.brief, textAlign : TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Container(height: 20),

                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      );
      widgets.add(wg);
    }
    return widgets;
  }

  Widget buildDots(BuildContext context){
    Widget widget;

    List<Widget> dots = [];
    for(int i=0; i<wizardData.length; i++){
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? Color(
              0xF59197CF) : Color(0xFFcccccc),
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }

}

