import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/bottom.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/modules/product_details/presentation/widgets/page_view.dart';
import 'package:shop/app/modules/product_details/presentation/widgets/rating.dart';
import 'package:shop/app/modules/product_details/presentation/widgets/review_widget.dart';
import 'package:shop/app/utils/helper.dart';

import '../../../common/widgets/button.dart';
import '../../../common/widgets/error.dart';
import 'product_details_controller.dart';

class ProductDetailsPage extends GetView<ProductDetailsController> {
  final String uniqueTag;

  @override
  String get tag => uniqueTag;
  ProductDetailsPage({
    super.key,
    required int navigationId,
    required this.uniqueTag,
  }) {
    controller.navigationId = navigationId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.hasError.value) {
          return const KEmptyWidget();
        }
        return KBottomWidget(
          child: SizedBox(
            width: Get.width,
            height: 50,
            child: Obx(
              () => KButton(
                title: 'Add To Cart',
                onTap: controller.onAddToCartTap,
                state: controller.state,
              ),
            ),
          ),
        );
      }),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    if (controller.hasError.value) {
      return KErrorWidget(
        error: controller.error.value,
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticleSpace(10),
            _buildBrand(),
            Text(
              controller.product.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            addVerticleSpace(4),
            Rating(product: controller.product),
            KPageView(
              images: controller.product.images,
              pageController: controller.pageController,
              price: controller.product.price,
              discountPrice: controller.product.discountPercentage,
            ),
            addVerticleSpace(4),
            const Text(
              "Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            addVerticleSpace(4),
            Text(
              controller.product.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            controller.product.reviews.isEmpty
                ? const KEmptyWidget()
                : ReviewWidget(reviews: controller.product.reviews),
          ],
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return controller.product.brand == null
        ? const KEmptyWidget()
        : Column(
            children: [
              Text(
                controller.product.brand ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              addVerticleSpace(4),
            ],
          );
  }
}
