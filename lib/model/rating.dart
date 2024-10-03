class Ratings {
  String? userId;
  int? rating;

  Ratings({this.userId, this.rating});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      userId: json['userId'] ?? '',
      rating: json['rating'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['rating'] = rating;
    return data;
  }
}
