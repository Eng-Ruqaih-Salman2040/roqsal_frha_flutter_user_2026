import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../apiservice/url.dart';
import '../../widget/customButton.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../../widget/my_text.dart';
import '../login/login.dart';
import '../payment_method/payment_method.dart';
import '../payment_method/payment_method_controller.dart';

class SliderImageHeaderRoute extends StatefulWidget {
  var data,data_image;
  SliderImageHeaderRoute(this.data,this.data_image);


  @override
  SliderImageHeaderRouteState createState() => new SliderImageHeaderRouteState(this.data,this.data_image);
}


class SliderImageHeaderRouteState extends State<SliderImageHeaderRoute> {
  var data,data_image;
  SliderImageHeaderRouteState(this.data,this.data_image);
  int page = 0;
  static const int MAX = 5;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: CommonAppBar.getPrimarySettingAppbar(context, "Product"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.all(0),
              child: Container(
                height: 250,
                child: Stack(
                  children: <Widget>[
                    PageView(
                      children: <Widget>[
                        Image.network(Url_shop+data.image.toString(),fit: BoxFit.cover),
        for(int i=0; i<data_image!.length; i++)
          Image.network(Url_gallery+data_image![i].imge.toString(),fit: BoxFit.cover),


                        // data_image.map((item) =>
                        //    Text("aa"),)
                        //     .toList(),
                      ],
                      onPageChanged: onPageViewChange,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.5)])
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: buildDots(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,

              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(''+data.id+'# ', style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                    Container(height: 5),
                    Row(
                      children: [
                        Text(data.sectionName, style: MyText.subhead(context)?.copyWith(color: Colors.grey[600])),
                        Spacer(),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            Container(width: 5),
                            Text(data.cityName+" - "+data.adress, style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                          ],
                        ),
                      ],
                    ),
                    Container(height: 20),
                    Row(
                      children: <Widget>[
                       Row(
                         children: [
                           Icon(Icons.remove_red_eye_outlined),
                           Container(width: 5),
                           Text(data.viewer, style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                         ],
                       ),
                        Spacer(),
                        Text(data.price+" ريال", style: MyText.headline(context)?.copyWith(
                            color: Colors.lightGreen[700], fontWeight: FontWeight.bold
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("معلومات التواصل", style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                    Container(height: 5),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        Container(width: 5),
                        Text(data.phone, style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.email),
                        Container(width: 5),
                        Text(data.email, style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                      ],
                    ),


                    Container(height: 20),
                  ],
                ),
              ),
            )   ,
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("الوصف", style: MyText.headline(context)?.copyWith(color: Colors.grey[900])),
                    Container(height: 5),
                    Text(data.description, textAlign: TextAlign.justify,
                        style: MyText.subhead(context)?.copyWith(color: Colors.grey[600])
                    ),
                    Container(height: 20),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child:       CustomButton(
                text: 'حجز',
                color:  Color(0xFF16AE94),
                onPress: () {
                  if(MyData.auth_user){
                    Get.put(paymentMethodController()).getPaymentMethodApi(data.id.toString());
                    Get.to(() => paymentMethodScreen(this.data));
                  }else{
                    GetSnackMsg(msg: "يجب تسجيل الدخول للمكن من الحجز",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
                    Get.to(LoginScreen());
                  }


                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    setState(() {});
  }

  Widget buildDots(BuildContext context){
    Widget widget;

    List<Widget> dots = [];
    for(int i=0; i<data_image!.length+1; i++){
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? Colors.blue : Colors.grey[100],
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

