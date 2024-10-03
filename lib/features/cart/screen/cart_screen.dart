import 'package:amazon_clone/common/loader_screen.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/address/screen/address_screen.dart';
import 'package:amazon_clone/features/cart/cubit/cart_cubit.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/product_details/cubit/product_details_cubit.dart';
import 'package:amazon_clone/features/screens/widgets/address_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/global_variables.dart';
import '../../search/cubit/search_cubit.dart';
import '../../search/screen/search_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key,});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              CartCubit cubit = CartCubit();
              cubit.fetchCart();
              return cubit;
            },
          ),
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(
            create: (context) => ProductDetailsCubit(),
          )
        ],
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 15),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: BlocConsumer<SearchCubit, SearchState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            final searchCubit = SearchCubit.get(context);
                            return TextFormField(
                              onFieldSubmitted: (String query) {
                                searchCubit.searchProducts(query);
                                Navigator.pushNamed(
                                    context, SearchScreen.routeName,
                                    arguments: query);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(Icons.search_outlined,
                                          color: Colors.black, size: 23),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    borderSide: const BorderSide(
                                        color: Colors.black38, width: 1),
                                  ),
                                  hintText: "Search Amazon.in",
                                  hintStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 42,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(Icons.mic, color: Colors.black, size: 24),
                  )
                ],
              ),
            ),
          ),
          body: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {

              },
            builder: (context, state) {
              final cubit = CartCubit.get(context);
              if (state is CartDone) {
                if (cubit.cart.isEmpty) {
                  return const Center(child: Text("Cart is Empty")); // Handle empty cart
                }
                return Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const AddressBox(),
                          CartSubTotal(subtotal: cubit.totalU),
                          const SizedBox(height: 15),
                          Container(color: Colors.black.withOpacity(0.08), height: 1),
                          const SizedBox(height: 5),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.cart.length + 1,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index < cubit.cart.length) {
                                final cartItems = cubit.cart[index].cart;
                                print("cart------- $cartItems");
                                if (cartItems != null && cartItems.isNotEmpty) {
                                  return Column(
                                    children: List.generate(cartItems.length, (cartIndex) {
                                      return CartProduct(product: cartItems[cartIndex]);
                                    }),
                                  );
                                }
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomButton(
                                    onTap: () {
                                      if (cubit.cart.isNotEmpty && cubit.cart[index - 1].cart!.isNotEmpty) {
                                        final selectedCartItems = cubit.cart[index - 1].cart;
                                        Navigator.pushNamed(
                                          context,
                                          AddressScreen.routeName,
                                          arguments: {
                                            'totalPrice': cubit.totalU.toString(),
                                            'cart': selectedCartItems,
                                          },
                                        );
                                      }
                                    },  width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    color: Colors.yellow,
                                    text: "Product to buy ${cubit.cartLength} items",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              else if (state is CartEmpty) {
                return const Center(child: Text("Cart is Empty"));
              }

              return const LoaderScreen(); // Show loader if state is loading
            },
          ),        )
    );
  }
}
