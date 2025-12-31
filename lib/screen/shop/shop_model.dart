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

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    passowrd = json['passowrd'];
    nameShop = json['name_shop'];
    cityName = json['city_name'];
    sectionName = json['section_name'];
    adress = json['adress'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    viewer = json['viewer'];
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
