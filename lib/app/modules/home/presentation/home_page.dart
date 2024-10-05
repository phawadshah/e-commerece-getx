import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/modules/home/presentation/widgets/all_products.dart';
import 'package:shop/app/modules/home/presentation/widgets/category_products.dart';
import 'package:shop/app/utils/helper.dart';
import '../../../common/widgets/loading.dart';
import '../../../utils/constants/enums.dart';
import 'home_controller.dart';
import 'widgets/category.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        actions: [
          IconButton(
            onPressed: controller.onFavTap,
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: Obx(() => _buildView()),
    );
  }

  Widget _buildView() {
    if (controller.hasError.value) {
      return KErrorWidget(
        error: controller.error.value,
      );
    } else if (controller.state == ControllerState.LOADING) {
      return const KLoadingWidget();
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Categories Widget

          Obx(
            () => controller.categories.isEmpty
                ? const KEmptyWidget()
                : CategoriesWidget(
                    categories: controller.categories,
                    onTap: controller.onCategoryTap,
                  ),
          ),

          Obx(
            () => Column(
              children: controller.products
                  .map(
                    (itemList) => CategoryProducts(
                      categoryTitle:
                          itemList.first.category.capitalizeFirst.toString(),
                      products: itemList,
                      wislist: controller.wishList,
                      onTap: controller.onProductTap,
                      onFavTap: controller.onHeartTap,
                    ),
                  )
                  .toList(),
            ),
          ),

          /// All Products Widget
          Obx(
            () => AllProducts(
              products: controller.allProducts.value,
              wislist: controller.wishList,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),
          addVerticleSpace(20),
        ],
      ),
    );
  }
}
