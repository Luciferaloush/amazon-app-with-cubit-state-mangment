import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:amazon_clone/features/auth/screen/user_profile_page.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:amazon_clone/utils/error_screen/not_exist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String routName = "/auth_screen";

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AuthScreenCubit(),
      child: Scaffold(
        backgroundColor: GlobalVariables.grayBackgroundColor,
        body: BlocConsumer<AuthScreenCubit, AuthScreenState>(
          listener: (context, state) {
            final cubit = AuthScreenCubit.get(context);
            if (state is RegisterSuccess) {
              if (kDebugMode) {
                print("success operation");
              }

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Register Sucess Operation'),
                      content: const Text('Please, Login to Su'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: const Text('OK'),
                        )
                      ],
                    );
                  });
            }
            if (state is LoginSuccess) {
              if(cubit.getUserType() == 'Admin'){
                Navigator.pushNamedAndRemoveUntil(
                    context, AdminScreen.routeName, (route) => false);
              }else if(cubit.getUserType() == 'user'){Navigator.pushNamedAndRemoveUntil(
                  context, BottomNavBar.routeName, (route) => false);}else {
                Navigator.pushNamed(context, ScreenDoesNotExist.routeName);
              }

            }
            if(state is RegisterFailure){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Register Failure Operation'),
                      content:  Text("${state.runtimeType.toString()} ${state.err}"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: const Text('OK'),
                        )
                      ],
                    );
                  });
            }
            if(state is LoginFailure){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Register Failure Operation'),
                      content:  Text("${state.runtimeType.toString()} ${state.err}"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: const Text('OK'),
                        )
                      ],
                    );
                  });
            }
          },
          builder: (context, state) {
            AuthScreenCubit cubit = AuthScreenCubit.get(context);
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    ListTile(
                      title: const Text(
                        "Create Account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signup,
                        groupValue: cubit.auth,
                        onChanged: (value) {
                          if (value != null) {
                            cubit.ocChanged(value as Auth);
                          }
                        },
                      ),
                    ),
                    if (cubit.auth == Auth.signup)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: cubit.signUpFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: cubit.nameController,
                                hintText: "Name",
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: cubit.emailController,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: cubit.passwordController,
                                hintText: "Password",
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: "Sign Up",
                                onTap: () {
                                  if (cubit.signUpFormKey.currentState!
                                      .validate()) {
                                    cubit.registerUser(context: context);
                                  }
                                },
                                color: GlobalVariables.secondaryColor,
                                style: const TextStyle(color: Colors.white),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (cubit.auth == Auth.signin)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        color: GlobalVariables.backgroundColor,
                        child: Form(
                          key: cubit.signInFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: cubit.emailLogin,
                                hintText: "Email",
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: cubit.passwordLogin,
                                hintText: "Password",
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                text: "Log In",
                                onTap: () {
                                  if (cubit.signInFormKey.currentState!
                                      .validate()) {
                                    cubit.loginUser(context: context);
                                  }
                                },
                                color: GlobalVariables.secondaryColor,
                                style: const TextStyle(color: Colors.white),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                              )
                            ],
                          ),
                        ),
                      ),
                    ListTile(
                      title: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: cubit.auth,
                        onChanged: (value) {
                          if (value != null) {
                            cubit.ocChanged(value as Auth);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
