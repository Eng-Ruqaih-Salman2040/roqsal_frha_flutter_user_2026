import 'package:get/get.dart';
import '../apiservice/checkInterNet.dart';
import '../screen/notifications/notifications_contraller.dart';
import '../screen/section/section_controller.dart';
import '../screen/shop/shop_controller.dart';
import '../screen/sliderAds/ads_controller.dart';



class CheckInternetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInterNet>(
          () => CheckInterNet(),
    );
  }
}


class MagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<shopController>(
          () => shopController(),
    );
  }
}

class sectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<sectionController>(
          () => sectionController(),
    );
  }
}
class agsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<adsController>(
          () => adsController(),
    );
  }
}





class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsController>(
          () => NotificationsController(),
    );
  }
}
