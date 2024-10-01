import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/previously_viewed_controller.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/utils/constants/url_builder.dart';
import 'package:shop/app/utils/services/cart_service.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/utils/services/env_service.dart';
import 'package:shop/app/utils/services/internet_conectivity.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';
import 'package:shop/app/utils/services/previously_viewed_service.dart';
import 'package:shop/app/utils/services/wishlist_service.dart';

import '../../utils/services/auth_service.dart';
import '../../utils/services/user_service.dart';
import '../controllers.dart/auth_controller.dart';
import '../controllers.dart/user_controller.dart';

class InitialBindings {
  Future<void> initInitials() async {
    /// ======== Services ==========
    Get.put<EnvService>(EnvService());
    Get.put<ApiBaseHelper>(ApiBaseHelper());
    Get.put<UrlBuilder>(UrlBuilder(envService: Get.find<EnvService>()));
    Get.put<LocalStorageService>(LocalStorageService());
    Get.put<Internet>(Internet());
    Get.put<AuthService>(AuthService());
    Get.put<UserService>(UserService());
    Get.put<WishlistService>(WishlistService());
    Get.put<PreviouslyViewedService>(PreviouslyViewedService());
    Get.put<CartService>(
        CartService(localStorageService: Get.find<LocalStorageService>()));

    /// ======== CONTROLLERS ==========
    Get.put<AuthController>(
      AuthController(authService: Get.find<AuthService>()),
      permanent: true,
    );
    Get.put<UserController>(
      UserController(
        userService: Get.find<UserService>(),
        authController: Get.find<AuthController>(),
      ),
      permanent: true,
    );

    /// ======== User Config ==========
    Get.lazyPut<UserConfig>(
      () => UserConfig(
        authController: Get.find<AuthController>(),
        wishlistService: Get.find<WishlistService>(),
        cartService: Get.find<CartService>(),
      ),
    );

    /// ======== PREVIOUSLY VIEWED ITEMS   ==========
    Get.lazyPut<PreviouslyViewedController>(
      () => PreviouslyViewedController(
        authController: Get.find<AuthController>(),
        previouslyViewedService: Get.find<PreviouslyViewedService>(),
      ),
    );
  }
}
