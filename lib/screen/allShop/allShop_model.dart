/*
class allShopModel {
  List<Section>? section;
  bool? success;
  String? message;

  allShopModel({this.section, this.success, this.message});

  allShopModel.fromJson(Map<String, dynamic> json) {
    if (json['section'] != null) {
      section = <Section>[];
      json['section'].forEach((v) {
        section!.add(new Section.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.section != null) {
      data['section'] = this.section!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Section {
  String? id;
  String? name;
  String? image;
  List<Shop>? shop;

  Section({this.id, this.name, this.image, this.shop});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();;
    name = json['name'];
    image = json['image'];
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
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
    id = json['id']?.toString();;
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
*/

class allShopModel {
  List<Section>? section;
  bool? success;
  String? message;

  allShopModel({this.section, this.success, this.message});

  allShopModel.fromJson(Map<String, dynamic> json) {
    if (json['section'] != null) {
      section = <Section>[];
      json['section'].forEach((v) {
        section!.add(Section.fromJson(v));
      });
    }

    // Handle success field properly
    if (json['success'] is bool) {
      success = json['success'];
    } else if (json['success'] is int) {
      success = json['success'] == 1;
    } else if (json['success'] is String) {
      success = json['success'].toLowerCase() == 'true' || json['success'] == '1';
    } else {
      success = false;
    }

    message = json['message']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (section != null) {
      data['section'] = section!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Section {
  String? id;
  String? name;
  String? image;
  List<Shop>? shop;

  Section({this.id, this.name, this.image, this.shop});

  Section.fromJson(Map<String, dynamic> json) {
    // Convert all values to string to handle both int and string responses
    id = json['id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();

    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (shop != null) {
      data['shop'] = shop!.map((v) => v.toJson()).toList();
    }
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

  Shop({
    this.id,
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
    this.viewer,
  });

  Shop.fromJson(Map<String, dynamic> json) {
    // Convert all values to string to handle both int and string responses
    id = json['id']?.toString();
    userName = json['user_name']?.toString();
    passowrd = json['passowrd']?.toString();
    nameShop = json['name_shop']?.toString();
    cityName = json['city_name']?.toString();
    sectionName = json['section_name']?.toString();
    adress = json['adress']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    image = json['image']?.toString();
    description = json['description']?.toString();
    price = json['price']?.toString();
    viewer = json['viewer']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['passowrd'] = passowrd;
    data['name_shop'] = nameShop;
    data['city_name'] = cityName;
    data['section_name'] = sectionName;
    data['adress'] = adress;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['description'] = description;
    data['price'] = price;
    data['viewer'] = viewer;
    return data;
  }
}
