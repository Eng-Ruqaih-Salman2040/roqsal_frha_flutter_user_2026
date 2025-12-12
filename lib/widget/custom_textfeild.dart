import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final IconData ?iconData;
  final String ?text;
  final Function(String) ?onChange;
  final String ?initialValue;
  final bool ?requirement;
  final int ?maxLine;
  final int ?minLine;
  final TextInputType ?textInputType;


  final Widget ?inkell;
  final bool isHidden ;
  final bool read ;

  final  FocusNode ?focusNode;

  final EdgeInsets ?contentPadding;

  final Color ?borderColor;

  final  Color ?focusedBorderColor;

  final TextInputAction ?textInputAction;


  String? _errorMessage(bool str) {
    switch (str) {
      case true:
        return 'This filed requirement'.tr;
        break;
      case false:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  TextFieldWidget({
    Key ?key,
    this.hint,
    this.controller,
    this.iconData,
    this.text, this.inkell, this.isHidden=false, this.initialValue, this.requirement, this.maxLine, this.minLine, this.textInputType, this.onChange, this.read=false, this.focusNode, IconButton? suffixIcon, this.contentPadding, this.borderColor, this.focusedBorderColor,this.textInputAction, Function(String p1)? onFieldSubmitted, String? Function(String? p1)? validator,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.03.sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     padding: EdgeInsets.only(
          //         left:20.r, right:20.r,
          //         bottom:5.h),
          //     child: Text(
          //       text!,
          //       style: Theme.of(context).textTheme.headline4)
          //     ),


          Material(
            borderRadius: BorderRadius.circular(20.r),
            elevation:13 ,
            color: Colors.transparent,
            shadowColor: kColorsWhite,
            child: TextFormField(
           readOnly: read,
              initialValue: initialValue,

              controller: controller,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: kColorsBlack),

              validator: (value) {



                if (value!.isEmpty) {
                  //print('error'+error);

                  return _errorMessage(requirement!);
                  // ignore: missing_return
                }else{




               /*   if (textInputType == TextInputType.number) {
                    if (!(value.length > 9) && value.isNotEmpty) {
                      return "أدخل رقم صالحًا يساوي !";
                    }
                  }*/
                  // if (textInputType == TextInputType.text ) {
                  //   if ((value.contains('1')) || (value.contains('2')) || (value.contains('3'))
                  //       || (value.contains('4')) || (value.contains('5')) || (value.contains('6'))
                  //       || (value.contains('7')) || (value.contains('8')) || (value.contains('9'))  || (value.contains('0'))) {
                  //     return "يجب الايحتوي الاسم على رقم!";
                  //   }
                  // }
                  if (textInputType == TextInputType.emailAddress ) {
                    if (!(value.contains('@')) && value.isNotEmpty) {
                      return "أدخل عنوان بريد إلكتروني صالح!";
                    }
                  }

                }

              },
              cursorColor: kColorsPrimary,
              obscureText: isHidden,
              //textAlign: TextAlign.center,
              keyboardType:textInputType?? TextInputType.text,
              autocorrect: false,
              maxLines: maxLine,
              minLines: minLine,onChanged: onChange,
              decoration: InputDecoration(hintText: hint,

                  filled: true,
                  fillColor:  kColorsWhite.withOpacity(.8),
                  errorMaxLines: 1,
                  hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 30.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent)),
                  errorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.transparent)),
//                 suffixIcon: text=='Password'.tr?Icon(Icons.remove_red_eye_outlined,color:kColorsBackground,size: .03.sh,):SizedBox(),

                  suffixIcon: inkell==null?SizedBox():inkell,
                  prefixIcon:iconData==null?null: Icon(

                    iconData,
                    color: kColorsPrimary,
                    size: 25.r,
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }
}