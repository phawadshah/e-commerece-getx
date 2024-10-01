import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/categories/data/repositories/category_repository.dart';
import 'package:shop/app/modules/categories/data/models/category.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../../../utils/mixins/loading_mixin.dart';

class CategoriesController extends GetxController with LoadingMixin {
  static CategoriesController get to => Get.find<CategoriesController>();
  final CategoryRepository _categoryRepository;
  CategoriesController({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final RxBool hasError = false.obs;
  final Rx<String> error = ''.obs;

  void init() async {
    categories.clear();
    await executeWithLoading(
      () => _fetchAllCategories(),
    );
  }

  void onRetry() async {
    hasError(false);
    error('');
    await executeWithLoading(
      delay: const Duration(milliseconds: 700),
      () => _fetchAllCategories(),
    );
  }

  Future _fetchAllCategories() async {
    final results = await _categoryRepository.getCategories();
    results.fold((e) {
      hasError(true);
      error(e.toString());
    }, (results) {
      categories.value = results;
    });
  }

  void onCategoryTab(CategoryModel category) {
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
