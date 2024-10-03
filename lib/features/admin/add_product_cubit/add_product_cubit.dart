import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/helper/cache_helper.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../model/earnings.dart';
import '../../../model/product.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  static AddProductCubit get(context) => BlocProvider.of(context);

  final addProduct = GlobalKey<FormState>();

  final TextEditingController productName = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  late String category = 'Mobiles';
  List<File> images = [];
  List<String> base64Images = [];
  List<String> imageUrls = [];
   Earnings earnings = Earnings();
  void onChangedValue(String? newVal) {
    if (newVal != null) {
      category = newVal;
      emit(NewValue(category: category));
    }
  }

  List<Product> listProducts = [];
  List<Order> listOrders = [];



  Future<List<File>>pickImages() async{
    try{
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true
      );
      if(files != null && files.files.isNotEmpty){
        for(int i = 0; i < files.files.length; i++){
          images.add(File(files.files[i].path!));
        }
      }

    }catch (e) {
      debugPrint(e.toString());
    }
    return images;
   }

   void selectImage()async {
    var res = await pickImages();
    emit(PickImages(images: res));
   }
  void sellProduct({required BuildContext context}) async {
    try {
      final cloudinary = CloudinaryPublic('dfoitqico', 'hk2d1zrm');

      // Upload images to Cloudinary
      for (int i = 0; i < images.length; i++) {
        try {
          CloudinaryResponse res = await cloudinary
              .uploadFile(CloudinaryFile.fromFile(images[i].path));
          imageUrls.add(res.secureUrl);
          if (kDebugMode) {
            print('Images: $images');
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error uploading image $i: $e');
          }
        }
      }


      final response = await http.post(
        Uri.parse('$uri/admin/add_products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },
        body: jsonEncode({
          "name": productName.text.trim(),
          "decription": description.text.trim(),
          "image": imageUrls,
          "quantity": 88.2,
          "price": double.parse(price.text.trim()),
          "category": category
        }),
      );
      if (response.statusCode == 200) {
        showSnackBar(context, 'Product added successfully');
        if (kDebugMode) {
          print(response.body);
        }
        emit(AddProductDone());
      } else {
        // Handle error response
        if (kDebugMode) {
          print('HTTP request error: ${response.statusCode} - ${response.body}');
        }
        emit(ProductError());
      }
    } catch (e) {
      emit(ProductError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(state);
    }
  }

  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all products");
    }
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/admin/get-product"), headers: {
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
        debugPrint('Products Loaded: $listProducts');

        if (listProducts.isEmpty) {
          emit(ProductEmpty());
        } else {
          emit(ProductLoaded(listProducts: listProducts));
        }

        if (kDebugMode) {
          print("STATE:------- $state");
        }

        return listProducts;
      } else {
        // Handle the error
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      emit(ProductError());
      rethrow;
    }
  }

  void deleteProduct(
      {required BuildContext context, required String id}) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },
        body: jsonEncode({
          "_id": id,
        }),
      );
      if (response.statusCode == 200) {
        showSnackBar(context, 'Product delete successfully');
        if (kDebugMode) {
          print(response.body);
        }
        listProducts.removeWhere((product) => product.id == id);
        emit(ProductLoaded(listProducts: listProducts));      } else {
        // Handle error response
        if (kDebugMode) {
          print('HTTP request error: ${response.statusCode} - ${response.body}');
        }
        emit(DeleteProductError());
      }
    } catch (e) {
      emit(DeleteProductError());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(state);
    }

  }


  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    if (kDebugMode) {
      print("Fetching all products");
    }
    try {
      emit(OrdersLoading());
      if (kDebugMode) {
        print(state);
      }
      http.Response res =
      await http.get(Uri.parse("$uri/admin/get-orders"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheHelper.getData(key: "token"),
      });
      if (kDebugMode) {
        print("tokennnn");
        print(CacheHelper.getData(key: "token"));
        print(res.body);
      }
      if (kDebugMode) {
        print(res.statusCode);
      }
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        listOrders = data.map<Order>((e) => Order.fromJson(e)).toList();
        if (listOrders.isEmpty) {
          emit(OrderEmpty());
        } else {
          emit(OrderDone());
        }

        if (kDebugMode) {
          print("STATE:------- $state");
        }

        return listOrders;
      } else {
        // Handle the error
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      emit(OrderDone());
      rethrow;
    }
  }
  void changeOrderStatus(
      {required BuildContext context, required int status, required Order order}) async {
    try {
      final response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': CacheHelper.getData(key: 'token'),
        },
        body: jsonEncode({
          "id": order.id,
          "status":status
        }),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        emit(ChangeOrderStatusSuccess());      }
      else {
        // Handle error response
        if (kDebugMode) {
          print('HTTP request error: ${response.statusCode} - ${response.body}');
        }
        emit(ChangeOrderStatusFailure());
      }
    } catch (e) {
      emit(ChangeOrderStatusFailure());
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (kDebugMode) {
      print(state);
    }

  }
  
  getEarnings()async{
    emit(EarningsLoading());
    try {
       http.Response res =await http.get(
         Uri.parse("$uri/admin/analytics"),headers: {
       'Content-Type': 'application/json; charset=UTF-8',
       'token': CacheHelper.getData(key: 'token')
       }
       );
       if(res.statusCode == 200){
         earnings = Earnings.fromJson(json.decode(res.body));
         emit(EarningsLoaded());
         print(res.body);
       }else{
         emit(EarningsFailed());
       }
    }catch(e){
      if(kDebugMode) {
        print(state);
        print(e);
      }
      emit(EarningsFailed());
    }
  }
}
