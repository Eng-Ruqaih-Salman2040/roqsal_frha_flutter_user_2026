
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../binding/binding.dart';
import '../screen/home_screen.dart';
import '../splash_screen.dart';
import '../screen/card_wizard_overlap.dart';
import '../screen/dashboard_screen.dart';
import '../screen/help_screen.dart';
import '../screen/login/login.dart';
import '../screen/section/section.dart';
import 'route_constants.dart';


class Pages {
 static List<GetPage> pages() {
    return [
   GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.homeRoute,
        page: () => HomeScreen(),



      ),   GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.splashRoute,
        page: () => SplashScreen(),



      ),

      GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.loginRoute,
        page: () => LoginScreen(),



      ),GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.InteroRoute,
        page: () => CardWizardOverlapRoute(),
      ),
      // CardWizardOverlapRoute
      // IntroductionAnimationScreen
      GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.dashBoardScreenRoute,
        page: () => DashBoardScreen(),

      ),

      GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.HelpRoute,
        page: () => HelpScreen(),
      ),
      GetPage(
        transition: Transition.native,
        transitionDuration: Duration(milliseconds: 400),
        name:  RoutingApp.callageRoute,
        page: () => sectionScreen(),
        bindings: [
          CheckInternetBinding(),
          sectionBinding()
    ]

      ),
    ];
  }
}