import 'package:flutter/material.dart';

import 'package:shop/app/common/widgets/image.dart';

import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/helper.dart';

class KProductCard extends StatelessWidget {
  const KProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onIconTap,
    this.width = 120,
    this.aspectRatio = .97,
    this.showDelete = false,
  });

  final Product product;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;
  final double width, aspectRatio;

  final bool showDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio,
                  child: KImage(src: product.thumbnail),
                ),
                showDelete ? _buildDeleteIcon() : _buildFavIcon(),
              ],
            ),
            addVerticleSpace(4),
            Text(
              product.brand ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            addVerticleSpace(4),
            Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            addVerticleSpace(6),
            FittedBox(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${product.price.toString()}  ',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: product.discountPercentage.toString(),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildDeleteIcon() {
    return Positioned(
      right: 0,
      top: 0,
      child: GestureDetector(
        onTap: onIconTap,
        child: const Icon(
          Icons.delete,
          color: Colors.black38,
          size: 20,
        ),
      ),
    );
  }

  Positioned _buildFavIcon() {
    return Positioned(
      right: 0,
      top: 0,
      child: GestureDetector(
        onTap: onIconTap,
        child: Icon(
          product.isFav ? Icons.favorite : Icons.favorite_outline,
          color: product.isFav ? Colors.red : Colors.black38,
          size: 20,
        ),
      ),
    );
  }
}
