import 'package:amazon_clone/features/product_details/screen/product_details.dart';
import 'package:amazon_clone/features/screens/widgets/address_box.dart';
import 'package:amazon_clone/features/search/cubit/search_cubit.dart';
import 'package:amazon_clone/features/search/widget/searched_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/global_variables.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.searchQuery});

  static const String routeName = "/search-screen";
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
                      child: BlocProvider(
                        create: (context) => SearchCubit(),
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
        body: BlocProvider(
          create: (context) => SearchCubit()..searchProducts(searchQuery),
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              SearchCubit cubit = SearchCubit.get(context);
              return Column(
                children: [
                  const AddressBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: cubit.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: cubit.products[index]);
                          },
                          child:
                              SearchedProduct(product: cubit.products[index]));
                    },
                  ))
                ],
              );
            },
          ),
        ));
  }
}
