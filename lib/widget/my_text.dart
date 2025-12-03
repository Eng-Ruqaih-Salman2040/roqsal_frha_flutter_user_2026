
import 'package:flutter/material.dart';

class MyText{


  //
  // static TextStyle display3(BuildContext context){
  //   return Theme.of(context).textTheme.display3;
  // }

  static TextStyle? display2(BuildContext context){
    return Theme.of(context).textTheme.headlineMedium;
  }

  static TextStyle? display1(BuildContext context){
    return Theme.of(context).textTheme.headlineMedium;
  }

  static TextStyle? headline(BuildContext context){
    return Theme.of(context).textTheme.headlineSmall;
  }

  static TextStyle? title(BuildContext context){
    return Theme.of(context).textTheme.titleLarge;
  }

  static TextStyle medium(BuildContext context){
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontSize: 18,
    );
  }

  static TextStyle? subhead(BuildContext context){
    return Theme.of(context).textTheme.titleMedium;
  }

  static TextStyle? body2(BuildContext context){
    return Theme.of(context).textTheme.bodyLarge;
  }

  static TextStyle? body1(BuildContext context){
    return Theme.of(context).textTheme.bodyMedium;
  }

  static TextStyle? caption(BuildContext context){
    return Theme.of(context).textTheme.bodySmall;
  }

  static TextStyle? button(BuildContext context){
    return Theme.of(context).textTheme.labelLarge;
  }

  static TextStyle? subtitle(BuildContext context){
    return Theme.of(context).textTheme.titleSmall;
  }

  static TextStyle? overline(BuildContext context){
    return Theme.of(context).textTheme.labelSmall;
  }
}