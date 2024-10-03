import 'dart:convert';

import 'package:amazon_clone/model/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final double totalPrice;
  final int orderAt;
  final int status;

  Order(
      {required this.id,
      required this.products,
      required this.quantity,
      required this.address,
      required this.userId,
      required this.totalPrice,
      required this.orderAt,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'totalPrice': totalPrice,
      'userId': userId,
      'status': status
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      products: List<Product>.from(
          json['products']?.map((x) => Product.fromJson(x['product'])) ?? []),
      quantity: List<int>.from(json['quantity'] ?? []),
      address: json['address'] ?? '',
      userId: json['userId'] ?? '',
      // Ensure totalPrice is treated as a double
      totalPrice: (json['totalPrice'] is int)
          ? (json['totalPrice'] as int).toDouble()
          : (json['totalPrice'] as double),
      orderAt: json['orderAt'] ?? 0,
      status: json['status'] ?? 0,
    );
  }
  String toJson() => json.encode(toMap());

}
