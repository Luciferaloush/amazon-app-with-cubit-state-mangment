import 'package:amazon_clone/features/splash/screen/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import '../../../helper/cache_helper.dart';
import '../../../model/order.dart';
import '../../../utils/constants/global_variables.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);
   List<Order> orders = [];

  Future<List<Order>> getOrder(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all Orders.....");
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
        if (kDebugMode) {
          print(res.body);
        }
        List<dynamic> data = jsonDecode(res.body);
        print("Fetched data: $data");
        orders = data.map<Order>((e) => Order.fromJson(e)).toList();
        print("Orders: $orders");
        if (orders.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderDone());
        }

        if (kDebugMode) {
          print("STATE:------- $state");
        }

        return orders;
      } else {
        // Handle the error
        throw Exception('Failed to fetch products');
      }

    } catch (e) {
      emit(OrderError());
      rethrow;

    }

  }

void logOut(BuildContext context){
    CacheHelper.clearData();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Splash(),), (route) => false);
}
}
