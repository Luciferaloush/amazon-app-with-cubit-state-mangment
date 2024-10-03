import 'dart:convert';

import 'package:amazon_clone/model/rating.dart';

class Product {
  final String name;
  final String description;
  final List<String> images;
  final double quality;
  final double price;
  final String category;
  final String? id;
  final List<Ratings>? rating;
  int quantity;

  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.quality,
    required this.price,
    required this.category,
    this.id,
    this.rating,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'decription': description,
      'image': images,
      'quantity': quality,
      'price': price,
      'category': category,
      'rating': rating,
      'quality': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      description: map['decription'] ?? '',
      images: (map['image'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      // images: List<String>.from(map['images']),
      quality: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      rating: map['ratings'] != null
          ? List<Ratings>.from(map['ratings']?.map((x) => Ratings.fromJson(x)))
          : null,
      quantity:
          (map['quantity'] as num).toInt(),
    );
  }

  String toJson() => json.encode(toMap());
}
