import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Constants.dart';
import 'widget/my_colors.dart';
import 'widget/my_text.dart';

import 'package:get/get.dart';

/// The app's themes.
/// This class is just there to connect readable names
/// to integer theme IDs.
class AppThemes {
  static const int LightBlue = 0;
  static const int LightRed = 1;
  static const int DarkBlue = 2;
  static const int DarkRed = 3;
  static const int test1 = 4;
  static const int test2 = 5;

  static String toStr(int themeId) {
    switch (themeId) {
      case LightBlue:
        return "الوضع الأفتراضي للنظام";
      case test1:
        return "فاتح";
      case test2:
        return "الوضع الليلي";
      default:
        return "Unknown";
    }
  }

  static ThemeData toStr2(int themeId) {
    switch (themeId) {
      case LightBlue:
        return _buildThemeTest1();
      case LightRed:
        return _buildShrineTheme();
      case DarkBlue:
        return ThemeData(primarySwatch: Colors.red);
      case DarkRed:
        return ThemeData.from(colorScheme: ColorScheme.dark(primary: Colors.red, secondary: Colors.red));
      case test1:
        return _buildThemeTest1();
      case test2:
        return _buildThemeTest2();
      default:
        return ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown).copyWith(background: Colors.red));
    }
  }
}

ThemeData _buildThemeTest1() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: test1_color1_100,
    scaffoldBackgroundColor: test1_colorBackgroundWhite,
    cardColor: test1_colorBackgroundWhite,
    textTheme: _buildTest1TextTheme(base.textTheme),
    primaryTextTheme: _buildTest1TextTheme(base.primaryTextTheme),
    iconTheme: _customIconThemeTest1(base.iconTheme),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kColorsWhite,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: test1_colorSurfaceWhite),
      backgroundColor: test1_color1_100,
      titleTextStyle: TextStyle(
        fontSize: 16.0.sp,
        color: test1_colorSurfaceWhite,
      ),
    ), colorScheme: _test1ColorScheme.copyWith(error: test1_color_ErrorRed),
  );
}

TextTheme _buildTest1TextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: TextStyle(
      fontSize: 16.0.sp,
      color: kColorsLightBlack,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      color: kColorsLightBlack,
    ),
    displayLarge: TextStyle(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.bold,
      color: kColorsBlack,
    ),
    displayMedium: TextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0.sp,
      color: kColorsBlack,
    ),
    bodyMedium: TextStyle(
      fontSize: 12.0.sp,
      color: kColorsBlack,
      fontWeight: FontWeight.w300,
    ),
    bodySmall: TextStyle(
      fontSize: 10.0.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
    ),
  ).apply(
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
  primaryContainer: test1_color2_900,
  secondary: test1_color1_50,
  secondaryContainer: test1_color2_900,
  surface: test1_colorSurfaceWhite,
  background: test1_colorBackgroundWhite,
  error: test1_color_ErrorRed,
  onPrimary: test1_color2_900,
  onSecondary: test1_color2_900,
  onSurface: test1_color2_900,
  onBackground: test1_color2_900,
  onError: test1_colorSurfaceWhite,
  brightness: Brightness.light,
);

const Color test1_color1_50 = Color(0xFF158BAC);
const Color test1_color1_100 = Color(0xFF158BA4);
const Color test1_color1_300 = Color(0xFF036E92);
const Color test1_color1_400 = Color(0xFF005163);

const Color test1_color2_900 = Color(0xFF442B2D);
const Color test1_color2_600 = Color(0xFF7D4F52);

const Color test1_color_ErrorRed = Color(0xFFC5032B);

const Color test1_colorSurfaceWhite = Color(0xF5EEF1F8);
const Color test1_colorBackgroundWhite = Color(0xF5EEF1F8);

ThemeData _buildThemeTest2() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _test2ColorScheme,
    primaryColor: test2_color1_100,
    scaffoldBackgroundColor: test2_colorBackgroundWhite,
    cardColor: test2_colorBackgroundWhite,
    hoverColor: test2_color_ErrorRed,
    textTheme: _buildTest2TextTheme(base.textTheme),
    primaryTextTheme: _buildTest2TextTheme(base.primaryTextTheme),
    iconTheme: _customIconThemeTest2(base.iconTheme),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: kColorsWhite,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: test2_colorSurfaceWhite),
      backgroundColor: test2_color1_100,
      titleTextStyle: TextStyle(
        fontSize: 16.0.sp,
        color: test2_colorSurfaceWhite,
      ),
    ),
  );
}

TextTheme _buildTest2TextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: TextStyle(
      fontSize: 16.0.sp,
      color: kColorsLightBlack,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      color: kColorsLightBlack,
    ),
    displayLarge: TextStyle(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.bold,
      color: kColorsBlack,
    ),
    displayMedium: TextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0.sp,
      color: kColorsBlack,
    ),
    bodyMedium: TextStyle(
      fontSize: 12.0.sp,
      color: kColorsBlack,
      fontWeight: FontWeight.w300,
    ),
    bodySmall: TextStyle(
      fontSize: 10.0.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w300,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  ).apply(
    fontFamily: 'ArbFONTS-DINNextLTArabic',
    displayColor: test2_color2_900,
    bodyColor: test2_color2_900,
  );
}

IconThemeData _customIconThemeTest2(IconThemeData original) {
  return original.copyWith(color: test2_color2_900);
}

const ColorScheme _test2ColorScheme = ColorScheme(
  primary: test2_color1_100,
  primaryContainer: test2_color2_900,
  secondary: test2_color1_50,
  secondaryContainer: test2_color2_900,
  surface: test2_colorSurfaceWhite,
  background: test2_colorBackgroundWhite,
  error: test2_color_ErrorRed,
  onPrimary: test2_color2_900,
  onSecondary: test2_color2_900,
  onSurface: test2_color2_900,
  onBackground: test2_color2_900,
  onError: test2_colorSurfaceWhite,
  brightness: Brightness.dark,
);

const Color test2_color1_50 = Color(0xFF263E45);
const Color test2_color1_100 = Color(0xFF243438);
const Color test2_color1_300 = Color(0xFF111F26);
const Color test2_color1_400 = Color(0xFF1D4850);

const Color test2_color2_900 = Color(0xFF442B2D);
const Color test2_color2_600 = Color(0xFF7D4F52);

const Color test2_color_ErrorRed = Color(0xFFC5032B);

const Color test2_colorSurfaceWhite = Color(0xFF171413);
const Color test2_colorBackgroundWhite = Colors.black87;

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme), colorScheme: _shrineColorScheme.copyWith(error: shrineErrorRed),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontWeight: FontWeight.w500,
      letterSpacing: defaultLetterSpacing,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontSize: 18,
      letterSpacing: defaultLetterSpacing,
    ),
    bodySmall: base.bodySmall?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      letterSpacing: defaultLetterSpacing,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      letterSpacing: defaultLetterSpacing,
    ),
    displayMedium: base.displayMedium?.copyWith(
      letterSpacing: defaultLetterSpacing,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: defaultLetterSpacing,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: shrineBrown900,
    bodyColor: shrineBrown900,
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryContainer: shrineBrown900,
  secondary: shrinePink50,
  secondaryContainer: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;

class DynamicThemesExampleAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = ThemeData.dark();
    final darkButtonTheme = dark.buttonTheme.copyWith(buttonColor: Colors.grey[700]);
    final darkFABTheme = dark.floatingActionButtonTheme;

    final themeCollection = ThemeCollection(
      themes: {
        AppThemes.LightBlue: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: kColorsWhite,
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 16.0.sp,
              color: kColorsLightBlack,
            ),
            titleMedium: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            titleSmall: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              color: kColorsLightBlack,
            ),
            displayLarge: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
              color: kColorsBlack,
            ),
            displayMedium: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            displaySmall: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
              fontSize: 14.0.sp,
              color: kColorsBlack,
            ),
            bodyMedium: TextStyle(
              fontSize: 12.0.sp,
              color: kColorsBlack,
              fontWeight: FontWeight.w300,
            ),
            bodySmall: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            ),
          ),
          iconTheme: IconThemeData(
            color: kColorsBlack,
          ),
          scaffoldBackgroundColor: kColorsDeepWhite,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: kColorsBlack),
            backgroundColor: kColorsDeepWhite,
          ),
          primaryColor: kColorsWhite,
          fontFamily: 'ArbFONTS-DINNextLTArabic',
          primarySwatch: Colors.blue,
        ),
        AppThemes.LightRed: _buildShrineTheme(),
        AppThemes.DarkBlue: dark.copyWith(
          buttonTheme: darkButtonTheme,
          floatingActionButtonTheme: darkFABTheme.copyWith(backgroundColor: Colors.red),
        ),
        AppThemes.DarkRed: ThemeData.from(colorScheme: ColorScheme.dark(primary: Colors.red, secondary: Colors.red)),
        AppThemes.test1: _buildThemeTest1(),
        AppThemes.test2: _buildThemeTest2(),
      },
    );

    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: AppThemes.LightBlue,
      builder: (context, theme) {
        return MaterialApp(
          title: 'إعدادات',
          theme: theme,
          home: HomePage(title: 'إعدادات'),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int dropdownValue = 0;
  bool isSwitched1 = true, isSwitched2 = false;
  bool isSwitched3 = false, isSwitched4 = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dropdownValue = DynamicTheme.of(context)!.themeId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("الثيم", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
              margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.theater_comedy, size: 25.0, color: Colors.grey[500]),
                            Container(width: 10),
                            DropdownButton(
                              value: dropdownValue,
                              items: [
                                DropdownMenuItem(
                                  value: AppThemes.LightBlue,
                                  child: Text(AppThemes.toStr(AppThemes.LightBlue)),
                                ),
                                DropdownMenuItem(
                                  value: AppThemes.test1,
                                  child: Text(AppThemes.toStr(AppThemes.test1)),
                                ),
                                DropdownMenuItem(
                                  value: AppThemes.test2,
                                  child: Text(AppThemes.toStr(AppThemes.test2)),
                                )
                              ],
                              onChanged: (dynamic themeId) async {
                                await DynamicTheme.of(context)!.setTheme(themeId);
                                print("f");
                                Get.changeTheme(AppThemes.toStr2(themeId));
                                print("ppp");
                                setState(() {
                                  print("yyyyyyyyyyyyyyy");
                                  dropdownValue = themeId;
                                });
                              },
                            ),
                            Spacer(),
                            Icon(Icons.arrow_downward, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ),
            // ... rest of your HomePage widget remains the same
            Container(
              child: Text("الحسابات", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
              margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
            ),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 25.0, color: Colors.grey[500]),
                            Container(width: 10),
                            Text("حسابي", style: MyText.subhead(context)!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.password, size: 25.0, color: Colors.grey[500]),
                            Container(width: 10),
                            Text("تغيير كلمة السر", style: MyText.subhead(context)!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.fingerprint, size: 25.0, color: Colors.blueAccent),
                            Container(width: 10),
                            Text("تفعيل البصمة", style: MyText.subhead(context)!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            Spacer(),
                            Switch(
                              value: isSwitched1,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched1 = value;
                                });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.repeat, size: 25.0, color: Colors.yellow[800]),
                            Container(width: 10),
                            Text("دوران الشاشة", style: MyText.subhead(context)!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            Spacer(),
                            Switch(
                              value: isSwitched1,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched1 = value;
                                });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.email, size: 25.0, color: Colors.red[400]),
                            Container(width: 10),
                            Text("Gmail", style: MyText.subhead(context)!.copyWith(color: Colors.grey[600], fontWeight: FontWeight.w500)),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),

                    Container(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              child: Text("الشبكة", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
              margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
            ),
            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.wifi, size: 25.0, color: Colors.yellow[800]),
                            Container(width: 10),
                            Text("Wifi", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Switch(
                              value: isSwitched1,
                              onChanged: (value) {
                                setState(() { isSwitched1 = value; });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.sync, size: 25.0, color: Colors.blue[300]),
                            Container(width: 10),
                            Text("مزامنة البياتات", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.bluetooth, size: 25.0, color: Colors.blue[500]),
                            Container(width: 10),
                            Text("Bluetooth", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Switch(
                              value: isSwitched2,
                              onChanged: (value) {
                                setState(() { isSwitched2 = value; });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.more_horiz, size: 25.0, color: Colors.grey[500]),
                            Container(width: 10),
                            Text("More", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ),
            Container(
              child: Text("SOUND", style: MyText.body1(context)!.copyWith(color: Colors.grey[500])),
              margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
            ),

            Card(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0)),
              elevation: 2,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(height: 10),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.do_not_disturb_off, size: 25.0, color: Colors.orange[300]),
                            Container(width: 10),
                            Text("Silent Mode", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Switch(
                              value: isSwitched3,
                              onChanged: (value) {
                                setState(() { isSwitched3 = value; });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.vibration, size: 25.0, color: Colors.grey[500]),
                            Container(width: 10),
                            Text("Vibrate Mode", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Switch(
                              value: isSwitched4,
                              onChanged: (value) {
                                setState(() { isSwitched4 = value; });
                              },
                              activeColor: MyColors.primary,
                              inactiveThumbColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.volume_up, size: 25.0, color: Colors.green[500]),
                            Container(width: 10),
                            Text("Sound Volume", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.notifications, size: 25.0, color: Colors.grey[400]),
                            Container(width: 10),
                            Text("Ringtone", style: MyText.subhead(context)!.copyWith(
                                color: Colors.grey[600], fontWeight: FontWeight.w500
                            )),
                            Spacer(),
                            Icon(Icons.chevron_right, size: 25.0, color: Colors.grey[500]),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}