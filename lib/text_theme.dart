


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Constants.dart';
ThemeData themeData=_buildThemeTest1();






ThemeData _buildThemeTest1() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    hintColor: test1_color2_900,
    primaryColor: test1_color1_100,
    //buttonColor: test1_color1_100,
    scaffoldBackgroundColor: test1_colorBackgroundWhite,
    cardColor: test1_colorBackgroundWhite,
    buttonTheme: const ButtonThemeData(
      colorScheme: _test1ColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconThemeTest1(base.iconTheme),
    textTheme: _buildTest1TextTheme(base.textTheme),
    primaryTextTheme: _buildTest1TextTheme(base.primaryTextTheme),
    iconTheme: _customIconThemeTest1(base.iconTheme),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kColorsWhite,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: test1_colorSurfaceWhite
      ),
      backgroundColor: test1_color1_100,
      titleTextStyle: TextStyle(
          fontSize: 16.0.sp,
          // fontWeight: FontWeight.w300,
          color: test1_colorSurfaceWhite
      ),
    ), colorScheme: _test1ColorScheme.copyWith(error: test1_color_ErrorRed),

    // primaryIconTheme:IconThemeData( color: kColorsBackground,) ,
    // focusColor: test1_color2_900,
    // hintColor: test1_color2_900,

    // primarySwatch: Colors.blue,

  );
}
TextTheme _buildTest1TextTheme(TextTheme base) {

  return base
      .copyWith(


    headlineSmall: TextStyle(
        fontSize: 16.0.sp,
        // fontWeight: FontWeight.w300,
        color: kColorsLightBlack
    ),
    headlineMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w500,
        color: kColorsLightBlack),
    displayLarge: TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
        color: kColorsBlack),
    displayMedium: TextStyle(
        fontSize: 18.0.sp,
        fontWeight: FontWeight.w300,
        color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w500,
        color:Colors.black),
    bodyMedium:
    TextStyle(fontSize: 14.0.sp, color: kColorsBlack),
    bodyLarge: TextStyle(fontSize: 12.0.sp, color: kColorsBlack, fontWeight: FontWeight.w300,),
    bodySmall: TextStyle(fontSize: 10.0.sp, color: Colors.grey, fontWeight: FontWeight.w300,),
    // button: base.button?.copyWith(
    //     fontWeight: FontWeight.w500,
    //     fontSize: 14,
    //     letterSpacing: defaultLetterSpacing,
    //   ),
  )
      .apply(
    fontFamily: 'ArbFONTS-DINNextLTArabic',
    displayColor: test1_color2_900,
    bodyColor: test1_color2_900,

  );
}
IconThemeData _customIconThemeTest1(IconThemeData original) {
  return original.copyWith(color: test1_color2_900);
}

const ColorScheme _test1ColorScheme = ColorScheme(
  primary: test1_color1_100,
  background: test1_color2_900,
  secondary: test1_color1_50,
  onBackground: test1_color2_900,
  surface: test1_colorSurfaceWhite,
  error: test1_color_ErrorRed,
  onPrimary: test1_color2_900,
  onSecondary: test1_color2_900,
  onSurface: test1_color2_900,
  onError: test1_colorSurfaceWhite,
  brightness: Brightness.light,
);

const Color test1_color1_50 = Color(0xFFAC7FFF);
const Color test1_color1_100 = Color(0xF59197CF);
const Color test1_color1_300 = Color(0xFFAC7FFF);
const Color test1_color1_400 = Color(0xFF3A286E);

const Color test1_color2_900 = Color(0xFF442B2D);
const Color test1_color2_600 = Color(0xFF7D4F52);

const Color test1_color_ErrorRed = Color(0xFFC5032B);

const Color test1_colorSurfaceWhite = Color(0xFFF3EFEF);
const Color test1_colorBackgroundWhite = Color(0xFFF8F8F8);


