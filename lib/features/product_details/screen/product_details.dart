import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_details/cubit/product_details_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../model/product.dart';
import '../../../utils/constants/global_variables.dart';
import '../../search/cubit/search_cubit.dart';
import '../../search/screen/search_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  static const String routeName = "/product_details";
  final Product product;

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
                          final cubit = SearchCubit.get(context);
                          return TextFormField(
                            onFieldSubmitted: (String query) {
                              cubit.searchProducts(query);
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
                                contentPadding: const EdgeInsets.only(top: 10),
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
                                    fontSize: 17, fontWeight: FontWeight.w700)),
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
        create: (context) => ProductDetailsCubit(),
        child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            ProductDetailsCubit cubit = ProductDetailsCubit.get(context);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.id.toString(),
                        ),
                         Stars(rating: product.rating != null && product.rating!.isNotEmpty
                            ? product.rating!.last.rating!.toDouble()
                            : 0,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    child: Text(
                      product.name.toString(),
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  CarouselSlider(
                    items: GlobalVariables.carouselImages.map((i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height *
                              0.3, // Use dynamic height
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.3,
                      // Use dynamic height
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                      text: TextSpan(
                          text: "Deal Price: ",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                                text: "\$${product.price}",
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ]),
                    ),
                  ),
                  Text(product.description.toString()),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        onTap: () {},
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: GlobalVariables.secondaryColor,
                        text: 'Buy Now',
                        style: const TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomButton(
                        onTap: () {
                          if (kDebugMode) {
                            print(product.id);
                          }
                          cubit.addTOCart(context: context, id: product.id.toString());
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: const Color.fromRGBO(254, 216, 19, 1),
                        text: 'Add to Cart',
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      "Rate the product",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: GlobalVariables.secondaryColor,
                          ),
                      onRatingUpdate: (rating) {
                        cubit.rateProduct(
                            context: context, product: product, rating: rating);
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
