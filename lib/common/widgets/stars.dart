import 'package:amazon_clone/utils/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) =>
          const Icon(Icons.star, color: GlobalVariables.secondaryColor),
      itemCount: 5,
      itemSize: 15,
      rating: rating,
      direction: Axis.horizontal,
    );
  }
}
