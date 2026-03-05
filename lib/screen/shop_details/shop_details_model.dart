class shopDetailsModel {
  List<Gallery>? gallery;
  bool? success;
  String? message;
  bool? favorite;

  shopDetailsModel({this.gallery, this.success, this.message, this.favorite});

  shopDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    data['favorite'] = this.favorite;
    return data;
  }
}

class Gallery {
  int? id;
  String? imge;

  Gallery({this.id, this.imge});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imge = json['imge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['imge'] = this.imge.toString();
    return data;
  }
}
