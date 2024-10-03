import 'package:amazon_clone/common/loader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';

class CartSubTotal extends StatefulWidget {
  const CartSubTotal({super.key, required this.subtotal});
  final double subtotal;

  @override
  State<CartSubTotal> createState() => _CartSubTotalState();
}

class _CartSubTotalState extends State<CartSubTotal> {
  @override
  Widget build(BuildContext context) {

      return Container(
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "Subtotal: ${widget.subtotal}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }
}
