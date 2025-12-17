import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../screen/sign_up/sign_up_contraller.dart';
import '../../widget/customButton.dart';
import '../../widget/customButton.dart';
import '../../widget/custom_textfeild.dart';
import '../../widget/my_colors.dart';

class signUpScreen extends StatefulWidget {
  @override
  State<signUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<signUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final signUpController controller = Get.put(signUpController());
  bool _isHidden = true;
  bool _termsAccepted = false;

  // Focus nodes for better navigation
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      FocusScope.of(context).unfocus();
      controller.postApi();
    } else if (!_termsAccepted) {
      Get.snackbar(
        "يرجى الموافقة على الشروط",
        "يجب الموافقة على الشروط والأحكام للمتابعة",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  void _fieldFocusChange(int currentIndex, int nextIndex) {
    _focusNodes[currentIndex].unfocus();
    FocusScope.of(context).requestFocus(_focusNodes[nextIndex]);
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Color(0xF5383D67),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.black,

        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.white,
            size: 22.w,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "إنشاء حساب جديد",
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.white,

            fontSize: 20.sp,
            fontWeight: FontWeight.w700,

          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),

                // Header Image/Icon
                _buildHeaderSection(isDarkMode),
                SizedBox(height: 32.h),

                // Registration Steps Indicator تبع
                // _buildStepsIndicator(),
                // SizedBox(height: 32.h),

                // Form Fields
                Column(
                  children: [
                    _buildTextFieldWithLabel(
                      index: 0,
                      controller: controller.name,
                      label: "الاسم الكامل",
                      hint: "أدخل اسمك الكامل",
                      icon: Icons.person_outline_rounded,
                      nextIndex: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الاسم الكامل';
                        }
                        if (value.length < 3) {
                          return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    _buildTextFieldWithLabel(
                      index: 1,
                      controller: controller.email,
                      label: "البريد الإلكتروني",
                      hint: "example@email.com",
                      icon: Icons.email_outlined,
                      textInputType: TextInputType.emailAddress,
                      nextIndex: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال البريد الإلكتروني';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'يرجى إدخال بريد إلكتروني صحيح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    _buildTextFieldWithLabel(
                      index: 2,
                      controller: controller.phone,
                      label: "رقم الجوال",
                      hint: "+967XXXXXXXX",
                      icon: Icons.phone_android_outlined,
                      textInputType: TextInputType.phone,
                      nextIndex: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال رقم الجوال';
                        }
                        if (!RegExp(r'^05[0-9]{8}$').hasMatch(value)) {
                          return 'يرجى إدخال رقم جوال صحيح';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    _buildTextFieldWithLabel(
                      index: 3,
                      controller: controller.pass,
                      label: "كلمة المرور",
                      hint: "أدخل كلمة المرور",
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                      isHidden: _isHidden,
                      onToggleVisibility: _togglePasswordView,
                      nextIndex: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال كلمة المرور';
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                        }
                        if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])').hasMatch(value)) {
                          return 'يجب أن تحتوي على أحرف وأرقام';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    // Password Strength Indicator
                    _buildPasswordStrengthIndicator(controller.pass.text),
                    SizedBox(height: 20.h),

                    // Confirm Password
                    _buildTextFieldWithLabel(
                      index: 4,
                      controller: TextEditingController(), // Add confirm password controller
                      label: "تأكيد كلمة المرور",
                      hint: "أعد إدخال كلمة المرور",
                      icon: Icons.lock_reset_outlined,
                      isPassword: true,
                      validator: (value) {
                        if (value != controller.pass.text) {
                          return 'كلمات المرور غير متطابقة';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Terms and Conditions
                    _buildTermsCheckbox(isDarkMode),
                    SizedBox(height: 32.h),

                    // Sign Up Button
                    CustomButton(
                      text: 'إنشاء حساب',
                           color: _termsAccepted ? Color(0xFF9169DA): Colors.grey,
                           textColor: Colors.white,
                           sizeHeight: 56.h,
                           borderRadius: 28.r,
                         elevation: 3,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          controller.postApi();

                        }

                      },
                    ),
                    // Obx(() {
                    //   return CustomButton(
                    //     text: 'إنشاء حساب',
                    //     color: _termsAccepted ? Color(0xFF9169DA) : Colors.grey,
                    //     textColor: Colors.white,
                    //     isLoading: controller.isLoading.value,
                    //     sizeHeight: 56.h,
                    //     borderRadius: 28.r,
                    //     elevation: 3,
                    //     onPress: _handleSignUp,
                    //     icon: controller.isLoading.value
                    //         ? null
                    //         : Icon(
                    //       Icons.person_add_alt_1_rounded,
                    //       color: Colors.white,
                    //       size: 20.w,
                    //     ),
                    //   );
                    // }),
                    SizedBox(height: 24.h),

                    // Already have account
                    _buildLoginLink(isDarkMode),
                    SizedBox(height: 32.h),

                    // Divider with "أو"
                    _buildOrDivider(isDarkMode),
                    SizedBox(height: 24.h),

                    // Social Sign Up
                    _buildSocialSignUp(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isDarkMode) {
    return Column(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9169DA),
                Color(0xFF6A4C93),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF9169DA).withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.person_add_alt_1_rounded,
              color: Colors.white,
              size: 50.w,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "انضم إلينا الآن",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,

            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.white,

          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "أنشئ حسابك واستمتع بجميع المزايا",
          style: TextStyle(
            fontSize: 14.sp,
            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.white,

          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
// لبعدين يتم التعديل علية
  // Widget _buildStepsIndicator() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
  //     decoration: BoxDecoration(
  //       color: Color(0xFF9169DA).withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(20.r),
  //       border: Border.all(
  //         color: Color(0xFF9169DA).withOpacity(0.3),
  //         width: 1,
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         _buildStep(1, "المعلومات", true),
  //         Container(
  //           width: 40.w,
  //           height: 1,
  //           color: Color(0xFF9169DA).withOpacity(0.5),
  //           margin: EdgeInsets.symmetric(horizontal: 8.w),
  //         ),
  //         _buildStep(2, "التحقق", false),
  //         Container(
  //           width: 40.w,
  //           height: 1,
  //           color: Color(0xFF9169DA).withOpacity(0.3),
  //           margin: EdgeInsets.symmetric(horizontal: 8.w),
  //         ),
  //         _buildStep(3, "التفعيل", false),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStep(int number, String text, bool isActive) {
    return Column(
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF9169DA) : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xFF9169DA) : Colors.grey.shade600,
            fontSize: 10.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldWithLabel({
    required int index,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isHidden = true,
    TextInputType textInputType = TextInputType.text,
    int? nextIndex,
    VoidCallback? onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating Label with counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              transform: Matrix4.translationValues(
                0,
                _focusNodes[index].hasFocus || controller.text.isNotEmpty ? 0 : 16.h,
                0,
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: _focusNodes[index].hasFocus || controller.text.isNotEmpty
                      ? 12.sp
                      : 14.sp,
                  color: _focusNodes[index].hasFocus
                      ? Color(0xFF9169DA)
                      : isDarkMode
                      ? Colors.white.withOpacity(0.6)
                      : Colors.black54,
                  fontWeight: _focusNodes[index].hasFocus || controller.text.isNotEmpty
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
            if (isPassword && controller.text.isNotEmpty)
              Text(
                "${controller.text.length}/8",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: controller.text.length >= 6
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),

        // Text Field with animated border
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: _focusNodes[index].hasFocus
                ? [
              BoxShadow(
                color: Color(0xFF9169DA).withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ]
                : [],
          ),
          child: TextFieldWidget(
            controller: controller,
            focusNode: _focusNodes[index],
            hint: hint,
            requirement: true,
            iconData: icon,
            maxLine: 1,
            minLine: 1,
            textInputType: textInputType,
            isHidden: isPassword ? isHidden : false,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                isHidden
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.grey.shade500,
                size: 20.w,
              ),
              onPressed: onToggleVisibility,
            )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            borderColor: _focusNodes[index].hasFocus
                ? Color(0xFF9169DA)
                : Colors.grey.shade300,
            focusedBorderColor: Color(0xFF9169DA),
            textInputAction: nextIndex != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: (_) {
              if (nextIndex != null && nextIndex < _focusNodes.length) {
                _fieldFocusChange(index, nextIndex);
              } else {
                _handleSignUp();
              }
            },
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStrengthIndicator(String password) {
    double strength = 0;
    if (password.length >= 8) strength += 0.3;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.3;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.3;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.1;

    Color color = Colors.red;
    String text = "ضعيفة";
    if (strength > 0.7) {
      color = Colors.green;
      text = "قوية";
    } else if (strength > 0.4) {
      color = Colors.orange;
      text = "متوسطة";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: strength,
                backgroundColor: Colors.grey.shade300,
                color: color,
                borderRadius: BorderRadius.circular(10.r),
                minHeight: 6.h,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، حرف كبير، رقم ورموز",
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox(bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _termsAccepted = !_termsAccepted;
            });
          },
          child: Container(
            width: 20.w,
            height: 20.w,
            margin: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: _termsAccepted ? Color(0xFF9169DA) : Colors.grey.shade400,
                width: 1.5,
              ),
              color: _termsAccepted ? Color(0xFF9169DA) : Colors.transparent,
            ),
            child: _termsAccepted
                ? Icon(
              Icons.check_rounded,
              size: 16.w,
              color: Colors.white,
            )
                : null,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "أوافق على",
                style: TextStyle(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.6)
                      : Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Wrap(
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Open terms and conditions
                    },
                    child: Text(
                      "الشروط والأحكام",
                      style: TextStyle(
                        color: Color(0xFFAC7FFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    " و ",
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white,
                      fontSize: 14.sp,

                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Open privacy policy
                    },
                    child: Text(
                      "سياسة الخصوصية",
                      style: TextStyle(
                        color: Color(0xFFAC7FFF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink(bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "لديك حساب بالفعل؟ ",
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(0.6)
                : Colors.white,
            fontSize: 14.sp,
          ),
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: Color(0xFFAC7FFF),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
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

  Widget _buildSocialSignUp() {
    return Column(
      children: [
        Text(
          "التسجيل عبر",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
                icon: Icons.g_mobiledata_rounded,
                color: Colors.red,
                label: "Google",
                provider: "google", onTap: (String provider) {
              Get.snackbar(
                "قريباً",
                "التسجيل عبر $provider سيكون متاحاً قريباً",
                backgroundColor: Color(0xFF9169DA),
                colorText: Colors.white,
              );}
            ),
            SizedBox(width: 20.w),
            _buildSocialButton(
                icon: Icons.facebook_rounded,
                color: Colors.blue,
                label: "Facebook",
                provider: "facebook", onTap: (String provider) {
              Get.snackbar(
                "قريباً",
                "التسجيل عبر $provider سيكون متاحاً قريباً",
                backgroundColor: Color(0xFF9169DA),
                colorText: Colors.white,
              );} // أضف بارامتر provider
            ),
            SizedBox(width: 20.w),
            _buildSocialButton(
                icon: Icons.apple_rounded,
                color: Colors.black,
                label: "Apple",
                provider: "apple", onTap: (String provider) {
              Get.snackbar(
                "قريباً",
                "التسجيل عبر $provider سيكون متاحاً قريباً",
                backgroundColor: Color(0xFF9169DA),
                colorText: Colors.white,
              );} // أضف بارامتر provider
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required String label,
    required Function(String) onTap, required String provider,
  }) {
    return GestureDetector(
      onTap: () => onTap(label.toLowerCase()),
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
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
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSocialSignUp(String provider) {
    Get.snackbar(
      "قريباً",
      "التسجيل عبر $provider سيكون متاحاً قريباً",
      backgroundColor: Color(0xFF9169DA),
      colorText: Colors.white,
    );
  }
}

extension on signUpController {
  get isLoading => null;
}

