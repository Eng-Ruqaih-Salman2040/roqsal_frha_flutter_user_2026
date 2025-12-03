class reservationsModel {
  List<Reservations>? reservations;
  bool? success;
  String? message;

  reservationsModel({this.reservations, this.success, this.message});

  reservationsModel.fromJson(Map<String, dynamic> json) {
    if (json['reservations'] != null) {
      reservations = <Reservations>[];
      json['reservations'].forEach((v) {
        reservations!.add(new Reservations.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Reservations {
  String? id;
  String? bookingDate;
  String? reservationStatus;
  String? note;
  String? bondNo;
  String? name;
  String? email;
  String? phone;
  String? accountName;
  String? image;
  String? section_name;
  String? price;

  Reservations(
      {this.id,
        this.bookingDate,
        this.reservationStatus,
        this.note,
        this.bondNo,
        this.name,
        this.email,
        this.phone,
        this.accountName,this.image,this.section_name,this.price});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDate = json['booking_date'];
    reservationStatus = json['reservation_status'];
    note = json['note'];
    bondNo = json['bond_no'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    accountName = json['account_name'];
    image = json['image'];
    section_name = json['section_name'];
    price = json['price'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_date'] = this.bookingDate;
    data['reservation_status'] = this.reservationStatus;
    data['note'] = this.note;
    data['bond_no'] = this.bondNo;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['account_name'] = this.accountName;
    data['image'] = this.image;
    data['section_name'] = this.section_name;
    data['price'] = this.price;

    return data;
  }
}
