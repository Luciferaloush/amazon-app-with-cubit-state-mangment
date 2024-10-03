import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/splash_cubit.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<SplashCubit>(context);
    cubit.checkRegistrationStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is RegistrationCompleteState) {
            if (kDebugMode) {
              print("Success");
            }
          }
        },
        builder: (context, state) {
          if (state is RegistrationCompleteState) {
            return const BottomNavBar();
          } else if (state is RegistrationCompleteStateAdmin) {
            return AdminScreen();
          } else if (state is RegistrationIncompleteState) {
            return const AuthScreen();
          }

          return const Center(
            child: Text("AMAZON APP"),
          );
        },
      ),
    );
  }
}
