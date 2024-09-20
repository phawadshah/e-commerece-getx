import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/button.dart';
import 'package:shop/app/utils/helper.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
    required this.title,
    required this.total,
    this.onViewCartTap,
    this.onContinueShoppingTap,
  });

  final String title;
  final double total;
  final Function()? onViewCartTap;
  final Function()? onContinueShoppingTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white, size: 30),
                ),
              ),
              addHorizontalSpace(15),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Added to cart',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ))
            ],
          ),
          addVerticleSpace(10),
          Container(
            color: Colors.grey.shade100,
            child: Row(
              children: [
                const Text(
                  "Cart Total",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  total.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          addVerticleSpace(15),
          SizedBox(
            width: Get.width,
            height: 45,
            child: KButton(title: "View Cart", onTap: onViewCartTap),
          ),
          addVerticleSpace(15),
          SizedBox(
            width: Get.width,
            height: 45,
            child: KOutlineButton(
                title: "Continue Shopping", onTap: onContinueShoppingTap),
          ),
          addVerticleSpace(20),
        ],
      ),
    );
  }
}
