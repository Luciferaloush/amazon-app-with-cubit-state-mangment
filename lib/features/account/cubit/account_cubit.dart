import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../helper/cache_helper.dart';
import '../../../model/order.dart';
import '../../../utils/constants/global_variables.dart';
import '../../../utils/snackbar.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  static AccountCubit get(context) => BlocProvider.of(context);

  List<Order> orderList = [];

  Future<List<Order>> fetchAllProduct(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all products");
    }
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/orders/me"), headers: {
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
        orderList = data.map<Order>((e) => Order.fromJson(e)).toList();

        if (orderList.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderLoaded(orderList: orderList));
        }

        if (kDebugMode) {
          print("STATE:------- $state");
        }

        return orderList;
      } else {
        // Handle the error
        showSnackBar(context, 'Error fetching products: ${res.statusCode}');
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      emit(OrderError());
      showSnackBar(context, "Error fetching products: ${e.toString()}");
      rethrow;
    }
  }
}
