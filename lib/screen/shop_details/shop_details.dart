import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../screen/shop/shop_controller.dart';
import '../../screen/shop_details/shop_details_controller.dart';
import '../../Constants.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../favorite/favorite_controller.dart';
import '../login/login_model.dart';
import 'details.dart';
import 'item.dart';
import '../shop/shop_model.dart';

class shop_detailsScreen extends GetWidget<shopDetailsController> {
  final dynamic data; // يمكن أن يكون Shop أو Map

  // الحصول على الـ controller (تأكد من تسجيله)
  final favoriteController favCtrl = Get.find<favoriteController>();

  shop_detailsScreen(this.data) {
    // إذا كان المستخدم مسجل دخول ولم يتم تحميل المفضلة بعد، قم بتحميلها
    if (MyData.auth_user) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        late LoginModel loginModle = LoginModel.fromJson(
            GetStorage().read('store')
        );

        // تحميل المفضلة فقط إذا كانت فارغة
        if (favCtrl.favoriteList == null || favCtrl.favoriteList!.isEmpty) {
          favCtrl.getFavoriteApi(loginModle.id.toString());
        }
      });
    }
  }

  // دالة مساعدة للوصول إلى خصائص البيانات بأمان
  String? _getStringValue(String key, {String? defaultValue}) {
    if (data == null) return defaultValue;

    // إذا كان البيانات من نوع Shop
    if (data is Shop) {
      switch (key) {
        case 'id': return (data as Shop).id;
        case 'nameShop': return (data as Shop).nameShop;
        case 'image': return (data as Shop).image;
        case 'adress': return (data as Shop).adress;
        case 'phone': return (data as Shop).phone;
        case 'email': return (data as Shop).email;
        case 'price': return (data as Shop).price;
        case 'viewer': return (data as Shop).viewer;
        case 'description': return (data as Shop).description;
        case 'cityName': return (data as Shop).cityName;
        case 'sectionName': return (data as Shop).sectionName;
        default: return defaultValue;
      }
    }

    // إذا كان البيانات من نوع Map
    if (data is Map) {
      final value = (data as Map)[key];
      return value?.toString();
    }

    return defaultValue;
  }

  // دالة مساعدة للحصول على ID
  String get shopId {
    return _getStringValue('id') ??
        _getStringValue('shop_id') ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    String shopName = _getStringValue('nameShop') ??
        _getStringValue('shop_name') ??
        'تفاصيل المتجر';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          shopName,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          // استخدام Obx للاستماع للتغييرات في favoriteController
          Obx(() {
            // إذا كان المستخدم غير مسجل دخول، أظهر قلب رمادي
            if (!MyData.auth_user) {
              return IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.grey),
                onPressed: () {
                  GetSnackMsg(
                      msg: "يجب تسجيل الدخول لإضافة المفضلة",
                      bgClr: kColorRed,
                      txClr: kColorsWhite
                  ).showTxt();
                },
              );
            }

            // إذا كان يتم تحميل البيانات، أظهر مؤشر تحميل
            if (favCtrl.isLoading.value) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            // التحقق مما إذا كان المتجر في المفضلة
            bool isFavorite = favCtrl.isFavorite(shopId);

            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () async {
                late LoginModel loginModle = LoginModel.fromJson(
                    GetStorage().read('store')
                );

                if (isFavorite) {
                  // حذف من المفضلة
                  String? favId = favCtrl.getFavoriteId(shopId);
                  if (favId != null) {
                    await favCtrl.delete_favorite_postApi(
                      shopId,
                      loginModle.id.toString(),
                      data,
                    );
                  }
                } else {
                  // إضافة إلى المفضلة
                  await favCtrl.add_favorite_postApi(
                    shopId,
                    loginModle.id.toString(),
                    data,
                  );
                }
              },
            );
          }),
        ],
      ),
      body: controller.obx(
            (data) => SliderImageHeaderRoute(this.data, data!.gallery),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text('حدث خطأ: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // إعادة تحميل البيانات
                  if (MyData.auth_user) {
                    late LoginModel loginModle = LoginModel.fromJson(
                        GetStorage().read('store')
                    );
                    controller.getGalleryApi(shopId, loginModle.id.toString());
                  } else {
                    controller.getGalleryApi(shopId, "0");
                  }
                },
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}