import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/widgets/image.dart';

class KPageView extends StatelessWidget {
  const KPageView({
    super.key,
    required this.images,
    required this.pageController,
    required this.price,
    required this.discountPrice,
  });

  final List<String> images;
  final PageController pageController;
  final double price;
  final double discountPrice;

  @override
  Widget build(BuildContext context) {
    final count = images.length;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView(
                controller: pageController,
                children: images
                    .map((image) => KImage(
                          src: image,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
              ),
            ),
            count < 2
                ? const KEmptyWidget()
                : SmoothPageIndicator(
                    controller: pageController,
                    count: count,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 10,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                    ),
                  )
          ],
        ),
        Positioned(
            top: 20,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ ${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  "\$ ${discountPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
