import 'dart:convert';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../helper/cache_helper.dart';
import '../../../model/product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  List<Product> products = [];

  Future<void> searchProducts(String name) async {
    emit(SearchLoading());
    final url = '$uri/api/products/search/$name';

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
        emit(SearchDone());
      } else {
        emit(SearchError());
      }
    } catch (e) {
      emit(SearchError());
    }
  }
}
