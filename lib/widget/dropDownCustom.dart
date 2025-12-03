import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../Constants.dart';

class DropDownCustom extends StatelessWidget {


   DropDownCustom({Key? key, required this.requirement, required this.hint, this.items,  this.value, required this.onChange,  }) : super(key: key);
  final bool requirement;
  final String hint;

  final dynamic items;
  final dynamic value;

  final  ValueChanged onChange;


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

 // final item=['item1','item2','item3','item4','item15','item6','item7','item8','item9','item10',];


@override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 0.02.sh),
      child: Material(


               borderRadius: BorderRadius.circular(20.r),
               elevation:13 ,
               color: Colors.transparent,
               shadowColor: kColorsWhite,
               child: DropdownButtonHideUnderline(
                 child: DropdownButtonFormField<dynamic>(



                   validator:(value) {
                     if (value == null) {
                       //print('error'+error);
                       return _errorMessage(requirement);
                       // ignore: missing_return
                     }
                   },

                   style: Theme.of(context).textTheme.displaySmall,

                   hint:Text(hint,style: Theme.of(context).textTheme.displaySmall,),
                   decoration: InputDecoration(

                       filled: true,
                       fillColor:  kColorsWhite.withOpacity(.8),
                       errorMaxLines: 1,

                       hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.grey),
                       contentPadding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 30.w),
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

                       //  suffixIcon: inkell==null?SizedBox():inkell,
                       suffixIcon: Icon(

                         Icons.arrow_drop_down,
                         color: kColorsPrimary,
                         size: 25.r,
                       )
                   ),

                   alignment: Alignment.topCenter,
                   value: value,
                   iconSize:0,

                   isDense: false,
                   //icon: Icon(Icons.arrow_drop_down,color: kColorsPrimary,),
                   isExpanded: true,

                   items: items,

                   onChanged: onChange,
                   ),

                 ),
               ),
    );
  }
}