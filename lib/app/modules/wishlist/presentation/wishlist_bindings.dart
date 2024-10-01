import 'package:get/get.dart';
import 'package:shop/app/modules/wishlist/data/repositories/wishlist_repository.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

import '../../../utils/services/configs/user_config.dart';
import 'wishlist_controller.dart';

class WishlistBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistRepository>(
      () => WishlistRepository(
        apiBaseHelper: Get.find<ApiBaseHelper>(),
        urlBuilder: Get.find<UrlBuilder>(),
      ),
    );
    Get.lazyPut<WishlistController>(
      () => WishlistController(
        userConfig: Get.find<UserConfig>(),
        wishlistRepository: Get.find<WishlistRepository>(),
      ),
    );
  }
}
