/*
class LoginModel {
  String? id;
  String? name;
  String? imge;
  String? phone;
  String? date_register;
  String? email;

  bool? success;
  String? message;



  LoginModel(
      {this.id,
        this.name,
        this.imge,
        this.phone,
        this.date_register,
        this.email,
        this.success,
        this.message,});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imge = json['imge'];
    phone = json['phone'];
    date_register = json['date_register'];
    email = json['email'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imge'] = this.imge;
    data['phone'] = this.phone;
    data['date_register'] = this.date_register;
    data['email'] = this.email;
    data['success'] = this.success;
    data['message'] = this.message;

    return data;
  }
}
*/


class LoginModel {
  String? id;
  String? name;
  String? imge;
  String? phone;
  String? date_register;
  String? email;
  bool? success;
  String? message;

  LoginModel({
    this.id,
    this.name,
    this.imge,
    this.phone,
    this.date_register,
    this.email,
    this.success,
    this.message,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    // Convert all values to string using toString() to handle both int and string responses
    id = json['id']?.toString();
    name = json['name']?.toString();
    imge = json['imge']?.toString();
    phone = json['phone']?.toString();
    date_register = json['date_register']?.toString();
    email = json['email']?.toString();

    // Handle success field - it could be bool, int (0/1), or string
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
    data['id'] = id;
    data['name'] = name;
    data['imge'] = imge;
    data['phone'] = phone;
    data['date_register'] = date_register;
    data['email'] = email;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
