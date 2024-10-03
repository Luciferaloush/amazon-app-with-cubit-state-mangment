import 'package:amazon_clone/features/product_details/screen/product_details.dart';
import 'package:amazon_clone/features/screens/cubit/product_cubit.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProductCubit cubit = ProductCubit.get(context);
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: cubit.product);
          },
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: const Text(
                  "Deal of day",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Image.network(
                'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                fit: BoxFit.fitHeight,
                height: 235,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                alignment: Alignment.topLeft,
                child: Text("\$${cubit.product.price}",
                    style: const TextStyle(fontSize: 18)),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15, right: 40, top: 5),
                child: Text(
                  cubit.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.network(
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                      fit: BoxFit.fitWidth,
                      width: 100,
                      height: 100,
                    ),
                    Image.network(
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                      fit: BoxFit.fitWidth,
                      width: 100,
                      height: 100,
                    ),
                    Image.network(
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                      fit: BoxFit.fitWidth,
                      width: 100,
                      height: 100,
                    ),
                    Image.network(
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                      fit: BoxFit.fitWidth,
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
                alignment: Alignment.topLeft,
                child: Text('See All deals',
                    style: TextStyle(color: Colors.cyan[800])),
              )
            ],
          ),
        );
      },
    );
  }
}
