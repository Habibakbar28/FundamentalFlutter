import 'dart:convert';

RestaurantReview restaurantReviewFromJson(String str) => RestaurantReview.fromJson(json.decode(str));

String restaurantReviewToJson(RestaurantReview data) => json.encode(data.toJson());

class RestaurantReview {
  RestaurantReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<ReviewCostumer> customerReviews;

  factory RestaurantReview.fromJson(Map<String, dynamic> json) => RestaurantReview(
    error: json["error"],
    message: json["message"],
    customerReviews: List<ReviewCostumer>.from(json["customerReviews"].map((x) => ReviewCostumer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}

class ReviewCostumer {
  ReviewCostumer({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory ReviewCostumer.fromJson(Map<String, dynamic> json) => ReviewCostumer(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
