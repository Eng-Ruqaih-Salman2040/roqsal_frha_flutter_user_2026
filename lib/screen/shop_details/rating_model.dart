class RatingModel {
  List<Review>? reviews;
  bool? success;
  String? message;
  RatingSummary? summary;
  PaginationInfo? pagination; // إضافة معلومات التصفح

  RatingModel({this.reviews, this.success, this.message, this.summary, this.pagination});

  RatingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }

    summary = json['summary'] != null ? RatingSummary.fromJson(json['summary']) : null;
    pagination = json['pagination'] != null ? PaginationInfo.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;

    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

// إضافة كلاس جديد لمعلومات التصفح
class PaginationInfo {
  int? currentPage;
  int? totalPages;
  int? totalItems;
  int? perPage;

  PaginationInfo({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.perPage,
  });

  PaginationInfo.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 1;
    totalPages = json['total_pages'] ?? 1;
    totalItems = json['total_items'] ?? 0;
    perPage = json['per_page'] ?? 10;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['total_items'] = totalItems;
    data['per_page'] = perPage;
    return data;
  }
}
class Review {
  int? id;
  int? customerId; // تغيير إلى int
  String? customerName;
  String? customerImage;
  double? ratingValue; // تغيير إلى double لأن rating_value decimal
  String? reviewComment;
  String? createdAt;
  String? shopId;
  String? shopName;
  String? shopImage;
  List<String>? images;

  Review({
    this.id,
    this.customerId,
    this.customerName,
    this.customerImage,
    this.ratingValue,
    this.reviewComment,
    this.createdAt,
    this.shopId,
    this.shopName,
    this.shopImage,
    this.images,
  });

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['id_rating'] ?? json['review_id'];
    customerId = json['customer_id'] != null ? int.tryParse(json['customer_id'].toString()) : null;
    customerName = json['customer_name'] ?? json['name'] ?? 'مستخدم';
    customerImage = json['customer_image'] ?? json['imge'] ?? '';
    ratingValue = json['rating_value'] != null
        ? double.tryParse(json['rating_value'].toString()) ?? 0.0
        : 0.0;
    reviewComment = json['review_comment'] ?? json['comment'] ?? '';
    createdAt = json['created_at'] ?? json['created_time'] ?? json['date'];
    shopId = json['shop_id']?.toString();
    shopName = json['shop_name'];
    shopImage = json['shop_image'];

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['customer_image'] = customerImage;
    data['rating_value'] = ratingValue;
    data['review_comment'] = reviewComment;
    data['created_at'] = createdAt;
    data['shop_id'] = shopId;
    data['shop_name'] = shopName;
    data['shop_image'] = shopImage;
    data['images'] = images;
    return data;
  }
}
class RatingSummary {
  double? averageRating;
  int? totalReviews;
  int? fiveStar;
  int? fourStar;
  int? threeStar;
  int? twoStar;
  int? oneStar;

  RatingSummary({
    this.averageRating,
    this.totalReviews,
    this.fiveStar,
    this.fourStar,
    this.threeStar,
    this.twoStar,
    this.oneStar,
  });

  RatingSummary.fromJson(Map<String, dynamic> json) {
    averageRating = json['average_rating']?.toDouble() ?? 0.0;
    totalReviews = json['total_reviews'] ?? 0;
    fiveStar = json['five_star'] ?? json['5_star'] ?? 0;
    fourStar = json['four_star'] ?? json['4_star'] ?? 0;
    threeStar = json['three_star'] ?? json['3_star'] ?? 0;
    twoStar = json['two_star'] ?? json['2_star'] ?? 0;
    oneStar = json['one_star'] ?? json['1_star'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['average_rating'] = averageRating;
    data['total_reviews'] = totalReviews;
    data['five_star'] = fiveStar;
    data['four_star'] = fourStar;
    data['three_star'] = threeStar;
    data['two_star'] = twoStar;
    data['one_star'] = oneStar;
    return data;
  }

  // دالة مساعدة لحساب النسب المئوية
  Map<int, double> getPercentages() {
    if (totalReviews == null || totalReviews == 0) {
      return {};
    }

    return {
      5: ((fiveStar ?? 0) / totalReviews! * 100),
      4: ((fourStar ?? 0) / totalReviews! * 100),
      3: ((threeStar ?? 0) / totalReviews! * 100),
      2: ((twoStar ?? 0) / totalReviews! * 100),
      1: ((oneStar ?? 0) / totalReviews! * 100),
    };
  }
}