import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/modules/categories/presentation/categories_controller.dart';
import 'package:shop/app/modules/categories/presentation/widgets/category_widget.dart';

import '../../../common/widgets/loading.dart';
import '../../../utils/constants/enums.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
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
      return const Center(
        child: KLoadingWidget(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: CategoryWidget(
        categories: controller.categories.value,
        onTap: controller.onCategoryTab,
      ),
    );
  }
}
