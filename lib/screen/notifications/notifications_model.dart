class NotificationsModel {
  List<Notifications>? notifications;
  bool? success;
  String? message;

  NotificationsModel({this.notifications, this.success, this.message});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications_level'] = this.notifications!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Notifications {
  String? id;
  String? note;
  String? date_create;
  String? time_create;

  Notifications({this.id, this.note, this.date_create, this.time_create});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();;
    note = json['note'];
    date_create = json['date_create'];
    time_create = json['time_create'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['date_create'] = this.date_create;
    data['time_create'] = this.time_create;
    return data;
  }
}
