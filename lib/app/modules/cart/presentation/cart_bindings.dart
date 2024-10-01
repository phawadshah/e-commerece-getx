import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/previously_viewed_controller.dart';
import 'package:shop/app/modules/cart/presentation/cart_controller.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

import '../data/repositories/cart_repository.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(
      () => CartRepository(
        apiBaseHelper: Get.find<ApiBaseHelper>(),
        urlBuilder: Get.find<UrlBuilder>(),
      ),
    );
    Get.lazyPut<CartController>(
      () => CartController(
        userConfig: Get.find<UserConfig>(),
        cartRepository: Get.find<CartRepository>(),
        previouslyViewedController: Get.find<PreviouslyViewedController>(),
      ),
    );
  }
}
