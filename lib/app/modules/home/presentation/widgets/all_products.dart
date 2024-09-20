import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/product.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/helper.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({
    super.key,
    required this.products,
    this.onTap,
    this.onFavTap,
    this.wislist,
  });

  final List<Product> products;
  final List<int>? wislist;
  final Function(Product)? onTap;
  final Function(Product)? onFavTap;

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const KEmptyWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticleSpace(20),
              const Text(
                "All Products",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticleSpace(10),
              GridView.builder(
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.0,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (_, index) {
                  final product = products[index];
                  product.isFav = wislist!.any((w) => w == product.id);

                  return KProductCard(
                    aspectRatio: 1,
                    product: product,
                    onTap: () {
                      onTap?.call(product);
                    },
                    onIconTap: () {
                      onFavTap?.call(product);
                    },
                  );
                },
              ),
            ],
          );
  }
}
