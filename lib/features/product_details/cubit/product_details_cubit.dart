import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/cache_helper.dart';
import '../../../model/product.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/global_variables.dart';
import '../../../utils/snackbar.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  List<Product> listProducts = [];
  int cartLength = 0;
  void addTOCart({required BuildContext context, required String id}) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },
        body: jsonEncode({'_id': id}),
      );

      if (response.statusCode == 200) {
        showSnackBar(context, 'Product added successfully');
        cartLength++;
        emit(AddProductSuccess());
      } else {
        emit(AddRatingError());
      }
    } catch (e) {
      if (!isClosed) {
        emit(AddRatingError());
      }
      showSnackBar(context, e.toString());
    }
  }
  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all products");
    }
    try {
      http.Response res =
      await http.get(Uri.parse("$uri/api/product/get-product"), headers: {
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
        List<dynamic> data = jsonDecode(res.body);
        listProducts = data.map<Product>((e) => Product.fromJson(e)).toList();

        if (listProducts.isEmpty) {
          emit(ProductDetailsEmpty());
        } else {
          emit(ProductDetailsLoad(listProducts: listProducts));
        }

        if (kDebugMode) {
          print("STATE:------- $state");
        }

        return listProducts;
      } else {
        // Handle the error
        showSnackBar(context, 'Error fetching products: ${res.statusCode}');
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      emit(ProductDetailsError());
      rethrow;
    }
  }

  void rateProduct({required BuildContext context ,required Product product,
    required double rating}) async {
    try {



      final response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },
        body: jsonEncode({
          '_id': product.id,
          'rating':rating
        }),
      );
      if (response.statusCode == 200) {
        showSnackBar(context, 'Product added successfully');
        if (kDebugMode) {
          print(response.body);
        }
        emit(AddRatingDone());
      } else {
        // Handle error response
        if (kDebugMode) {
          print('HTTP request error: ${response.statusCode} - ${response.body}');
        }
        emit(AddRatingError());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      emit(AddRatingError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(state);
    }
  }
}
