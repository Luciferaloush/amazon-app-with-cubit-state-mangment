import 'dart:io';

import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  const SingleProduct({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
            padding: const EdgeInsets.all(2),
            child: Image.network('$image', fit: BoxFit.fitHeight, width: 180,

              // errorBuilder: (context, error, stackTrace) {
              //   return const Icon(Icons.error, color: Colors.red);
              // },
            )),
      ),
    );
  }
}
