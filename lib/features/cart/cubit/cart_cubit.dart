import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../helper/cache_helper.dart';
import '../../../model/cart.dart';
import '../../../model/product.dart';
import '../../../utils/constants/global_variables.dart';
import '../../../utils/snackbar.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);
  late List<Product> listProducts = [];
  List<CartUser> cart =[];
 List<Cart> cartC = [];
  double total = 0.0;
  double totalU = 0.0;
  int cartLength = 0;
  int quantity = 0;
  final String apiUrl = '$uri/api/display-cart';

  Future<List<CartUser>>  fetchCart() async {
    try {
      final response = await http.get(Uri.parse(apiUrl),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheHelper.getData(key: "token"),
      });
print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        CartUser cartUser = CartUser.fromJson(jsonResponse);
        cart.add(cartUser);
        Cart CartCC = Cart.fromJson(jsonResponse);
        cartC.add(CartCC);
        print("CARTC ${cartC.length}");
        if (kDebugMode) {
          print("Cart::  ${response.body} ");
        }

        totalU = double.tryParse(cartUser.total ?? '0.0') ?? 0.0;
        cartLength = cartC.length;

        if (kDebugMode) {
          print("Cart Length: $cartLength");
        }

        emit(cart.isEmpty ? CartEmpty() : CartDone());
      }
      else {
        throw Exception('فشل في تحميل بيانات السلة');
      }
    } catch (e) {
      if (kDebugMode) {
        print('خطأ: $e');
      }
    }
    print("cart length: ${cart.length}");
    return cart;
  }

  void removeFromCart({required BuildContext context ,required String id,
  }) async {
    try {



      final response = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },

      );
      if (kDebugMode) {
        print('Request body: ${jsonEncode({'_id': id})}');
      }
      if (response.statusCode == 200) {
        if(kDebugMode){
          print("remove quantity");
        }
        if (kDebugMode) {
          print(response.body);
        }
        listProducts.removeWhere((product) => product.id == id);
        total = calculateTotal(); // Update total
        emit(CartLoaded(listProducts: listProducts, total: total));
      } else {
        // Handle error response

        if (kDebugMode) {
          print('HTTP request error: ${response.statusCode} - ${response.body}');
        }
        emit(RemoveCartError());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(RemoveCartError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(state);
    }
  }

  double calculateTotal() {
    return listProducts.fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }
}
