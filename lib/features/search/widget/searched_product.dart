import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.asset(
                "assets/ss.jpg",
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name.toString(),
                      maxLines: 2,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stars(
                        rating:
                            product.rating != null && product.rating!.isNotEmpty
                                ? product.rating!.last.rating!
                                    .toDouble() // الحصول على آخر تقييم
                                : 0,
                      )),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "\$ ${product.price}",
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      "Eligble for FREE Shopping",
                      maxLines: 2,
                      style: TextStyle(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    width: 235,
                    child: const Text(
                      "In stock",
                      maxLines: 2,
                      style: TextStyle(),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
