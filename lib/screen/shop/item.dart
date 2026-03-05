import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // لإضافة responsive design
import '../../screen/section/section_model.dart';
import '../../apiservice/url.dart';
import '../../widget/customButton.dart';
import '../../widget/my_data.dart';
import '../../widget/my_text.dart';
import '../login/login_model.dart';
import '../shop_details/shop_details.dart';
import '../shop_details/shop_details_controller.dart';

class Item extends StatelessWidget {
  final dynamic data;
  final VoidCallback? onTap;

  Item(this.data, {this.onTap});

  void select(BuildContext ctx) {
    if (onTap != null) {
      onTap!();
      return;
    }

    if (MyData.auth_user) {
      late LoginModel loginModel = LoginModel.fromJson(GetStorage().read('store'));
      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(), loginModel.id.toString());
      Get.to(() => shop_detailsScreen(this.data));
    } else {
      Get.put(shopDetailsController()).getGalleryApi(data.id.toString(), "0");
      Get.to(() => shop_detailsScreen(this.data));
    }
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
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المتجر
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    Url_shop + data.image.toString(),
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
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        data.price.toString() + " ريال",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
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
                  // اسم المتجر
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.nameShop.toString(),
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
                              data.viewer.toString(),
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
                    text: data.phone.toString(),
                    context: context,
                  ),

                  SizedBox(height: 8.h),

                  _buildInfoRow(
                    icon: Icons.email_outlined,
                    text: data.email.toString(),
                    context: context,
                  ),

                  SizedBox(height: 8.h),

                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text: data.cityName.toString() + " - " + data.adress.toString(),
                    context: context,
                  ),

                  SizedBox(height: 16.h),

                  // زر التفاصيل
                  Container(
                    width: double.infinity,
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
