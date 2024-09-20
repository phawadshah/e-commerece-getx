import 'dart:developer';

import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/categories/data/repositories/category_repository.dart';
import 'package:shop/app/modules/categories/data/models/category.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../../../utils/mixins/loading_mixin.dart';

class CategoriesController extends GetxController with LoadingMixin {
  final CategoryRepository _categoryRepository;
  CategoriesController({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final RxBool hasError = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() async {
    await _fetchAllCategories();
    super.onInit();
  }

  void onRetry() async {
    hasError(false);
    error('');
    await _fetchAllCategories();
  }

  Future _fetchAllCategories() async {
    final results = await executeWithLoading(
        delay: const Duration(milliseconds: 700),
        () => _categoryRepository.getCategories());
    results.fold((e) {
      hasError(true);
      error(e.toString());
    }, (results) {
      categories.value = results;
    });
  }

  void onCategoryTab(CategoryModel category) {
    log("onCategoryTap: ${category.name}");
    Get.toNamed(
      Routes.PRODCUTS,
      id: categoriesNavigatioId,
      arguments: {
        "category": category,
        "tag": "${Routes.CATEGORIES}/${category.name}"
      },
    );
  }
}
