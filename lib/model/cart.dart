import 'package:amazon_clone/model/product.dart';

class CartUser {
  List<Cart>? cart;
  String? total;

  CartUser({this.cart, this.total});

  CartUser.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Cart {
  Product? product;
  int? quantity;
  double? subtotal;

  Cart({this.product, this.quantity, this.subtotal});

  Cart.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    subtotal = json['subtotal']?.toDouble();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (product != null) {
  //     data['product'] = product!.toJson();
  //   }
  //   data['quantity'] = quantity;
  //   data['subtotal'] = subtotal;
  //   return data;
  // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = {
        '_id': product!.id,
      };
    }
    data['quantity'] = quantity;
    data['subtotal'] = subtotal;
    return data;
  }
}
