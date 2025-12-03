import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Constants.dart';
class CustomDatePaker extends StatelessWidget {
  const CustomDatePaker({
    Key? key,  this.hint, this.reqeurment, this.controller, this.onchange,
  }) : super(key: key);

  final String? hint;
  final bool ? reqeurment;
  final TextEditingController?  controller;
  final Function(DateTime? value)? onchange;
  String ?_errorMessage(bool str) {
    switch (str) {
      case true:
        return 'this filed requirement'.tr;
        break;
      case false:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.0.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Material(
      borderRadius: BorderRadius.circular(20.r),
      elevation:13 ,
      color: Colors.transparent,
      shadowColor: kColorsWhite,

            child: DateTimeField(

              onChanged: onchange,
              controller: controller,
              style:  Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                    validator:(value) {
                      if (value == null) {
                        //print('error'+error);
                        return _errorMessage( reqeurment! );
                        // ignore: missing_return
                      }
                    },
              readOnly:true ,
              decoration: InputDecoration(

                  filled: true,
                  fillColor:  kColorsWhite.withOpacity(.8),
                  hintStyle:  Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.grey),
                  hintText: hint,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 30.w),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(width: 1,color: kColorsPrimary)
                  )
              ),
              onShowPicker: (context, currentValue) {

                return showDatePicker(

                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              }, format:  DateFormat("yyyy-MM-dd"),

            ),
          ),
        ],
      ),
    );
  }
}