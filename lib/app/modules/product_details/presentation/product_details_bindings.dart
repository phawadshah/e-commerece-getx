import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shop/app/modules/product_details/presentation/product_details_controller.dart';
import 'package:shop/app/core/configs/user_config.dart';

class ProductDetailsBindings extends Bindings {
  final String uniqueTag;
  ProductDetailsBindings({required this.uniqueTag});
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailsController>(
      () => ProductDetailsController(userConfig: Get.find<UserConfig>()),
      tag: uniqueTag,
    );
  }
}
