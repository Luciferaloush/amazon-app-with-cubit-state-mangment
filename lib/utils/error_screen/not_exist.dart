import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/splash/screen/splash.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/splash/cubit/splash_cubit.dart';

class ScreenDoesNotExist extends StatelessWidget {
  static const String routeName = "/screen_does_not_exist";
  const ScreenDoesNotExist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Screen does not exist")],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      // Provide SplashCubit here
                      return BlocProvider(
                        create: (context) => SplashCubit(),
                        child: const Splash(),
                      );
                    }),
                        (Route<dynamic> route) => false,
                  );
                },
                width: MediaQuery.of(context).size.width / 2,
                height: 30,
                color: GlobalVariables.backgroundColor,
                text: "Go Back",
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}