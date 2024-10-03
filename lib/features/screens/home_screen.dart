import 'package:amazon_clone/features/screens/cubit/product_cubit.dart';
import 'package:amazon_clone/features/screens/widgets/address_box.dart';
import 'package:amazon_clone/features/screens/widgets/carousel_image.dart';
import 'package:amazon_clone/features/screens/widgets/deal_of_day.dart';
import 'package:amazon_clone/features/screens/widgets/top_categories.dart';
import 'package:amazon_clone/features/search/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants/global_variables.dart';
import '../search/cubit/search_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchCubit(),
          ),
          BlocProvider(
            create: (context) => ProductCubit()..fetchDealOfDay(context),
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
          body: const SingleChildScrollView(
            child: Column(
              children: [
                AddressBox(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TopCategories(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CarouselImage(),
                DealOfDay(),
              ],
            ),
          ),
        ));
  }
}
