import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants.dart';
import '../../screen/reservations/reservations_controller.dart';
import '../../screen/section/section_controller.dart';
import '../../screen/sliderAds/ads.dart';
import '../../screen/sliderAds/ads_controller.dart';
import '../widget/customButton.dart';
import '../widget/menu_widget2.dart';
import '../widget/my_text.dart';
import '../widget/scrolling_photo.dart';
import 'allShop/allShop.dart';
import 'allShop/allShop_controller.dart';
import 'login/login_model.dart';
import 'notifications/notifications.dart';
import 'notifications/notifications_contraller.dart';
import 'section/section.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  int _currentCarouselIndex = 0;
  late final CarouselController _carouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentIndex = 0;

    // Initialize controllers
    Get.put(sectionController());
    Get.put(adsController());
    Get.put(allShopController());
    Get.put(NotificationsController());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _showSearchBar ? 60.h : 0,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: _showSearchBar
          ? Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج، متجر، أو خدمة...',
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(Iconsax.search_normal, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(Iconsax.filter, size: 20),
                  onPressed: () {
                    // Filter action
                  },
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              style: TextStyle(fontSize: 14.sp),
              onSubmitted: (value) {
                // Handle search
              },
            ),
          ),
          SizedBox(width: 12.w),
          IconButton(
            icon: Icon(Iconsax.close_circle, size: 24),
            onPressed: () {
              setState(() {
                _showSearchBar = false;
                _searchController.clear();
              });
            },
          ),
        ],
      )
          : SizedBox.shrink(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً بك 👋',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'ماذا تبحث عنه اليوم؟',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  _showSearchBar ? Iconsax.search_normal_1 : Iconsax.search_normal,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _showSearchBar = !_showSearchBar;
                  });
                },
              ),
              SizedBox(width: 8.w),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Iconsax.notification,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    onPressed: () {
                      Get.put(NotificationsController()).getNotificationsApi();
                      Get.to(() => NotificationsScreen());
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Iconsax.shop, 'label': 'المتاجر', 'color': Color(0xFF6C63FF)},
      {'icon': Iconsax.ticket, 'label': 'العروض', 'color': Color(0xFFFF6584)},
      {'icon': Iconsax.cake, 'label': 'الحلويات', 'color': Color(0xFF36B37E)},
      {'icon': Iconsax.coffee, 'label': 'المقاهي', 'color': Color(0xFFFFB74D)},
      {'icon': Iconsax.gift, 'label': 'الهدايا', 'color': Color(0xFF9575CD)},
      {'icon': Iconsax.more, 'label': 'المزيد', 'color': Color(0xFF78909C)},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التصنيفات السريعة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all categories
                },
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to category
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: categories[index]['color'].withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          categories[index]['icon'],
                          color: categories[index]['color'],
                          size: 20.w,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        categories[index]['label'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'العروض المميزة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.flash, size: 16, color: Theme.of(context).primaryColor),
                    SizedBox(width: 4.w),
                    Text(
                      'محدودة الوقت',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 280.w,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 16.w,
                        top: 16.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'خصم يصل إلى',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            Text(
                              '٥٠٪',
                              style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'على جميع المنتجات',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 16.w,
                        bottom: 16.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'شاهد العروض',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Iconsax.arrow_left_2,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdsCarousel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          CarouselSlider.builder(

            options: CarouselOptions(
              height: 180.h,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enableInfiniteScroll: true,
              viewportFraction: 0.85,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCarouselIndex = index;
                });
              },
            ),
            itemCount: 5,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    'assets/images/ad_${index + 1}.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Center(
                          child: Icon(
                            Iconsax.image,
                            size: 50,
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
                  (index) => Container(
                width: 8.w,
                height: 8.w,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentCarouselIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularStores() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المتاجر الشائعة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => allShopScreen());
                },
                child: Row(
                  children: [
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Iconsax.arrow_left_2,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  width: 120.w,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 80.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                          image: DecorationImage(
                            image: AssetImage('assets/images/store_${index + 1}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Iconsax.heart,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'اسم المتجر',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.star1,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '١٠٠+',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildTodayOffers() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'عروض اليوم',
  //               style: TextStyle(
  //                 fontSize: 18.sp,
  //                 fontWeight: FontWeight.bold,
  //                 color: Theme.of(context).primaryColor,
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(
  //                   colors: [
  //                     Color(0xFFFF6584),
  //                     Color(0xFFFFB74D),
  //                   ],
  //                 ),
  //                 borderRadius: BorderRadius.circular(20.r),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Icon(Iconsax.clock, size: 14, color: Colors.white),
  //                   SizedBox(width: 4.w),
  //                   Text(
  //                     'ينتهي قريباً',
  //                     style: TextStyle(
  //                       fontSize: 12.sp,
  //                       fontWeight: FontWeight.w500,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16.h),
  //         GridView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 12.w,
  //             mainAxisSpacing: 12.h,
  //             childAspectRatio: 0.75,
  //           ),
  //           itemCount: 6,
  //           itemBuilder: (context, index) {
  //             return Container(
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context).cardColor,
  //                 borderRadius: BorderRadius.circular(16.r),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.black.withOpacity(0.05),
  //                     blurRadius: 8,
  //                     offset: Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     height: 120.h,
  //                     width: double.infinity,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.vertical(
  //                         top: Radius.circular(16.r),
  //                       ),
  //                       image: DecorationImage(
  //                         image: AssetImage('assets/images/offer_${index + 1}.jpg'),
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                     child: Stack(
  //                       children: [
  //                         Positioned(
  //                           top: 8.h,
  //                           left: 8.w,
  //                           child: Container(
  //                             padding: EdgeInsets.symmetric(
  //                               horizontal: 8.w,
  //                               vertical: 4.h,
  //                             ),
  //                             decoration: BoxDecoration(
  //                               color: Colors.red,
  //                               borderRadius: BorderRadius.circular(10.r),
  //                             ),
  //                             child: Text(
  //                               '-30%',
  //                               style: TextStyle(
  //                                 fontSize: 12.sp,
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.all(12.w),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           'اسم المنتج المميز هنا',
  //                           style: TextStyle(
  //                             fontSize: 14.sp,
  //                             fontWeight: FontWeight.bold,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           maxLines: 2,
  //                         ),
  //                         SizedBox(height: 8.h),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               '٥٠ ر.س',
  //                               style: TextStyle(
  //                                 fontSize: 16.sp,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Theme.of(context).primaryColor,
  //                               ),
  //                             ),
  //                             SizedBox(width: 8.w),
  //                             Text(
  //                               '٧٠ ر.س',
  //                               style: TextStyle(
  //                                 fontSize: 12.sp,
  //                                 color: Colors.grey,
  //                                 decoration: TextDecoration.lineThrough,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 8.h),
  //                         Row(
  //                           children: [
  //                             Icon(Iconsax.shop, size: 14, color: Colors.grey),
  //                             SizedBox(width: 4.w),
  //                             Expanded(
  //                               child: Text(
  //                                 'اسم المتجر',
  //                                 style: TextStyle(
  //                                   fontSize: 12.sp,
  //                                   color: Colors.grey[600],
  //                                   overflow: TextOverflow.ellipsis,
  //                                 ),
  //                                 maxLines: 1,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSections() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الأقسام',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                icon: Icon(Iconsax.category, size: 24),
                onPressed: () {
                  // Navigate to all sections
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
          sectionScreen(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text( 'الصفحة الرئيسية',style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kColorsWhite),),centerTitle: true,elevation: 0,

          // backgroundColor: Colors.pink[600],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined,color: Colors.white,),
              onPressed: () {
                Get.put(NotificationsController()).getNotificationsApi();
                Get.to(NotificationsScreen());
              },
            ),
          ]
      ),
      drawer: drawerWidget(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh data
            await Future.delayed(Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // _buildHeader(),
                // _buildSearchBar(),
                _buildAdsCarousel(),
                _buildCategories(),
                _buildFeaturedSection(),
                _buildPopularStores(),
                // _buildTodayOffers(),
                _buildSections(),
                SizedBox(height: 100.h), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Iconsax.arrow_up_2, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}