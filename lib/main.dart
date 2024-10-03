import 'package:amazon_clone/app_start.dart';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/features/splash/cubit/splash_cubit.dart';
import 'package:amazon_clone/helper/cache_helper.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splash/screen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthScreenCubit()),
      // Add other providers here
    ],
    child: MyApp(),
    )  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.secondaryColor),
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        home:

        MultiBlocProvider(
          providers: [BlocProvider(
            create: (context) => AuthScreenCubit()..getUserType(), // Provide the RegisterCubit
          ),
            BlocProvider(
              create: (context) => SplashCubit()..checkRegistrationStatus(context), // Provide the RegisterCubit
            )
          ],
          child: const Splash(),

        )

    );
  }
}
