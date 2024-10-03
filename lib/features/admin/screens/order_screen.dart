import 'package:amazon_clone/common/loader_screen.dart';
import 'package:amazon_clone/features/account/widget/single_product.dart';
import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:amazon_clone/features/order_details/screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreenAdmin extends StatefulWidget {
  const OrderScreenAdmin({super.key});

  @override
  State<OrderScreenAdmin> createState() => _OrderScreenAdminState();
}

class _OrderScreenAdminState extends State<OrderScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = AddProductCubit.get(context);
        if (state is OrdersLoading) {
          return const LoaderScreen();
        } else if (state is OrderEmpty) {
          return const Center(
            child: Text("Order is empty"),
          );
        }
        return Stack(
          children: [
            // Use Expanded or a SizedBox with a defined height
            ListView(
              children: [
                Column(
                  children: [
                    GridView.builder(
                      itemCount: cubit.listOrders.length,
                 physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final order = cubit.listOrders[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, OrderScreen.routeName, arguments: order);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleProduct(
                              image: order.products[index].images.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        );      },
    );
  }
}
