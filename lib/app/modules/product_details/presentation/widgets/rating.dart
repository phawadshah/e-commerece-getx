import 'package:flutter/material.dart';

import '../../../../utils/helper.dart';
import '../../../home/data/models/product.dart';
import 'rating_bar.dart';

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (product.rating as double).toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        addHorizontalSpace(8),
        CustomRatingBar(
          value: product.rating,
        ),
        addHorizontalSpace(8),
        Text(
          "( ${product.reviews.length.toString()} )",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
