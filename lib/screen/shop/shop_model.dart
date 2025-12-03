class shopModel {
  List<Shop>? shop;
  bool? success;
  String? message;

  shopModel({this.shop, this.success, this.message});

  shopModel.fromJson(Map<String, dynamic> json) {
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Shop {
  String? id;
  String? userName;
  String? passowrd;
  String? nameShop;
  String? cityName;
  String? sectionName;
  String? adress;
  String? email;
  String? phone;
  String? image;
  String? description;
  String? price;
  String? viewer;

  Shop(
      {this.id,
        this.userName,
        this.passowrd,
        this.nameShop,
        this.cityName,
        this.sectionName,
        this.adress,
        this.email,
        this.phone,
        this.image,
        this.description,
        this.price,
        this.viewer});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      // تأكد أن جميع الخصائص النصية تأخذ قيم نصية
      id: json['id']?.toString() ?? '', // التحويل إلى نص
      price: json['price']?.toString() ?? '', // التحويل إلى نص
      viewer: json['viewer']?.toString() ?? '', // التحويل إلى نص
      phone: json['phone']?.toString() ?? '', // التحويل إلى نص
      email: json['email']?.toString() ?? '', // التحويل إلى نص
      cityName: json['cityName']?.toString() ?? '',
      adress: json['adress']?.toString() ?? '',
      sectionName: json['sectionName']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      // ... باقي الخصائص
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['passowrd'] = this.passowrd;
    data['name_shop'] = this.nameShop;
    data['city_name'] = this.cityName;
    data['section_name'] = this.sectionName;
    data['adress'] = this.adress;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['viewer'] = this.viewer;
    return data;
  }



}
