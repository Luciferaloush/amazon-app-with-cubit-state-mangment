import 'package:amazon_clone/features/account/widget/below_app_bar.dart';
import 'package:amazon_clone/features/account/widget/order.dart';
import 'package:amazon_clone/features/account/widget/top_button.dart';
import 'package:amazon_clone/features/order_details/cubit/order_cubit.dart';
import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
   AccountScreen({super.key});
 final List texButton = [
   "Your Order",
   "Turn seller",
   "Log Out",
   "Your Wish List"
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.search_outlined),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocProvider(
  create: (context) => OrderCubit()..getOrder(context),
  child: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  const BelowAppBar(),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),itemCount: 4,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,childAspectRatio: 5
                    ),
                    itemBuilder: (context, index) {
                      return TopButton(
                        text: texButton[index],
                        onPressed: (){


                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          'Your Orders',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          'See All',
                          style: TextStyle(color: GlobalVariables.selectedNavBarColor),
                        ),
                      )
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Orders(),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
),
    );
  }
}
