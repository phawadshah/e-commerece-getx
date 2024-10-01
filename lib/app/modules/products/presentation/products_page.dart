import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/modules/products/presentation/products_controller.dart';
import 'package:shop/app/utils/constants/enums.dart';

import '../../../common/widgets/loading.dart';
import 'widgets/all_products.dart';

class ProductsPage extends GetView<ProductsController> {
  final String uniqueTag;
  @override
  String get tag => uniqueTag;

  ProductsPage({
    super.key,
    required this.uniqueTag,
    required int navigationId,
  }) {
    controller.tag = uniqueTag;
    controller.navigationId = navigationId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.category.value)),
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
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: AllProducts(
        products: controller.products,
        onTap: controller.onProductTap,
      ),
    );
  }
}
