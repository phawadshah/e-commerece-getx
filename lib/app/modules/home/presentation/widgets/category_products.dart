import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/product.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/helper.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    super.key,
    required this.categoryTitle,
    required this.products,
    this.onTap,
    this.onFavTap,
    required this.wislist,
  });

  final String categoryTitle;
  final RxList<int> wislist;

  final List<Product> products;
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
              Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              addVerticleSpace(10),
              SizedBox(
                height: 230,
                child: ListView.separated(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Obx(
                      () => KProductCard(
                        width: 130,
                        product: Product.copyWith(
                          product,
                          isFav: wislist.any((w) => w == product.id),
                        ),
                        onTap: () {
                          onTap?.call(product);
                        },
                        onIconTap: () {
                          onFavTap?.call(product);
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
  }
}
