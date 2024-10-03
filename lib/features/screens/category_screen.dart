import 'package:amazon_clone/features/screens/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants/global_variables.dart';
import '../product_details/screen/product_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.category});

  final String category;
  static const String routeName = '/category-deals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              'Category',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => ProductCubit()..getCategory(category),
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              ProductCubit cubit = ProductCubit.get(context);
              if (state is CategoryLoaded) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Text('Keep shopping for $category ',
                          style: const TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 170,
                      child: GridView.builder(
                        padding: const EdgeInsets.only(left: 15),
                        itemCount: cubit.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = cubit.products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailsScreen.routeName,
                                  arguments: product);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 130,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black12, width: 0.5)),
                                    child: Image.asset("assets/ss.jpg",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                                Text(product.name.toString())
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is ProductError) {
                return const Center(
                  child: Text("Product Error"),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
