import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:amazon_clone/features/admin/screens/add_product.dart';
import 'package:amazon_clone/features/admin/widget/single_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddProduct.routeName);
        },
        tooltip: "Add Product",
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add_outlined),

      ),
      body: BlocProvider(
        create: (context) =>
        AddProductCubit()
          ..fetchAllProduct(context),
        child: BlocConsumer<AddProductCubit, AddProductState>(
          listener: (context, state) {

          },
            builder: (context, state) {
              if (state is ProductEmpty) {
                return const Center(
                  child: Text("Product is empty"),
                );
              } else if (state is ProductLoaded) {
                AddProductCubit cubit = AddProductCubit.get(context);
                debugPrint('Loaded Products: ${state.listProducts}');
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GridView.builder(
                      itemCount: state.listProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.listProducts[index];
                        final productImages = product.images;
                        if (kDebugMode) {
                          print(productImages);
                        }
                        debugPrint('Product Image: ${productImages[0]}');
                        return Column(
                          children: [
                            SizedBox(
                              height: 140,
                              child: SingleProduct(
                                image: productImages[0],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.deleteProduct(context: context, id: product.id.toString());
                                  },
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                  ),
                );
              }
              return Container();
            }        ),
      ),
    );
  }
}
