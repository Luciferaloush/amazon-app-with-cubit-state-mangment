import 'package:amazon_clone/features/admin/add_product_cubit/add_product_cubit.dart';
import 'package:amazon_clone/features/auth/cubit/auth_screen_cubit.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../utils/constants/global_variables.dart';
import '../../search/cubit/search_cubit.dart';
import '../../search/screen/search_screen.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '/order-details';

   const OrderScreen({super.key, required this.order});

  final Order order;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentStep = 0;
@override
 void initState() {
  super.initState();
  currentStep = widget.order.status;

}

  @override
  Widget build(BuildContext context) {
//    final user = context.read<AuthScreenCubit>().userType; // Adjust as needed
  final user = BlocProvider.of<AuthScreenCubit>(context).getUserType();
  print("User $user");

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(),
        ),
      ],
      child: Scaffold(
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
                      child: BlocConsumer<SearchCubit, SearchState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          final searchCubit = SearchCubit.get(context);
                          return TextFormField(
                            onFieldSubmitted: (String query) {
                              searchCubit.searchProducts(query);
                              Navigator.pushNamed(context, SearchScreen.routeName,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'View order details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Date:      ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderAt),
                      )}'),
                      Text('Order ID:          ${widget.order.id}'),
                      Text('Order Total:      \$${widget.order.totalPrice}'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Purchase Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.order.products.length; i++)
                        Row(
                          children: [
                            Image.asset(
                              "assets/ss.jpg",
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    // Check if quantity exists for the current product index
                                    'Qty: ${widget.order.quantity.length > i ? widget.order.quantity[i] : 'N/A'}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tracking',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Stepper(
                    currentStep: currentStep,
                    controlsBuilder: (context, details) {
                      if (user == 'Admin') {
                        return BlocConsumer<AddProductCubit, AddProductState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    final cubit = AddProductCubit.get(context);
    return CustomButton(
                          text: 'Done',
                          height:35,
                          style: TextStyle(fontSize: 16),color: GlobalVariables.secondaryColor,
                          width: GlobalVariables.width(context)/2,
                          onTap: () {
                            cubit.changeOrderStatus(
                                context: context,
                                status: details.currentStep,
                                order: widget.order
                            );
                            setState(() {
                              currentStep +=1;
                            });
                          }
                        );
  },
);
                      }
                      return const SizedBox();
                    },
                    steps: [
                      Step(
                        title: const Text('Pending'),
                        content: const Text(
                          'Your order is yet to be delivered',
                        ),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Completed'),
                        content: const Text(
                          'Your order has been delivered, you are yet to sign.',
                        ),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Received'),
                        content: const Text(
                          'Your order has been delivered and signed by you.',
                        ),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                      Step(
                        title: const Text('Delivered'),
                        content: const Text(
                          'Your order has been delivered and signed by you!',
                        ),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
