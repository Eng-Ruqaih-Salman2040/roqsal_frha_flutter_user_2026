
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/menu_widget2.dart';
import '../../widget/my_text.dart';
import 'connect_with_us_contraller.dart';



class ConnectWithUsScreen extends StatefulWidget {

  ConnectWithUsScreen();

  @override
  TabsScrollRouteState createState() => new TabsScrollRouteState();
}


class TabsScrollRouteState extends State<ConnectWithUsScreen> with SingleTickerProviderStateMixin{



  final connect_with_usController controller=Get.put(connect_with_usController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.black, height: 1.4, fontSize: 16);
    TextStyle labelStyle = TextStyle(color: Colors.black);
    UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1));
    UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2));


    return Scaffold(
      appBar: AppBar(
        title: Text( 'تواصل معنا',style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,

        // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   }
          // ),

      ),
      drawer: drawerWidget(),
      body:  SingleChildScrollView(
        padding: EdgeInsets.all(15),
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: Form(
              key:  _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFieldWidget(
                    controller: controller.name,
                    hint: 'الاسم',
                    requirement: true,
                    iconData: Icons.person,
                    maxLine: 1,
                    minLine: 1,
                  ),
                  Container(height: 10),
                  TextFieldWidget(
                    controller: controller.email,
                    hint: 'البريد الالكتروني',
                    requirement: true,
                    iconData: Icons.email,
                    maxLine: 1,
                    minLine: 1,
                  ),
                  Container(height: 10),
                  TextFieldWidget(
                    controller: controller.subject,
                    hint: 'العنوان',
                    requirement: true,
                    iconData: Icons.subject,
                    maxLine: 1,
                    minLine: 1,
                  ),
                  Container(height: 10),
                  TextFieldWidget(
                    controller: controller.message,
                    hint: 'الرسالة',
                    requirement: true,
                    maxLine: 12,
                    minLine: 7,
                  ),
                  Container(height: 30),
                  CustomButton(
                    color: Color(0xFFAC7FFF),
                    text: "Send".tr,
                    onPress: () {
                      // GetStorage().remove(url);

                      if (_formKey.currentState!.validate()) {
                        //  GetStorage().write(token,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsTmFtZSI6Itix2KPZgdiqIiwiR3JvdXBfSUQiOiIyMCIsIkN1c3RvbWVyX0lEIjoiMjM1MSIsIlVTRVJfSUQiOiIxODI0MCIsIkRlcHRfSUQiOiIwIiwiQlJBTkNIU19JRCI6IjEiLCJCcmFuY2hfSUQiOiIxIiwiTG9jYXRpb24iOiIwIiwiRmFjaWxpdHlfSUQiOiIxIiwiRmluX1llYXIiOiIyMSIsIkVycFVybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjAwNjkvIiwiREJVcmwiOiIxMzQuMTE5LjIxNy4xMzkiLCJEQk5hbWUiOiJzczRpdGxnbl9FUlAiLCJEQlVzZXJuYW1lIjoic2EiLCJEQlBhc3N3b3JkIjoiU1M0SVRAU3RhbmQjOUAjIiwiVXNlcl9UeXBlIjoiY3VzdG9tZXIiLCJVc2VyX1R5cGVfSUQiOiIyIiwibmJmIjoxNjM3NDgyNzE4LCJleHAiOjI1ODQxNjc1MTgsImlhdCI6MTYzNzQ4MjcxOH0.mBmkFV_yElKgOpffDdj2a71iA_PZ93JjTYlX9o91xRo' );
                        controller.postApi();



                      }

                    },
                  ),
                  Container(height: 10),

                ],
              ),
            ),
          ),
        ),
      ),
      //   floatingActionButton :buildSpeedDial(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

}

