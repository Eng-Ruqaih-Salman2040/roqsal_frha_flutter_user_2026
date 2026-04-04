import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../router/route_constants.dart';
import '../../screen/login/login_contraller.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/my_colors.dart';
import '../../widget/my_text.dart';
import '../sign_up/sign_up.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  bool _rememberMe = false;
  late final LoginController controller = Get.put(LoginController());

  // Focus nodes for better keyboard navigation
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  //SignIn With Google
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    if(googleUser==null){
      return;
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAllNamed(RoutingApp.dashBoardScreenRoute);
  }


  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Unfocus keyboard when submitting
      FocusScope.of(context).unfocus();
      controller.loginApi();
    }
  }

  // Handle "Enter" key press
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white54,
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios_new_rounded,
        //     color: Colors.white ,
        //   ),
        //   onPressed: () => Get.back(),
        // ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: TextButton(
              onPressed: () {
                Get.offAllNamed(RoutingApp.dashBoardScreenRoute);
              },
              child: Text(
                "الدخول كضيف",
                style: TextStyle(
                  color: Color(0xFFAC7FFF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // Header Section
                _buildHeaderSection(isDarkMode),
                SizedBox(height: 40.h),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Username Field with animated label
                      _buildTextFieldWithLabel(
                        controller: controller.name,
                        focusNode: _usernameFocusNode,
                        label: "اسم المستخدم",
                        hint: "أدخل اسم المستخدم",
                        icon: Icons.person_outline_rounded,
                        isPassword: false,
                        onSubmitted: (_) => _fieldFocusChange(
                          context,
                          _usernameFocusNode,
                          _passwordFocusNode,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Password Field with visibility toggle
                      _buildTextFieldWithLabel(
                        controller: controller.password,
                        focusNode: _passwordFocusNode,
                        label: "كلمة المرور",
                        hint: "أدخل كلمة المرور",
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        isHidden: _isHidden,
                        onToggleVisibility: _togglePasswordView,
                        onSubmitted: (_) => _handleLogin(),
                      ),
                      SizedBox(height: 8.h),

                      // Remember Me & Forgot Password Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remember Me
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: _rememberMe
                                          ? Color(0xFFAC7FFF)
                                          : Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: _rememberMe
                                      ? Icon(
                                    Icons.check_rounded,
                                    size: 16.w,
                                    color: Color(0xFFAC7FFF),
                                  )
                                      : null,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "تذكرني",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white.withOpacity(0.6)
                                        : Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Forgot Password
                          TextButton(
                            onPressed: () {
                              // TODO: Implement forgot password
                              Get.snackbar(
                                "قريباً",
                                "ستتوفر هذه الميزة قريباً",
                                backgroundColor: Color(0xFFAC7FFF),
                                colorText: Colors.white,
                              );
                            },
                            child: Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                color: Color(0xFF80AFEC),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        text: 'Sign in'.tr,
                        color:  Color(0xFFAC7FFF),
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            //  GetStorage().write(token,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGdWxsTmFtZSI6Itix2KPZgdiqIiwiR3JvdXBfSUQiOiIyMCIsIkN1c3RvbWVyX0lEIjoiMjM1MSIsIlVTRVJfSUQiOiIxODI0MCIsIkRlcHRfSUQiOiIwIiwiQlJBTkNIU19JRCI6IjEiLCJCcmFuY2hfSUQiOiIxIiwiTG9jYXRpb24iOiIwIiwiRmFjaWxpdHlfSUQiOiIxIiwiRmluX1llYXIiOiIyMSIsIkVycFVybCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NjAwNjkvIiwiREJVcmwiOiIxMzQuMTE5LjIxNy4xMzkiLCJEQk5hbWUiOiJzczRpdGxnbl9FUlAiLCJEQlVzZXJuYW1lIjoic2EiLCJEQlBhc3N3b3JkIjoiU1M0SVRAU3RhbmQjOUAjIiwiVXNlcl9UeXBlIjoiY3VzdG9tZXIiLCJVc2VyX1R5cGVfSUQiOiIyIiwibmJmIjoxNjM3NDgyNzE4LCJleHAiOjI1ODQxNjc1MTgsImlhdCI6MTYzNzQ4MjcxOH0.mBmkFV_yElKgOpffDdj2a71iA_PZ93JjTYlX9o91xRo' );
                            controller.loginApi();

                          }

                        },
                      ),


                      // Login Button
                      // Obx(() {
                      //   return CustomButton(
                      //     text: 'تسجيل الدخول',
                      //     color: Color(0xFFAC7FFF),
                      //     textColor: Colors.white,
                      //     isLoading: controller.isLoading.value,
                      //     sizeHeight: 56.h,
                      //     borderRadius: 28.r,
                      //     elevation: 2,
                      //     onPress: _handleLogin,
                      //     icon: controller.isLoading.value
                      //         ? null
                      //         : Icon(
                      //       Icons.arrow_back_rounded,
                      //       color: Colors.white,
                      //       size: 20.w,
                      //       textDirection: TextDirection.ltr,
                      //     ),
                      //   );
                      // }),
                      SizedBox(height: 24.h),

                      // Or Divider
                      _buildOrDivider(isDarkMode),
                      SizedBox(height: 24.h),

                      // Social Login Buttons
                      _buildSocialLoginButtons(),
                      SizedBox(height: 32.h),

                      // Sign Up Section
                      _buildSignUpSection(isDarkMode),
                    ],
                  ),
                ),

                // Bottom Spacing
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo with gradient
        Center(
          child: Container(
              width: 130.w,
              height: 130.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFAC7FFF),
                    Color(0xFF4697FF),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFAC7FFF).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  "assets/logoo.png",
                  width: 150, height: 150,
                ),
              ) ),
        ),

        SizedBox(height: 24.h),

        // Welcome Text
        Text(
          "مرحباً بعودتك!",
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF050505),

            height: 1.2,
          ),
        ),
        SizedBox(height: 8.h),

        // Subtitle
        Text(
          "سجل دخولك للاستمرار في استخدام التطبيق فرحة",
          style: TextStyle(
            fontSize: 16.sp,
            color: Color(0xFF1C1C1C),

          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldWithLabel({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isHidden = true,
    VoidCallback? onToggleVisibility,
    Function(String)? onSubmitted,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating Label
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.translationValues(
            0,
            focusNode.hasFocus || controller.text.isNotEmpty ? 0 : 16.h,
            0,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: focusNode.hasFocus || controller.text.isNotEmpty
                  ? 12.sp
                  : 14.sp,
              color: focusNode.hasFocus
                  ? Color(0xFFAC7FFF)
                  : isDarkMode
                  ? Colors.white.withOpacity(0.6)
                  : Colors.black54,
              fontWeight: focusNode.hasFocus || controller.text.isNotEmpty
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ),
        SizedBox(height: 8.h),

        // Text Field with animated border
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: focusNode.hasFocus
                ? [
              BoxShadow(
                color: Color(0xF59197CF).withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ]
                : [],
          ),
          child: TextFieldWidget(
            controller: controller,
            focusNode: focusNode,
            hint: hint,
            requirement: true,
            iconData: icon,
            maxLine: 1,
            minLine: 1,
            isHidden: isPassword ? isHidden : false,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isHidden
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.grey.shade500,
              ),
              onPressed: onToggleVisibility,
            )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            borderColor: focusNode.hasFocus
                ? Color(0xFFAC7FFF)
                : Colors.grey.shade300,
            focusedBorderColor: Color(0xFFAC7FFF),
            textInputAction: isPassword
                ? TextInputAction.done
                : TextInputAction.next,
            onFieldSubmitted: onSubmitted,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'هذا الحقل مطلوب';
              }
              if (isPassword && value.length < 6) {
                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: isDarkMode
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.shade300,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            "أو",
            style: TextStyle(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.6)
                  : Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: isDarkMode
                ? Colors.white.withOpacity(0.2)
                : Colors.grey.shade300,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Button
        _buildSocialButton(
          icon: Icons.g_mobiledata_rounded,
          color: Colors.red,
          onTap: () {
            // TODO: Implement Google login
            signInWithGoogle();
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 28.w,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpSection(bool isDarkMode) {
    return Column(
      children: [
        Text(
          "ليس لديك حساب؟",
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.black38,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            Get.to(() => signUpScreen());
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xF59197CF).withOpacity(0.9),
                  Color(0xF5243083).withOpacity(0.1),


                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Color(0xF59197CF).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFFFFFFFF),
                  size: 18.w,
                ),
              ],
            ),          ),
        ),
      ],
    );
  }
}

