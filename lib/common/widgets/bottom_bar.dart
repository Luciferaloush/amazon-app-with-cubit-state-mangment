import 'package:amazon_clone/features/account/screen/account_screen.dart';
import 'package:amazon_clone/features/cart/cubit/cart_cubit.dart';
import 'package:amazon_clone/features/cart/screen/cart_screen.dart';
import 'package:amazon_clone/features/screens/home_screen.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const routeName = '/actual_home';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  List<Widget> pages = [
    const HomeScreen(),
    AccountScreen(),
    const CartScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartCubit()..fetchCart(),
          ),
        ],
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = CartCubit.get(context);
            return BottomNavigationBar(
              onTap: updatePage,
              currentIndex: _page,
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
                        color: _page == 0
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
                        color: _page == 1
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: 5,
                      ))),
                      child: const Icon(Icons.person_2_outlined),
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Container(
                      width: 42,
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : GlobalVariables.backgroundColor,
                        width: 5,
                      ))),
                      child: Badge(
                          label: Text(
                            cubit.cartLength.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.shopping_cart_outlined)),
                    ),
                    label: "")
              ],
            );
          },
        ),
      ),
    );
  }
}
