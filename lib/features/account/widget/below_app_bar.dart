import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthScreenCubit()..getUser(context: context),
      child: BlocConsumer<AuthScreenCubit, AuthScreenState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is UserDataLoaded) {
            return Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Hello, ",
                        style: const TextStyle(fontSize: 22, color: Colors.black),
                        children: [
                          TextSpan(
                            text: state.user.name.toString(),
                            style:
                                const TextStyle(fontSize: 22, color: Colors.black),
                          )
                        ]),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
