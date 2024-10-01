import 'package:get/get.dart';
import 'package:shop/app/modules/categories/data/repositories/category_repository.dart';
import 'package:shop/app/modules/categories/presentation/categories_controller.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

class CategoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryRepository>(
      () => CategoryRepository(
        apiBaseHelper: Get.find<ApiBaseHelper>(),
        urlBuilder: Get.find<UrlBuilder>(),
      ),
    );
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(
        categoryRepository: Get.find<CategoryRepository>(),
      ),
    );
  }
}
