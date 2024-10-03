import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/global_variables.dart';
import '../cubit/auth_screen_cubit.dart';

class UserProfilePage extends StatelessWidget {
  static const String routeName = "/user_profile";

  const UserProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthScreenCubit()..getUser(context: context),
      child: BlocConsumer<AuthScreenCubit, AuthScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthScreenCubit cubit = AuthScreenCubit.get(context);
          if (state is UserDataLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('User Profile'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${state.user.name}'),
                    const SizedBox(height: 8),
                    Text('Email: ${state.user.email}'),
                    const SizedBox(height: 8),
                    Text('Address: ${state.user.address}'),
                    const SizedBox(height: 8),
                    Text('Type: ${state.user.type}'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      text: "logOut",
                      style: const TextStyle(color: Colors.white),
                      color: GlobalVariables.secondaryColor,
                      onTap: () {

                        cubit.logOut(context);
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (state is UserDataError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('User Profile'),
              ),
              body: const Center(
                child: Text('Error loading user data'),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
