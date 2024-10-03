import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends StatelessWidget {
  const AuthBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthScreenCubit(),child: AuthScreen(),);
  }
}
