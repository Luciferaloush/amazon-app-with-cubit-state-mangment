import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:amazon_clone/features/admin/cubit/admin_screen_cubit.dart';
import 'package:amazon_clone/features/admin/screens/drop_down_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/global_variables.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  static const routeName = '/add-product';

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
            "Add Product",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_outlined)),
          centerTitle: true,
        ),
      ),
      body: BlocProvider(
        create: (context) => AddProductCubit(),
        child: BlocConsumer<AddProductCubit, AddProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            AddProductCubit cubit = AddProductCubit.get(context);
            return Form(
              key: cubit.addProduct,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      if(cubit.images.isNotEmpty)
                        CarouselSlider(
                          items: cubit.images.map((i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height *
                                    0.3, // Use dynamic height
                              )
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height:
                            MediaQuery.of(context).size.height * 0.3,
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
                        )
                          else GestureDetector(
                              onTap: () {
                                cubit.selectImage();
                              },
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.folder_open,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Select Product images",
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        controller: cubit.productName,
                        hintText: "Product Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: cubit.description,
                        hintText: "Description",
                        maxLines: 7,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: cubit.price,
                        hintText: "Price",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            showDrop(context),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          onTap: () {
                            if(cubit.addProduct.currentState!.validate()){
                              cubit.sellProduct(context: context);
                            }return;
                          },
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: GlobalVariables.secondaryColor,
                          text: "sell",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ))
                    ]),
                  )),
            );
          },
        ),
      ),
    );
  }
}
