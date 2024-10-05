import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/browse_widget.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/common/widgets/loading.dart';
import 'package:shop/app/modules/cart/presentation/widgets/cart_widget.dart';
import 'package:shop/app/utils/constants/enums.dart';
import 'cart_controller.dart';
import 'widgets/bottom_widget.dart';
import 'widgets/empty_widget.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      bottomNavigationBar: Obx(
        () => controller.cartItems.isNotEmpty &&
                !controller.hasError.value &&
                controller.state == ControllerState.IDLE
            ? BottomWidget(
                total: controller.total.value,
              )
            : const KEmptyWidget(),
      ),
      body: Obx(() => _buildView()),
    );
  }

  Widget _buildView() {
    if (controller.hasError.value) {
      return KErrorWidget(
        error: controller.error.value,
        onRetry: controller.onRetry,
      );
    } else if (controller.state == ControllerState.LOADING) {
      return const KLoadingWidget();
    } else if (controller.cartItemIds.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmptyCartWidget(),
          controller.previouslyViewedItems.isNotEmpty
              ? KBrowseWidget(
                  products: controller.previouslyViewedItems.value,
                  wislist: controller.wishListItems,
                  onTap: (product) {},
                  onFavTap: (p) {},
                )
              : const SizedBox.shrink(),
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: [
            CartItems(
              products: controller.cartItems.value,
              onRemovetap: controller.onRemoveTap,
              onDecrementtap: controller.onDecrementtap,
              onAddTap: controller.onAddTap,
            ),
          ],
        ),
      );
    }
  }
}
