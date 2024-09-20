import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/image.dart';
import 'package:shop/app/modules/home/data/models/product.dart';

import '../../../../utils/helper.dart';
import '../../data/cartProductModel.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.products,
    this.onRemovetap,
    this.onAddTap,
    this.onDecrementtap,
  });

  final List<CartProductModel> products;
  final Function(Product)? onRemovetap;
  final Function(Product)? onDecrementtap;
  final Function(Product)? onAddTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: products.length,
          separatorBuilder: (context, index) {
            return addVerticleSpace(10);
          },
          itemBuilder: (_, index) {
            final product = products[index].product;
            return Card(
              shadowColor: Colors.blue.shade100,
              elevation: .8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            maxWidth: 100,
                            minWidth: 90,
                          ),
                          child: AspectRatio(
                            aspectRatio: .79,
                            child: KImage(
                              src: product.thumbnail,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        addHorizontalSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    product.brand ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      onRemovetap?.call(product);
                                    },
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  ),
                                  addHorizontalSpace(10),
                                ],
                              ),
                              addVerticleSpace(4),
                              Text(
                                product.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              addVerticleSpace(4),
                              FittedBox(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'AED ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${product.price.toString()} ',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: product.discountPercentage
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Only ${product.stock.toString()} left in stock",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      onDecrementtap?.call(product);
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 18,
                                    ),
                                  ),
                                  addHorizontalSpace(8),
                                  Text(
                                    products[index].quantity.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  addHorizontalSpace(8),
                                  GestureDetector(
                                    onTap: () {
                                      onAddTap?.call(product);
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 18,
                                    ),
                                  ),
                                  addHorizontalSpace(10),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
