
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/features/address/cubit/address_cubit.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../../utils/constants/global_variables.dart';

class AddressScreen extends StatelessWidget {
  static const String routeName = "/address";
  final List<PaymentItem> paymentItem = [];
 final String totalPrice;
 final List<Cart> cart;

  AddressScreen({super.key,  required this.totalPrice, required this.cart,});

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
          title: InkWell(
            onTap: () => Navigator.pop(context),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => AddressCubit(),
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = AddressCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "address",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Form(
                      key: cubit.addressFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: cubit.flat,
                            hintText: "Flat, House no Building",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: cubit.areaStreet,
                            hintText: "Area, Street",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: cubit.pinCode,
                            hintText: "PineCode",
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextField(
                            controller: cubit.townCity,
                            hintText: "TownCity",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              onTap: () {
                                cubit.placeOrder(
                                  cart: cart,
                                  totalPrice: totalPrice,context: context,

                                );
                              },
                              width: GlobalVariables.width(context),
                              height: 55,
                              color: Colors.white70,
                              colorBorder: Colors.black87,
                              widthBorder: 1.5,
                              text: "By Product",
                              style: const TextStyle(fontSize: 16))

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
