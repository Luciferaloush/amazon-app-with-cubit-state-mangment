import 'package:amazon_clone/features/cart/cubit/cart_cubit.dart';
import 'package:amazon_clone/features/product_details/cubit/product_details_cubit.dart';
import 'package:amazon_clone/model/cart.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({super.key, required this.product});

  final Cart product;

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.asset(widget.product.product!.images[0].toString(),
                  fit: BoxFit.fitWidth, height: 135, width: 135),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.product.product!.name.toString(),
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "\$ ${widget.product.product!.price}",
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      "Eligible for FREE Shopping",
                      maxLines: 2,
                      style: TextStyle(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 235,
                    child: Text(
                      "In stock",
                      maxLines: 2,
                      style: TextStyle(color: Colors.green.shade400),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        final cubit = CartCubit.get(context);
                        cubit.removeFromCart(
                            context: context,
                            id: widget.product.product!.id.toString());
                        setState(() {
                          if (quantity > 0) {
                            quantity--;
                          }
                        });
                      },
                      child: const Icon(Icons.remove, size: 18),
                    ),
                    Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(quantity.toString()),
                    ),
                    InkWell(
                      onTap: () {
                        final cubit = ProductDetailsCubit.get(context);
                        cubit.addTOCart(
                            context: context,
                            id: widget.product.product!.id.toString());
                        setState(() {
                          quantity++;
                        });
                      },
                      child: const Icon(Icons.add, size: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
