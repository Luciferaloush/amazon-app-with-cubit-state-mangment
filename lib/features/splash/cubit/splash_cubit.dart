import 'dart:async';
import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(InitialState());

  void checkRegistrationStatus(BuildContext context) {
    final cubit = BlocProvider.of<AuthScreenCubit>(context);
    if (kDebugMode) {
      print("type splash: ${cubit.getUserType()}");
    }
    if (cubit.isRegistered()) {
      cubit.getUser(context: context); // Get the user data
      String? userType = cubit.getUserType();
      if (kDebugMode) {
        print("---------------- $userType");
      }
      if (userType == 'Admin') {
        // Navigate to the admin screen
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/admin_screen", (route) => false);
        });
        emit(RegistrationCompleteStateAdmin());
      } else if (userType == "user") {
        // Navigate to the home screen
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/actual_home", (route) => false);
        });
        emit(RegistrationCompleteState());
      }
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/auth_screen", (route) => false);
      });
      emit(RegistrationIncompleteState());
    }
    if (kDebugMode) {
      print("STATE SPLASH: $state");
    }
  }
}
