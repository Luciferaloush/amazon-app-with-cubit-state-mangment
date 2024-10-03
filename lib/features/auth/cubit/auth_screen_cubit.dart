import 'package:amazon_clone/features/enum/auth.dart';
import 'package:amazon_clone/helper/cache_helper.dart';
import 'package:amazon_clone/utils/constants/error_handling.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/user.dart';
import '../../splash/screen/splash.dart';

part 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  AuthScreenCubit() : super(AuthScreenInitial());

  static AuthScreenCubit get(context) => BlocProvider.of(context);
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailLogin = TextEditingController();
  final TextEditingController passwordLogin = TextEditingController();
   String userName = '';
  String get getUserName => userName;

  Auth auth = Auth.signup;
  String userType = '';
  void ocChanged(Auth value) {
    auth = value;
    emit(AuthScreenChange());
  }

  Future<void> registerUser({required BuildContext context}) async {
    emit(RegisterLoading());

    final url = Uri.parse('$uri/api/signup');
    final user = User(
        id: '',
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        address: '',
        type: 'Admin', // You can modify this based on your logic
        token: '',
        cart: []
    );
    final body = user.toJson();

    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (kDebugMode) {
          print('User created successfully');
        }
        userType = user.type; // Set userType here
        CacheHelper.saveData(key: "name", value: user.name);
        CacheHelper.saveData(key : "user-type", value: userType);

        emit(RegisterSuccess());
      } else {
        if (kDebugMode) {
          print('Failed to create user: ${response.statusCode} - ${response.body}');
        }
        emit(RegisterFailure(err: jsonDecode(response.body)['err']));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
      emit(RegisterFailure(err: e.toString()));
    }
  }

  Future<void> loginUser({required BuildContext context}) async {
    emit(LoginLoading());
    final url = Uri.parse('$uri/api/signin');
    final body = jsonEncode({
      "email": emailLogin.text.trim(),
      "password": passwordLogin.text.trim()
    });
    try {
      http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      if (response.statusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 202) {
        if (kDebugMode) {
          print('User login successfully');
          print('\n');
          print(jsonDecode(response.body)['type']);
          userType = jsonDecode(response.body)['type']; // Set userType here
          CacheHelper.saveData(key : "user-type", value: userType);
          print("Type User:  $userType");
          print(response.body);
          CacheHelper.saveData(
              key: "token", value: jsonDecode(response.body)['token']);
          CacheHelper.saveData(
              key: "type", value: userType); // Save the userType
          emit(LoginSuccess());
          print('tokeeeeeeen : ${CacheHelper.getData(key: "token")}');
        }
      } else {
        if (kDebugMode) {
          print('Failed user: ${response.statusCode} - ${response.body}');
          emit(LoginFailure(err: jsonDecode(response.body)['msg']));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user: $e');
      }
      emit(LoginFailure(err: e.toString()));
    }
  }

  Future<bool> isTokenValid() async {
    final response = await http.post(
      Uri.parse('$uri/tokenIsValid'),
      headers: {'token': GlobalVariables().token},
    );

    if (response.statusCode == 200) {
      return response.body == 'true';
    } else {
      return false;
    }
  }

  void getUser({required BuildContext context}) async {
    emit(UserDataLoading());
    try {
      final url = Uri.parse('$uri/api/profile/${GlobalVariables().token}');
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        print("userd ataaaaaaaa: $userData");
        final user = User(
          id: '',
          name: userData['name'],
          email: userData['email'],
          password: '',
          address: userData['address'],
          type: userData['type'],
          token: GlobalVariables().token,
          cart: []
        );
        userName = userData['name']; // Update the userName variable
        emit(UserDataLoaded(user));
      } else {
        emit(UserDataError());
      }
    } catch (e) {
      emit(UserDataError());
      showSnackBar(context, e.toString());
    }
  }


  void checkAuthStatus() async {
    final token = CacheHelper.getData(key: "token");
    if (token != null) {
      final isValid = await isTokenValid();
      if (isValid) {
        emit(AuthScreenLoggedIn());
      } else {
        emit(AuthScreenLoggedOut());
      }
    } else {
      emit(AuthScreenLoggedOut());
    }
  }
  logOut(BuildContext context) async {
    // Clear cached data
    await CacheHelper.clearData();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Splash()), // Replace with your splash or login screen
          (route) => false,
    );

    SystemNavigator.pop();
  }
  bool isRegistered() {
    String? apiToken = CacheHelper.getData(key: "token");
    return apiToken != null;
  }
  String getUserType() {
  return CacheHelper.getData(key: "user-type") ?? '';
  }
}
