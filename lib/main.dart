


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:roqsal_frha_flutter2026/firebase_options.dart';
import '../../Constants.dart';
import '../../splash_screen.dart';
import '../../language/translations.dart';
import '../../router/custom_router.dart';
import '../../router/route_constants.dart';
import '../../text_theme.dart';

import 'apiservice/checkInterNet.dart';

void main() async{

  await GetStorage.init();

  Get.put(CheckInterNet());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // runApp(MaterialApp(debugShowCheckedModeBanner: false,home: MyApp()));
  runApp( MyApp());
// loginPost();
//runApp( DevicePreview(enabled: true, builder: (context) => MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key ?key}) : super( key: key );
  @override
  _MyAppState createState() => _MyAppState( );
}
class _MyAppState extends State<MyApp>{
  GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: Size(360, 690),
        builder: (context , child)  => GetMaterialApp(
          navigatorKey: mainNavigatorKey,
          debugShowCheckedModeBanner: false,
          // locale: DevicePreview.locale(context),
          //  builder: DevicePreview.appBuilder, //
          translations: Translation(),
          locale: Locale(GetStorage().read(language)??'ar'),
          fallbackLocale: Get.deviceLocale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English, no country code
            const Locale('ar', ''), // Arabic, no country code
          ],
          title: "title app",
          theme:themeData,
          //  home: LocationScreen(),
          getPages: Pages.pages(),
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 400),
          initialRoute: RoutingApp.splashRoute,
          // home: HomeScreen(),
        )
    );
  }}
