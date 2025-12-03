class paymentMethodModel {
  List<PaymentMethod>? paymentMethod;
  bool? success;
  String? message;

  paymentMethodModel({this.paymentMethod, this.success, this.message});

  paymentMethodModel.fromJson(Map<String, dynamic> json) {
    if (json['PaymentMethod'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['PaymentMethod'].forEach((v) {
        paymentMethod!.add(new PaymentMethod.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethod != null) {
      data['PaymentMethod'] =
          this.paymentMethod!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class PaymentMethod {
  String? id;
  String? imge;
  String? accountName;
  String? accountNumber;

  PaymentMethod({this.id, this.imge, this.accountName, this.accountNumber});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imge = json['imge'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imge'] = this.imge;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    return data;
  }
}
