import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/admin_screen_cubit.dart';
import 'package:amazon_clone/features/admin/screens/order_screen.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/global_variables.dart';
import 'category_charts.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({super.key});

  static const routeName = '/admin_screen';
  final List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsPage(),
    const OrderScreenAdmin()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AdminScreenCubit(),
        ),
        BlocProvider(
          create:(context) {
            AddProductCubit cubit = AddProductCubit();
            cubit.fetchAllOrders(context);
            cubit.fetchAllProduct(context);
            return cubit;
          },
        ),
      ],
      child: BlocConsumer<AdminScreenCubit, AdminScreenState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AdminScreenCubit cubit = AdminScreenCubit.get(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: GlobalVariables.appBarGradient),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Logo AMAZON",
                      ),
                    ),
                    const Text("Admin",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: cubit.updatePage,
              currentIndex: cubit.page,
              backgroundColor: GlobalVariables.backgroundColor,
              selectedItemColor: GlobalVariables.selectedNavBarColor,
              unselectedItemColor: GlobalVariables.unselectedNavBarColor,
              iconSize: 42,
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                        color: cubit.page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: 5,
                      ))),
                      child: const Icon(Icons.home_outlined),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                        color: cubit.page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: 5,
                      ))),
                      child: const Icon(Icons.analytics_outlined),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                        color: cubit.page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: 5,
                      ))),
                      child: const Icon(Icons.all_inbox_outlined),
                    ),
                    label: ""),
              ],
            ),
            body: pages[cubit.page],
          );
        },
      ),
    );
  }
}
