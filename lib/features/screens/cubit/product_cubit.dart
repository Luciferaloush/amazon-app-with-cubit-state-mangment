import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../helper/cache_helper.dart';
import '../../../model/product.dart';
import '../../../utils/constants/global_variables.dart';
import 'package:http/http.dart' as http;

import '../../../utils/snackbar.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);
  List<Product> products = [];
  Product product = Product(
      name: "",
      description: "",
      images: [],
      quality: 0,
      price: 0,
      category: '');

  Future<void> getCategory(String category) async {
    emit(CategoryLoading());
    final url = '$uri/api/products/$category';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheHelper.getData(key: "token"),
      });
      if (kDebugMode) {
        print("-------------------------------- ${response.body}");
      }
      if (response.statusCode == 200) {
        // final List<dynamic> data = jsonDecode(response.body);
        // products = data.map<Product>((e) => Product.fromJson(e)).toList();
        final List<dynamic> data = json.decode(response.body);
        products = data.map((json) => Product.fromJson(json)).toList();
        emit(CategoryLoaded());
      } else {
        emit(CategoryError());
      }
    } catch (e) {
      emit(CategoryError());
    }
  }

  Future<Product> fetchDealOfDay(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all products");
    }
    try {

      http.Response res =
          await http.get(Uri.parse("$uri/api/deal-of-day"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheHelper.getData(key: "token"),
      });
      if (kDebugMode) {
        print(CacheHelper.getData(key: "token"));
        print(res.body);
      }
      if (kDebugMode) {
        print(res.statusCode);
      }
      if (res.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
        product = Product.fromJson(jsonResponse);
        emit(DealOfDayLoad());
        if (kDebugMode) {
          print("STATE:------- $state");
        }
      } else {
        // Handle the error
        showSnackBar(context, 'Error fetching products: ${res.statusCode}');
        throw Exception('Failed to fetch products');
      }
      return product;
    } catch (e) {
      emit(DealOfDayError());
      showSnackBar(context, "Error fetching products: ${e.toString()}");
      rethrow;
    }
  }
}
