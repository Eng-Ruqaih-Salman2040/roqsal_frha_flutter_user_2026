import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Constants.dart';
import '../../apiservice/url.dart';
import '../../screen/shop_details/shop_details.dart';
import '../../screen/shop_details/shop_details_controller.dart';
import '../../widget/customButton.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../favorite/favorite_controller.dart';
import '../favorite/favorite_model.dart';
import '../login/login_model.dart';

class FavoriteItem extends StatelessWidget {
  final FavoriteShop favoriteShop;

  const FavoriteItem(this.favoriteShop, {super.key});

  void select(BuildContext ctx) {
    // تحويل FavoriteShop إلى Map متوافق مع shop_detailsScreen
    Map<String, dynamic> shopMap = {
      'id': favoriteShop.shopId,
      'nameShop': favoriteShop.shopName,
      'image': favoriteShop.shopImage,
      'adress': favoriteShop.shopAddress,
      'phone': favoriteShop.shopPhone,
      'email': favoriteShop.shopEmail,
      'price': favoriteShop.price.toString(),
      'viewer': favoriteShop.viewer.toString(),
      'description': favoriteShop.shopDescription,
      'cityName': favoriteShop.cityName,
      'sectionName': favoriteShop.sectionName,
    };

    if (MyData.auth_user) {
      late LoginModel loginModle = LoginModel.fromJson(GetStorage().read('store'));
      Get.put(shopDetailsController()).getGalleryApi(
        favoriteShop.shopId.toString(),
        loginModle.id.toString(),
      );
    } else {
      Get.put(shopDetailsController()).getGalleryApi(
        favoriteShop.shopId.toString(),
        "0",
      );
    }
    Get.to(() => shop_detailsScreen(shopMap));
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من إزالة هذا المتجر من المفضلة؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                String customers_id = '0';
                if (MyData.auth_user) {
                  try {
                    LoginModel loginModle = LoginModel.fromJson(
                      GetStorage().read('store'),
                    );
                    customers_id = loginModle.id.toString();
                  } catch (e) {
                    print('خطأ في جلب customer_id: $e');
                  }
                }

                final favController = Get.find<favoriteController>();
                favController.delete_favorite_postApi(
                  favoriteShop.shopId ?? '',
                  customers_id,
                  favoriteShop,
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () => select(context),
      borderRadius: BorderRadius.circular(16),
      splashColor: theme.primaryColor.withOpacity(0.1),
      highlightColor: theme.primaryColor.withOpacity(0.05),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المتجر
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    "${Url_shop}${favoriteShop.shopImage ?? 'default_image.png'}",
                    height: 180.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 180.h,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180.h,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.store,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),

                  // شارة السعر
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "${favoriteShop.price ?? 0} ريال",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // زر الحذف (في الجهة المقابلة)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => _showDeleteDialog(context),
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        iconSize: 22,
                        tooltip: 'إزالة من المفضلة',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // معلومات المتجر
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المتجر وعدد المشاهدات
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          favoriteShop.shopName ?? 'غير محدد',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.grey[900],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // عدد المشاهدات
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[800] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              size: 14.sp,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              "${favoriteShop.viewer ?? 0}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // معلومات الاتصال
                  _buildInfoRow(
                    icon: Icons.call,
                    text: favoriteShop.shopPhone ?? 'لا يوجد رقم',
                    context: context,
                  ),

                  SizedBox(height: 8.h),

                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    text: favoriteShop.shopEmail ?? 'لا يوجد بريد',
                    context: context,
                  ),

                  SizedBox(height: 8.h),

                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text: "${favoriteShop.cityName ?? ''} - ${favoriteShop.shopAddress ?? ''}",
                    context: context,
                  ),

                  SizedBox(height: 16.h),

                  // زر التفاصيل
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => select(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'عرض التفاصيل',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: isDark ? Colors.grey[400] : Colors.grey[600],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? Colors.grey[300] : Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}