import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/product.dart';
import 'package:shop/app/modules/home/data/models/product.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.products,
    this.onTap,
  });

  final List<Product> products;
  final Function(Product)? onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 15,
        childAspectRatio: 1.0,
        mainAxisExtent: 280,
      ),
      itemBuilder: (_, index) {
        return KProductCard(
          aspectRatio: 1,
          product: products[index],
          onTap: () {
            onTap?.call(products[index]);
          },
        );
      },
    );
  }
}
