// favorite_model.dart

class favoriteModel {
  bool? success;
  String? message;
  String? status;
  int? totalCount;
  String? customersId;
  List<FavoriteShop>? data;  // استخدم data كما في API

  favoriteModel({
    this.success,
    this.message,
    this.status,
    this.totalCount,
    this.customersId,
    this.data,
  });

  factory favoriteModel.fromJson(Map<String, dynamic> json) {
    return favoriteModel(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      totalCount: json['total_count'],
      customersId: json['customers_id'],
      data: json['data'] != null
          ? List<FavoriteShop>.from(
          json['data'].map((x) => FavoriteShop.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
      'total_count': totalCount,
      'customers_id': customersId,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class FavoriteShop {
  String? favoriteId;
  String? shopId;
  String? customersId;
  String? favoriteDate;
  String? shopName;
  String? shopImage;
  String? shopDescription;
  String? shopAddress;
  String? shopPhone;
  String? shopEmail;
  int? price;
  int? viewer;
  String? cityName;
  String? sectionName;

  FavoriteShop({
    this.favoriteId,
    this.shopId,
    this.customersId,
    this.favoriteDate,
    this.shopName,
    this.shopImage,
    this.shopDescription,
    this.shopAddress,
    this.shopPhone,
    this.shopEmail,
    this.price,
    this.viewer,
    this.cityName,
    this.sectionName,
  });

  factory FavoriteShop.fromJson(Map<String, dynamic> json) {
    return FavoriteShop(
      favoriteId: json['favorite_id']?.toString(),
      shopId: json['shop_id']?.toString(),
      customersId: json['customers_id']?.toString(),
      favoriteDate: json['favorite_date'],
      shopName: json['shop_name'],
      shopImage: json['shop_image'],
      shopDescription: json['shop_description'],
      shopAddress: json['shop_address'],
      shopPhone: json['shop_phone']?.toString(),
      shopEmail: json['shop_email'],
      price: json['price'],
      viewer: json['viewer'],
      cityName: json['city_name'],
      sectionName: json['section_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorite_id': favoriteId,
      'shop_id': shopId,
      'customers_id': customersId,
      'favorite_date': favoriteDate,
      'shop_name': shopName,
      'shop_image': shopImage,
      'shop_description': shopDescription,
      'shop_address': shopAddress,
      'shop_phone': shopPhone,
      'shop_email': shopEmail,
      'price': price,
      'viewer': viewer,
      'city_name': cityName,
      'section_name': sectionName,
    };
  }
}