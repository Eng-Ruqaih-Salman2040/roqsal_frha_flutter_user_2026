import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Constants.dart';
import '../../apiservice/url.dart';
import '../../widget/customButton.dart';
import '../../widget/dailog_widget.dart';
import '../../widget/my_data.dart';
import '../../widget/my_text.dart';
import '../login/login.dart';
import '../login/login_model.dart';
import '../payment_method/payment_method.dart';
import '../payment_method/payment_method_controller.dart';
import '../shop/shop_model.dart';
import 'rating_controller.dart';
import 'rating_model.dart';

class SliderImageHeaderRoute extends StatefulWidget {
  var data, data_image;

  SliderImageHeaderRoute(this.data, this.data_image);

  @override
  SliderImageHeaderRouteState createState() => SliderImageHeaderRouteState(this.data, this.data_image);
}

class SliderImageHeaderRouteState extends State<SliderImageHeaderRoute> {
  var data, data_image;
  int currentIndex = 0;
  bool isFavorite = false;
  bool isExpanded = false;

  // ✅ تعريف المتغيرات المطلوبة
  double rating = 0.0;
  int reviewCount = 0;
  RatingSummary summary = RatingSummary(
    averageRating: 0.0,
    totalReviews: 0,
    fiveStar: 0,
    fourStar: 0,
    threeStar: 0,
    twoStar: 0,
    oneStar: 0,
  );

  GoogleMapController? mapController;
  final LatLng _center = const LatLng(15.3694, 44.1910);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<RatingController>()) {
      Get.put(RatingController());}

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRatings();
    });
  }

  SliderImageHeaderRouteState(this.data, this.data_image) {
    // إضافة marker للموقع
    _markers.add(
      Marker(
        markerId: MarkerId(getShopId()),
        position: _center,
        infoWindow: InfoWindow(
          title: getShopName(),
          snippet: getShopAddress(),
        ),
      ),
    );
  }

  // ========== دوال مساعدة للوصول الآمن للبيانات ==========

  String? _getStringValue(String key) {
    if (data == null) return null;

    // إذا كان data من نوع Shop
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
        default: return null;
      }
    }

    // إذا كان data من نوع Map
    if (data is Map) {
      final value = (data as Map)[key];
      return value?.toString();
    }

    return null;
  }

  String getShopId() {
    return _getStringValue('id') ??
        _getStringValue('shop_id') ??
        '';
  }

  String getShopName() {
    return _getStringValue('nameShop') ??
        _getStringValue('shop_name') ??
        '';
  }

  String getShopImage() {
    return _getStringValue('image') ??
        _getStringValue('shop_image') ??
        'default_image.png';
  }

  String getShopAddress() {
    return _getStringValue('adress') ??
        _getStringValue('shop_address') ??
        '';
  }

  String getShopPhone() {
    return _getStringValue('phone') ??
        _getStringValue('shop_phone') ??
        '';
  }

  String getShopEmail() {
    return _getStringValue('email') ??
        _getStringValue('shop_email') ??
        '';
  }

  String getShopPrice() {
    return _getStringValue('price') ?? '0';
  }

  String getShopViewer() {
    return _getStringValue('viewer') ?? '0';
  }

  String getShopDescription() {
    return _getStringValue('description') ??
        _getStringValue('shop_description') ??
        '';
  }

  String getCityName() {
    return _getStringValue('cityName') ??
        _getStringValue('city_name') ??
        '';
  }

  String getSectionName() {
    return _getStringValue('sectionName') ??
        _getStringValue('section_name') ??
        '';
  }

  // ====================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = Color(0xFF6A4DFF);

    // جمع كل الصور
    List<String> images = [
      Url_shop + getShopImage(),
      ...data_image?.map((item) => Url_gallery + item.imge.toString()) ?? []
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // المحتوى الرئيسي
          CustomScrollView(
            slivers: [
              // مخصص مع الصور
              SliverAppBar(
                expandedHeight: 350.h,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Carousel الصور
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 350.h,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: images.length > 1,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                        items: images.map((imageUrl) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.zero,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                              : null,
                                          color: primaryColor,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Icon(
                                          Icons.broken_image_rounded,
                                          size: 50,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),

                      // مؤشر الصفحات
                      Positioned(
                        bottom: 20.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: images.asMap().entries.map((entry) {
                            return Container(
                              width: currentIndex == entry.key ? 20.w : 8.w,
                              height: 8.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: currentIndex == entry.key
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // محتوى الصفحة
              SliverPadding(
                padding: EdgeInsets.all(16.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // رقم المنتج والقسم
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '#${getShopId()}',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[100]!,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            getSectionName(),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // اسم المنتج والسعر
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            getShopName(),
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'السعر',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${getShopPrice()}  ريال',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF16AE94),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // معلومات الموقع
                    Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                  size: 20.w, color: primaryColor),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  '${getCityName()} - ${getShopAddress()}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Icon(Icons.remove_red_eye_outlined,
                                  size: 20.w, color: Colors.grey[600]),
                              SizedBox(width: 8.w),
                              Text(
                                'عدد المشاهدات',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  getShopViewer(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // عنوان القسم
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'التقييمات',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () => _showRatingDialog(context),
                                    icon: Icon(Icons.add_comment_rounded, size: 18.w),
                                    label: Text('أضف تقييمك'),
                                    style: TextButton.styleFrom(
                                      foregroundColor: primaryColor,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 12.h),

                              // قائمة التقييمات
                              _buildRatingsList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // معلومات التواصل
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'معلومات التواصل',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[900],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.phone_rounded,
                                  color: Colors.green,
                                  size: 20.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'الهاتف',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      getShopPhone(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.email_rounded,
                                  color: Colors.blue,
                                  size: 20.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'البريد الإلكتروني',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      getShopEmail(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // قسم الخريطة
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.map_rounded, color: primaryColor, size: 20.w),
                              SizedBox(width: 8.w),
                              Text(
                                'الموقع على الخريطة',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: GoogleMap(
                                mapType: MapType.normal,
                                onMapCreated: (GoogleMapController controller) {
                                  mapController = controller;
                                },
                                initialCameraPosition: CameraPosition(
                                  target: _center,
                                  zoom: 10.0,
                                ),
                                markers: _markers,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: true,
                                mapToolbarEnabled: false,
                                compassEnabled: false,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          TextButton.icon(
                            onPressed: () {
                              _openInMaps();
                            },
                            icon: Icon(Icons.open_in_new_rounded, size: 16.w),
                            label: Text('فتح في خرائط Google'),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // الوصف
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الوصف',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[900],
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                icon: Icon(
                                  isExpanded ? Icons.expand_less : Icons.expand_more,
                                  size: 18.sp,
                                ),
                                label: Text(
                                  isExpanded ? 'عرض أقل' : 'عرض المزيد',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            getShopDescription(),
                            maxLines: isExpanded ? null : 3,
                            overflow: isExpanded ? null : TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 80.h), // مسافة للزر الثابت
                  ]),
                ),
              ),
            ],
          ),

          // زر الحجز الثابت في الأسفل
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16.r,
                    offset: Offset(0, -4.h),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if(MyData.auth_user){
                        Get.put(paymentMethodController()).getPaymentMethodApi(getShopId());
                        Get.to(() => paymentMethodScreen(this.data));
                      }else{
                        GetSnackMsg(msg: "يجب تسجيل الدخول للمكن من الحجز",bgClr:kColorRed ,txClr:kColorsWhite ).showTxt();
                        Get.back();
                      }},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_rounded, size: 20.w),
                        SizedBox(width: 8.w),
                        Text(
                          'حجز الآن',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


// ✅ دالة جلب التقييمات
  void _loadRatings() {
    try {
      final ratingController = Get.find<RatingController>();

      ratingController.refreshRatings(getShopId()).then((_) {
        if (mounted) {
          setState(() {
            summary = ratingController.summary.value;
            rating = summary.averageRating ?? 0.0;
            reviewCount = summary.totalReviews ?? 0;
          });
        }
      }).catchError((error) {
        print('❌ Error loading ratings: $error');
      });
    } catch (e) {
      print('❌ Error in _loadRatings: $e');
    }
  }

// ✅ دالة عرض نافذة إضافة تقييم
  void _showRatingDialog(BuildContext context) {
    double tempRating = 3.0;
    TextEditingController reviewController = TextEditingController();
    final ratingController = Get.find<RatingController>(); // ✅ استخدام find

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'تقييم المتجر',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // التقييم بالنجوم
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: [
                    Text(
                      'كم تقيم هذه الخدمة؟',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8.h),
                    RatingBar.builder(
                      initialRating: tempRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 36.w,
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        tempRating = rating;
                      },
                    ),
                  ],
                ),
              ),

              // حقل التعليق
              TextField(
                controller: reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'اكتب تعليقك هنا...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Obx(() => ElevatedButton(
              onPressed: ratingController.isSubmitting.value
                  ? null
                  : () async {
                if (MyData.auth_user) {
                  final loginModle = LoginModel.fromJson(
                      GetStorage().read('store')
                  );

                  bool success = await ratingController.addRating(
                    shopId: getShopId(),
                    customerId: loginModle.id.toString(),
                    ratingValue: tempRating,
                    reviewComment: reviewController.text,
                  );

                  if (success) {
                    Navigator.pop(context);
                    // تحديث القيم بعد إضافة التقييم
                    await ratingController.refreshRatings(getShopId());
                    if (mounted) {
                      setState(() {
                        summary = ratingController.summary.value;
                        rating = summary.averageRating ?? rating;
                        reviewCount = summary.totalReviews ?? reviewCount;
                      });
                    }

                    GetSnackMsg(
                      msg: "تم إضافة التقييم بنجاح",
                      bgClr: kColorsPrimary,
                      txClr: kColorsWhite,
                    ).showTxt();
                  }
                } else {
                  Navigator.pop(context);
                  GetSnackMsg(
                    msg: "يجب تسجيل الدخول لإضافة تقييم",
                    bgClr: kColorRed,
                    txClr: kColorsWhite,
                  ).showTxt();

                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xF59197CF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: ratingController.isSubmitting.value
                  ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : Text('إرسال',style: TextStyle(color: Color(0xF50B0B10),),),
            )),
          ],
        );
      },
    );
  }

  // ✅ دالة لعرض التقييمات في قائمة
  Widget _buildRatingsList() {
    // ✅ استخدام find بدلاً من put
    final ratingController = Get.find<RatingController>();

    return Obx(() {
      if (ratingController.isLoading.value && ratingController.ratings.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: CircularProgressIndicator(color: kColorsPrimary),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ملخص التقييمات
          _buildRatingSummary(),

          SizedBox(height: 16.h),

          // قائمة التقييمات
          if (ratingController.ratings.isEmpty)
            Container(
              padding: EdgeInsets.all(20.h),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.rate_review_outlined, size: 50.w, color: Colors.grey[400]),
                    SizedBox(height: 8.h),
                    Text(
                      'لا توجد تقييمات بعد',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton.icon(
                      onPressed: () => _showRatingDialog(context),
                      icon: Icon(Icons.add_comment_rounded, size: 16.w),
                      label: Text('كن أول من يقيم'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kColorsPrimary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ratingController.ratings.length,
              itemBuilder: (context, index) {
                final review = ratingController.ratings[index];
                return _buildReviewItem(review);
              },
            ),

          // زر تحميل المزيد
          if (ratingController.hasMorePages.value && ratingController.ratings.isNotEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TextButton(
                  onPressed: () {
                    ratingController.loadMoreRatings(getShopId());
                  },
                  child: Text(
                    'تحميل المزيد',
                    style: TextStyle(color: kColorsPrimary),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }

// ✅ دالة لعرض ملخص التقييمات
  Widget _buildRatingSummary() {
    final ratingController = Get.find<RatingController>();
    final summaryData = ratingController.summary.value;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // متوسط التقييم
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: kColorsPrimary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      summaryData.averageRating?.toStringAsFixed(1) ?? '0.0',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: kColorsPrimary,
                      ),
                    ),
                    Text(
                      '/ 5',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 16.w),

              // إحصائيات النجوم
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar('5', summaryData.fiveStar ?? 0, summaryData.totalReviews ?? 1),
                    _buildRatingBar('4', summaryData.fourStar ?? 0, summaryData.totalReviews ?? 1),
                    _buildRatingBar('3', summaryData.threeStar ?? 0, summaryData.totalReviews ?? 1),
                    _buildRatingBar('2', summaryData.twoStar ?? 0, summaryData.totalReviews ?? 1),
                    _buildRatingBar('1', summaryData.oneStar ?? 0, summaryData.totalReviews ?? 1),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // إجمالي التقييمات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي التقييمات',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: kColorsPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${summaryData.totalReviews ?? 0} تقييم',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: kColorsPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ دالة مساعدة لعرض شريط النسبة المئوية
  Widget _buildRatingBar(String star, int count, int total) {
    double percentage = total > 0 ? (count / total) : 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            star,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
          Icon(Icons.star, size: 14.w, color: Colors.amber),
          SizedBox(width: 8.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 6.h,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  // ✅ دالة لعرض عنصر تقييم واحد
  Widget _buildReviewItem(Review review) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // صورة المستخدم
              CircleAvatar(
                radius: 20.r,
                backgroundImage: review.customerImage != null
                    ? NetworkImage(review.customerImage!)
                    : null,
                child: review.customerImage == null
                    ? Icon(Icons.person, size: 20.w)
                    : null,
              ),
              SizedBox(width: 12.w),

              // معلومات المستخدم
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.customerName ?? 'مستخدم',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        // عرض النجوم
                        ...List.generate(5, (index) {
                          return Icon(
                            index < (review.ratingValue ?? 0)
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            color: Colors.amber,
                            size: 16.w,
                          );
                        }),
                        SizedBox(width: 8.w),
                        Text(
                          _getTimeAgo(review.createdAt),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (review.reviewComment != null && review.reviewComment!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              review.reviewComment!,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[800]),
            ),
          ],

          // عرض الصور المرفقة إن وجدت
          if (review.images != null && review.images!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            SizedBox(
              height: 60.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: review.images!.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60.w,
                    height: 60.h,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(review.images![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ✅ دالة مساعدة لعرض الوقت المنقضي
  String _getTimeAgo(String? dateString) {
    if (dateString == null) return '';

    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 365) {
        return 'منذ ${(difference.inDays / 365).floor()} سنة';
      } else if (difference.inDays > 30) {
        return 'منذ ${(difference.inDays / 30).floor()} شهر';
      } else if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} يوم';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ساعة';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return '';
    }
  }

  // ✅ دالة فتح الخريطة في تطبيق خارجي
  void _openInMaps() {
    // يمكنك استخدام url_launcher لفتح الخريطة
    // مثال: https://www.google.com/maps/search/?api=1&query=15.3694,44.1910
  }
}