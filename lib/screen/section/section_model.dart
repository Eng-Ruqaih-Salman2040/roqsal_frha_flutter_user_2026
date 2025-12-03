/*
class sectionModel {
  List<Section>? section;
  bool? success;
  String? message;

  sectionModel({this.section, this.success, this.message});

  sectionModel.fromJson(Map<String, dynamic> json) {
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
  String? countShop;

  Section({this.id, this.name, this.image, this.countShop});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    image = json['image'];
    countShop = json['count_shop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['count_shop'] = this.countShop;
    return data;
  }
}
*/

class sectionModel {
  List<Section>? section;
  bool? success;
  String? message;

  sectionModel({this.section, this.success, this.message});

  sectionModel.fromJson(Map<String, dynamic> json) {
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
  String? countShop; // Keep as string for display purposes

  Section({this.id, this.name, this.image, this.countShop});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    image = json['image']?.toString();
    countShop = json['count_shop']?.toString(); // Convert to string
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['count_shop'] = countShop;
    return data;
  }
}
