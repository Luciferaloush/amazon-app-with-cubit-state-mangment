import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/cubit/auth_screen_cubit.dart';
import 'features/auth/screen/auth_screen.dart';

class AppStart extends StatefulWidget {
  const AppStart({Key? key}) : super(key: key);

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthScreenCubit>(context).checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthScreenCubit, AuthScreenState>(
      builder: (context, state) {
        if (state is AuthScreenInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthScreenLoggedIn) {
          // Navigate to UserPage
          return const BottomNavBar();
        } else if (state is AuthScreenInitial) {
          // Navigate to AuthScreen
          return const AuthScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Error checking authentication'),
            ),
          );
        }
      },
    );
  }
}
