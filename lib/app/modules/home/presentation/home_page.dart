import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/modules/home/presentation/widgets/all_products.dart';
import 'package:shop/app/modules/home/presentation/widgets/category_products.dart';
import 'package:shop/app/utils/helper.dart';

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
      body: _buildView(),
    );
  }

  Widget _buildView() {
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

          /// Laptops Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Laptops",
              products: controller.laptops.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// Beauty Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Beauty",
              products: controller.beauty.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// SkinCare Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Skin Care",
              products: controller.skinCare.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// Men Watches Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Men Watches",
              products: controller.menWatches.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// Furniture Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Furniture",
              products: controller.furniture.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// Shoes Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Shoes",
              products: controller.shoes.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// Home Decor Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Home Decor",
              products: controller.homeDecor.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// groceries Widget
          Obx(
            () => CategoryProducts(
              categoryTitle: "Groceries",
              products: controller.groceries.value,
              wislist: controller.wishList.value,
              onTap: controller.onProductTap,
              onFavTap: controller.onHeartTap,
            ),
          ),

          /// All Products Widget
          Obx(
            () => AllProducts(
              products: controller.allProducts.value,
              wislist: controller.wishList.value,
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
