
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Constants.dart';
import '../../screen/login/login_model.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_date_paker.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/my_text.dart';
import 'reserve_shop_contraller.dart';



class reserveShopScreen extends StatefulWidget {

  var data_payment;
  var data_shop;

  reserveShopScreen(this.data_payment,this.data_shop);


  @override
  TabsScrollRouteState createState() => new TabsScrollRouteState(this.data_payment,this.data_shop);
}


class TabsScrollRouteState extends State<reserveShopScreen> with SingleTickerProviderStateMixin{

  var data_payment;
  var data_shop;

  TabsScrollRouteState(this.data_payment,this.data_shop);

  final reserveShopController controller=Get.put(reserveShopController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.black, height: 1.4, fontSize: 16);
    TextStyle labelStyle = TextStyle(color: Colors.black);
    UnderlineInputBorder lineStyle1 = UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1));
    UnderlineInputBorder lineStyle2 = UnderlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2));


    return Scaffold(
      appBar: AppBar(

        title: Text("بيانات الحجز",style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),

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

                  CustomDatePaker(hint: 'التاريخ',onchange: (value) {

                  },controller: controller.booking_date,),
                  SizedBox(height: 10.w,),

                  TextFieldWidget(
                      hint: 'اسم الفئة: '+this.data_shop.nameShop.toString(),
                      requirement:false,
                      maxLine: 1,
                      minLine: 1,
                      read:true
                  ),
                  TextFieldWidget(
                      hint: 'الدفع عنطريق : '+this.data_payment.accountName.toString(),
                      requirement:false,
                      maxLine: 1,
                      minLine: 1,
                      read:true
                  ),
                  Container(height: 10),
                  TextFieldWidget(
                    controller: controller.bond_no,
                    textInputType: TextInputType.number,
                    hint: 'رقم السند',
                    requirement: true,
                    iconData: Icons.payment,
                    maxLine: 1,
                    minLine: 1,
                  ),
                  Container(height: 10),

                  TextFieldWidget(
                    controller: controller.note,
                    hint: 'ملاحظة',
                    requirement: true,
                    maxLine: 12,
                    minLine: 7,

                  ),

                  SizedBox(height: 20.h),



                  CustomButton(
                    color: Color(0xF59197CF),
                    text: "Send".tr,
                    onPress: () {
                      // GetStorage().remove(url);

                      if (_formKey.currentState!.validate()) {
                        //  GetStorage().write(token,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsTmFtZSI6Itix2KPZgdiqIiwiR3JvdXBfSUQiOiIyMCIsIkN1c3RvbWVyX0lEIjoiMjM1MSIsIlVTRVJfSUQiOiIxODI0MCIsIkRlcHRfSUQiOiIwIiwiQlJBTkNIU19JRCI6IjEiLCJCcmFuY2hfSUQiOiIxIiwiTG9jYXRpb24iOiIwIiwiRmFjaWxpdHlfSUQiOiIxIiwiRmluX1llYXIiOiIyMSIsIkVycFVybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjAwNjkvIiwiREJVcmwiOiIxMzQuMTE5LjIxNy4xMzkiLCJEQk5hbWUiOiJzczRpdGxnbl9FUlAiLCJEQlVzZXJuYW1lIjoic2EiLCJEQlBhc3N3b3JkIjoiU1M0SVRAU3RhbmQjOUAjIiwiVXNlcl9UeXBlIjoiY3VzdG9tZXIiLCJVc2VyX1R5cGVfSUQiOiIyIiwibmJmIjoxNjM3NDgyNzE4LCJleHAiOjI1ODQxNjc1MTgsImlhdCI6MTYzNzQ4MjcxOH0.mBmkFV_yElKgOpffDdj2a71iA_PZ93JjTYlX9o91xRo' );
                        print('jj');


                        //   print("loginModle");
                        print(controller.loginModle.id);

                        controller.postApi(this.data_shop.id.toString(),
                            this.data_payment.id.toString(),controller.loginModle.id.toString());



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

