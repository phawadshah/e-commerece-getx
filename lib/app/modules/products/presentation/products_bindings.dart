import 'package:get/get.dart';
import 'package:shop/app/modules/products/data/repository/products_repository.dart';
import 'package:shop/app/modules/products/presentation/products_controller.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';
import 'package:shop/app/utils/services/env_services.dart';

class ProductsBindings extends Bindings {
  final String uniqueTag;
  ProductsBindings({required this.uniqueTag});
  @override
  void dependencies() {
    Get.lazyPut<ProductsRepository>(
      () => ProductsRepository(
        apiBaseHelper: ApiBaseHelper(),
        urlBuilder: UrlBuilder(
          envService: Get.find<EnvServices>(),
        ),
      ),
    );
    Get.put<ProductsController>(
      ProductsController(productsRepository: Get.find<ProductsRepository>()),
      tag: uniqueTag,
    );
  }
}
