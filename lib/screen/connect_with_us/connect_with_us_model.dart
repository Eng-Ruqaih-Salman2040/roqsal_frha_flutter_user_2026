class Connect_with_usModel {
  bool? success;
  String? message;

  Connect_with_usModel(
      {
        this.success,
        this.message,
       });

  Connect_with_usModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['success'] = this.success;
    data['message'] = this.message;

    return data;
  }
}
