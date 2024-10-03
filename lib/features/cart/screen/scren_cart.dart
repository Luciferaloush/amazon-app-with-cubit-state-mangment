// import 'package:amazon_clone/common/loader_screen.dart';
// import 'package:amazon_clone/common/widgets/custom_button.dart';
// import 'package:amazon_clone/features/address/screen/address_screen.dart';
// import 'package:amazon_clone/features/cart/cubit/cart_cubit.dart';
// import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
// import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
// import 'package:amazon_clone/features/product_details/cubit/product_details_cubit.dart';
// import 'package:amazon_clone/features/screens/widgets/address_box.dart';
// import 'package:amazon_clone/model/product.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../utils/constants/global_variables.dart';
// import '../../search/cubit/search_cubit.dart';
// import '../../search/screen/search_screen.dart';
//
// class ScreenCart extends StatelessWidget {
//   const ScreenCart({super.key,});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) {
//               CartCubit cubit = CartCubit();
//               cubit.fetchCartU();
//               return cubit;
//             },
//           ),
//           BlocProvider(
//             create: (context) => SearchCubit(),
//           ),
//           BlocProvider(
//             create: (context) => ProductDetailsCubit(),
//           )
//         ],
//         child: Scaffold(
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: AppBar(
//               flexibleSpace: Container(
//                 decoration: const BoxDecoration(
//                     gradient: GlobalVariables.appBarGradient),
//               ),
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 42,
//                       margin: const EdgeInsets.only(left: 15),
//                       child: Material(
//                         borderRadius: BorderRadius.circular(7),
//                         elevation: 1,
//                         child: BlocConsumer<SearchCubit, SearchState>(
//                           listener: (context, state) {
//                             // TODO: implement listener
//                           },
//                           builder: (context, state) {
//                             final searchCubit = SearchCubit.get(context);
//                             return TextFormField(
//                               onFieldSubmitted: (String query) {
//                                 searchCubit.searchProducts(query);
//                                 Navigator.pushNamed(
//                                     context, SearchScreen.routeName,
//                                     arguments: query);
//                               },
//                               decoration: InputDecoration(
//                                   prefixIcon: InkWell(
//                                     onTap: () {},
//                                     child: const Padding(
//                                       padding: EdgeInsets.only(left: 6),
//                                       child: Icon(Icons.search_outlined,
//                                           color: Colors.black, size: 23),
//                                     ),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   contentPadding:
//                                   const EdgeInsets.only(top: 10),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(7),
//                                       borderSide: BorderSide.none),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(7),
//                                     borderSide: const BorderSide(
//                                         color: Colors.black38, width: 1),
//                                   ),
//                                   hintText: "Search Amazon.in",
//                                   hintStyle: const TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w700)),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.transparent,
//                     height: 42,
//                     margin: const EdgeInsets.symmetric(horizontal: 10),
//                     child: const Icon(Icons.mic, color: Colors.black, size: 24),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           body: BlocConsumer<CartCubit, CartState>(
//             listener: (context, state) {
//               // TODO: implement listener
//             },
//             builder: (context, state) {
//               final cubit = CartCubit.get(context);
//               return Stack(
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         AddressBox(),
//                         CartSubTotal(subtotal: cubit.total),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CustomButton(
//                               onTap: () {
//                                 //Navigator.pushNamed(context, AddressScreen.routeName,arguments: state.listProducts);
//                               },
//                               width: MediaQuery.of(context).size.width,
//                               height: 40,
//                               color: Colors.yellow,
//                               text:
//                               "Product to buy ${cubit.listProducts.length} items",
//                               style: TextStyle(fontSize: 12)),
//                         ),
//                         SizedBox(height: 15,),
//                         Container(color: Colors.black.withOpacity(0.08),height: 1,),
//                         SizedBox(height: 5,),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: cubit.cart.length,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final cart = cubit.cart[index];
//                             return Column(
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.symmetric(horizontal: 10.0),
//                                   child: Row(
//                                     children: [
//                                       Image.asset("assets/ss.jpg",
//                                           fit: BoxFit.fitWidth, height: 135, width: 135),
//                                       Column(
//                                         children: [
//                                           Container(
//                                             width: 235,
//                                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                                             child: Text(
//                                               cart.cart![index].product!.name.toString(),
//                                               maxLines: 2,
//                                               style: const TextStyle(fontSize: 16),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: 235,
//                                             padding: const EdgeInsets.only(left: 10, top: 5),
//                                             child: Text(
//                                               "\$ ${ cart.cart![index].product!.price}",
//                                               maxLines: 2,
//                                               style: const TextStyle(
//                                                   fontSize: 20, fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                           Container(
//                                             width: 235,
//                                             padding: const EdgeInsets.only(left: 10, top: 5),
//                                             child: const Text(
//                                               "Eligible for FREE Shopping",
//                                               maxLines: 2,
//                                               style: TextStyle(),
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: const EdgeInsets.only(left: 10, top: 5),
//                                             width: 235,
//                                             child: Text(
//                                               "In stock",
//                                               maxLines: 2,
//                                               style: TextStyle(color: Colors.green.shade400),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.black12, width: 1.5),
//                                           borderRadius: BorderRadius.circular(5),
//                                           color: Colors.black12,
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 final cubit = CartCubit.get(context);
//                                                 cubit.removeFromCart(
//                                                     context: context, id:  cart.cart![index].product!.id.toString());
//                                                 // setState(() {
//                                                 //   if (quantity > 0) {
//                                                 //     quantity--;
//                                                 //   }
//                                                 // });
//                                               },
//                                               child: Container(
//                                                 child: const Icon(Icons.remove, size: 18),
//                                               ),
//                                             ),
//                                             Container(
//                                               width: 35,
//                                               height: 32,
//                                               alignment: Alignment.center,
//                                               child: Text(cart.cart![index].quantity.toString()),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 final cubit = ProductDetailsCubit.get(context);
//                                                 cubit.addTOCart(
//                                                     context: context, id:  cart.cart![index].product!.id.toString());
//                                                 // setState(() {
//                                                 //   quantity++;
//                                                 // });
//                                               },
//                                               child: Container(
//                                                 child: const Icon(Icons.add, size: 18),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//
//                           },)
//
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//
//             },
//           ),
//         ));
//   }
// }
