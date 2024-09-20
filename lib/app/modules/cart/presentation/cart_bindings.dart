import 'package:get/get.dart';
import 'package:shop/app/modules/cart/presentation/cart_controller.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

import '../../../utils/services/env_services.dart';
import '../repositories/cart_repository.dart';

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(() => CartRepository(
          apiBaseHelper: ApiBaseHelper(),
          urlBuilder: UrlBuilder(
            envService: Get.find<EnvServices>(),
          ),
        ));
    Get.lazyPut<CartController>(() => CartController(
        userConfig: Get.find<UserConfig>(),
        cartRepository: Get.find<CartRepository>()));
  }
}
