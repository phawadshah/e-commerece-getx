import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
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
import '../../utils/helpers/size_helper.dart';
import '../../utils/services/auth_service.dart';
import '../../utils/services/user_service.dart';
import '../controllers.dart/auth_controller.dart';
import '../controllers.dart/user_controller.dart';

class AppInitialBindings extends Bindings {
  @override
  void dependencies() async {
    /// ======== Services ==========
    Get.put<Global>(Global());
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
    Get.lazyPut<SizeManager>(() => SizeManager(), fenix: true);

    /// ======== CONTROLLERS ==========
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<UserController>(
      () => UserController(
        userService: Get.find<UserService>(),
        authController: Get.find<AuthController>(),
      ),
      fenix: true,
    );

    /// ======== User Config ==========
    Get.lazyPut<UserConfig>(
      () => UserConfig(
        authController: Get.find<AuthController>(),
        wishlistService: Get.find<WishlistService>(),
        cartService: Get.find<CartService>(),
        localStorageService: Get.find<LocalStorageService>(),
      ),
    );

    /// ======== PREVIOUSLY VIEWED ITEMS   ==========
    Get.lazyPut<PreviouslyViewedController>(
      () => PreviouslyViewedController(
        authController: Get.find<AuthController>(),
        previouslyViewedService: Get.find<PreviouslyViewedService>(),
      ),
      fenix: true,
    );
  }
}
