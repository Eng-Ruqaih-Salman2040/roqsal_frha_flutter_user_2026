import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
    Key ?key, this.onPress, this.text, this.sizeHeight, this.sizeWidth, this.row, this.sizedBoxHeight, this.style, this.disabledColor, this.color, this.fontColor, this.borderColor, this.borderRadius,
 }) : super(key: key);
  final Function()? onPress;
  final String? text;
  final double ?sizeHeight;
  final double ?sizeWidth;
  final double ?borderRadius;
  final Widget ?row;
  final TextStyle? style;
  final Color ?disabledColor;
  final Color ?color;
  final Color ?fontColor;
  final Color ?borderColor;
   final sizedBoxHeight;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        sizedBoxHeight!=null? SizedBox(height:sizedBoxHeight,):SizedBox(),
        Container(
          width:sizeWidth==null? double.infinity:sizeWidth,
          height:sizeHeight==null? .07.sh:sizeHeight,

          decoration: BoxDecoration(
            border: Border.all(color:borderColor?? Colors.transparent,),
              borderRadius: BorderRadius.circular(
                  borderRadius?? 20.r),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                   color?? kColorsOrange,
                    color?? kColorsOrange
                  ])),
          child: MaterialButton(splashColor: kColorsPrimary,

            hoverColor: kColorsPrimary,
            padding: EdgeInsets.zero,

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(
                  borderRadius??  15.r), ),
            disabledColor: disabledColor,
            onPressed: onPress,

            child:row==null ?Padding(
              padding:  EdgeInsets.only(bottom:3.r),
              child: Text( text!,
                style:style!=null?
               style :Theme.of(context).textTheme.headlineMedium!.copyWith(color: fontColor??kColorsWhite,),
              textAlign: TextAlign.center,maxLines: 1,),
            ):row,
          ),
        ),
      ],
    );
  }
}