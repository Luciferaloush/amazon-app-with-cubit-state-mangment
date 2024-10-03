import 'package:amazon_clone/features/account/widget/single_product.dart';
import 'package:amazon_clone/features/order_details/cubit/order_cubit.dart';
import 'package:amazon_clone/features/order_details/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = OrderCubit.get(context);
        return Column(
          children: [
            Container(
              height: 170,
              padding: const EdgeInsets.only(
                left: 10,
                top: 20,
                right: 0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: cubit.orders.length,
                itemBuilder: (context, index) {
                  final orders = cubit.orders[index];
                  return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, OrderScreen.routeName,
                            arguments: orders);
                      },
                      child:  SingleProduct(image: orders.products[index].images[0].toString()));
                },
              ),
            )
          ],
        );
      },
    );
  }
}
