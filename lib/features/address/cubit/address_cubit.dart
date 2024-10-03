import 'dart:convert';
import 'package:amazon_clone/model/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../helper/cache_helper.dart';
import '../../../utils/constants/global_variables.dart';
import '../../../utils/snackbar.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  static AddressCubit get(context) => BlocProvider.of(context);
  final addressFormKey = GlobalKey<FormState>();
  final TextEditingController flat = TextEditingController();
  final TextEditingController areaStreet = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController townCity = TextEditingController();
  List<Cart> listProducts = [];

  String getFullAddress() {
    return '${flat.text}, ${areaStreet.text}, ${pinCode.text}, ${townCity.text}';
  }

  void placeOrder({
    required BuildContext context,
    required List<Cart> cart,
    required String totalPrice,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$uri/api/order"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: "token"),
        },
        body: jsonEncode({
          "cart": cart.map((c) => c.toJson()).toList(),
          "totalPrice": totalPrice,
          "address": getFullAddress()
        }),
      );
      if (kDebugMode) {
        print("response body  ${response.body}");
      }
      if (kDebugMode) {
        print("Sending cart: ${cart.map((c) => c.toJson()).toList()}");
      }
      if (response.statusCode == 200) {
        emit(ProductLoaded());
      } else {
        if (kDebugMode) {
          print("Error response: ${response.body}");
        }
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      showSnackBar(context, "Error fetching products: ${e.toString()}");
      rethrow;
    }
  }
}
