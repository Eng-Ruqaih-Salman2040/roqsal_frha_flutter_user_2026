import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {

  // روابط التواصل
  final String websiteUrl = 'https://FARHAH.com';
  final String email = 'info@farhah.com';
  final String address = '3265 Hinkle Deegan Lake Road, Dundee New York, United States';
  final String phoneNumber = '+967772200283';
  final String instagramUrl = 'https://instagram.com/farhah';
  final String twitterUrl = 'https://twitter.com/farhah';

  // دالة فتح الروابط
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  // دالة فتح البريد الإلكتروني
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=استفسار حول التطبيق',
    );
    if (!await launchUrl(emailUri)) {
      throw 'Could not launch email';
    }
  }

  // دالة الاتصال
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(phoneUri)) {
      throw 'Could not launch phone dialer';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[50],

      // AppBar محسنة
      appBar: AppBar(
        title: Text(
          "حول التطبيق",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },),


        actions: [
          Container(
            margin: EdgeInsets.only(left: 8.w),
            child: PopupMenuButton<String>(
              onSelected: (String value) {

                if (value == 'share') {
                  // مشاركة التطبيق
                }
                else if (value == 'rate') {
                  // تقييم التطبيق
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Icon(
                Icons.more_vert,
                size: 22.sp,
                color: Colors.white,
              ),

              itemBuilder: (context) => [
                // PopupMenuItem(
                //   value: "settings",
                //   child: Row(
                //     children: [
                //       Icon(Icons.settings_outlined, size: 20.sp, color: theme.primaryColor),
                //       SizedBox(width: 10.w),
                //       Text("الإعدادات"),
                //     ],
                //   ),
                // ),
                PopupMenuItem(
                  value: "share",
                  child: Row(
                    children: [
                      Icon(Icons.share_outlined, size: 20.sp, color: theme.primaryColor),
                      SizedBox(width: 10.w),
                      Text("مشاركة التطبيق"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "rate",
                  child: Row(
                    children: [
                      Icon(Icons.star_outline, size: 20.sp, color: theme.primaryColor),
                      SizedBox(width: 10.w),
                      Text("تقييم التطبيق"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.primaryColor,
                theme.primaryColor.withBlue(220),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10.h),

            // بطاقة معلومات التطبيق
            _buildInfoCard(
              theme,
              isDark,
              children: [
                // شعار التطبيق
                Row(
                  children: [
                    // شعار دائري مع تأثير
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.primaryColor,
                            theme.primaryColor.withOpacity(0.7),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primaryColor.withOpacity(0.3),
                            blurRadius: 15.r,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage: AssetImage("assets/logoo.png"),

                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    // اسم التطبيق
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "فرحة",
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "FARHAH",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "الإصدار 2.0",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // خط فاصل مع تأثير
                Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.grey.withOpacity(0.2),
                ),

                SizedBox(height: 20.h),

                // معلومات التطبيق
                _buildInfoItem(
                  theme,
                  icon: Icons.info_outline_rounded,
                  title: "الإصدار",
                  subtitle: "1.0.0",
                  onTap: () {
                    // عرض معلومات الإصدار
                  },
                ),

                _buildInfoItem(
                  theme,
                  icon: Icons.update_rounded,
                  title: "سجل التحديثات",
                  subtitle: "Changelog",
                  showArrow: true,
                  onTap: () {
                    // عرض سجل التحديثات
                  },
                ),

                _buildInfoItem(
                  theme,
                  icon: Icons.description_outlined,
                  title: "الترخيص",
                  subtitle: "رخصة الاستخدام",
                  showArrow: true,
                  onTap: () {
                    // عرض الترخيص
                  },
                ),

                _buildInfoItem(
                  theme,
                  icon: Icons.privacy_tip_outlined,
                  title: "سياسة الخصوصية",
                  showArrow: true,
                  onTap: () {
                    // عرض سياسة الخصوصية
                  },
                ),
              ],
            ),

            // بطاقة التواصل
            _buildInfoCard(
              theme,
              isDark,
              children: [
                // عنوان القسم
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Text(
                    "تواصل معنا",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // روابط التواصل
                _buildContactItem(
                  theme,
                  icon: Icons.language_rounded,
                  title: "الموقع الإلكتروني",
                  subtitle: websiteUrl,
                  onTap: () => _launchUrl(websiteUrl),
                ),

                _buildContactItem(
                  theme,
                  icon: Icons.email_outlined,
                  title: "البريد الإلكتروني",
                  subtitle: email,
                  onTap: () => _launchEmail(email),
                ),

                _buildContactItem(
                  theme,
                  icon: Icons.phone_outlined,
                  title: "رقم الهاتف",
                  subtitle: phoneNumber,
                  onTap: () => _makePhoneCall(phoneNumber),
                ),

                // روابط التواصل الاجتماعي
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSocialButton(
                      theme,
                      icon: FontAwesomeIcons.instagram,
                      color: Colors.purple,
                      onTap: () => _launchUrl(instagramUrl),
                    ),
                    _buildSocialButton(
                      theme,
                      icon: FontAwesomeIcons.twitter,
                      color: Colors.blue,
                      onTap: () => _launchUrl(twitterUrl),
                    ),
                    _buildSocialButton(
                      theme,
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      onTap: () => _launchUrl('https://wa.me/$phoneNumber'),
                    ),
                    _buildSocialButton(
                      theme,
                      icon: FontAwesomeIcons.telegram,
                      color: Colors.lightBlue,
                      onTap: () => _launchUrl('https://t.me/farhah'),
                    ),
                  ],
                ),
              ],
            ),

            // بطاقة الموقع
            _buildInfoCard(
              theme,
              isDark,
              children: [
                _buildContactItem(
                  theme,
                  icon: Icons.business_center_outlined,
                  title: "الشركة",
                  subtitle: "فرحة للتطبيقات",
                ),

                _buildContactItem(
                  theme,
                  icon: Icons.location_on_outlined,
                  title: "العنوان",
                  subtitle: address,
                  isMultiline: true,
                ),

                // زر فتح الخريطة
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () => _launchUrl('https://maps.google.com/?q=$address'),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor.withOpacity(0.1),
                          theme.primaryColor.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 18.sp,
                          color: theme.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          "عرض على الخريطة",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // حقوق النشر
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "© 2026 فرحة - جميع الحقوق محفوظة",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء بطاقة المعلومات
  Widget _buildInfoCard(ThemeData theme, bool isDark, {required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20.r,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  // دالة بناء عنصر معلومات
  Widget _buildInfoItem(
      ThemeData theme, {
        required IconData icon,
        required String title,
        String? subtitle,
        bool showArrow = false,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: theme.primaryColor,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: Colors.grey[400],
              ),
          ],
        ),
      ),
    );
  }

  // دالة بناء عنصر تواصل
  Widget _buildContactItem(
      ThemeData theme, {
        required IconData icon,
        required String title,
        required String subtitle,
        bool isMultiline = false,
        VoidCallback? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: theme.primaryColor,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: isMultiline ? 3 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة بناء زر التواصل الاجتماعي
  Widget _buildSocialButton(
      ThemeData theme, {
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 45.w,
        height: 45.h,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          size: 22.sp,
          color: color,
        ),
      ),
    );
  }
}