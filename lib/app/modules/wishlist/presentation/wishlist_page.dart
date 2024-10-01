import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/common/widgets/product.dart';

import 'wishlist_controller.dart';

class WishlistPage extends GetView<WishlistController> {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
        ),
        body: Obx(() => _buildView()));
  }

  Widget _buildView() {
    if (controller.hasError.value) {
      return KErrorWidget(
        error: controller.error.value,
        onRetry: controller.onRetry,
      );
    } else if (controller.productIds.isEmpty) {
      return const KEmptyWidget(title: "No Items in Wishlist");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: GridView.builder(
        itemCount: controller.wishlist.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          mainAxisExtent: 290,
        ),
        itemBuilder: (_, index) => KProductCard(
          product: controller.wishlist[index],
          showDelete: true,
          onIconTap: () {
            controller.onDeleteTap(controller.wishlist[index]);
          },
        ),
      ),
    );
  }
}
