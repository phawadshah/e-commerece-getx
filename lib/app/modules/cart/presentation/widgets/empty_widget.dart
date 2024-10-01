import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/utils/helper.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.shopping_cart_outlined,
          size: 100,
        ),
        addVerticleSpace(20),
        const SizedBox(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "No itmes in the cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        addVerticleSpace(Get.height * 0.1)
      ],
    );
  }
}
