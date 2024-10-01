import 'package:get/route_manager.dart';
import 'package:shop/app/modules/authentication/login/presentation/login_bindings.dart';
import 'package:shop/app/modules/authentication/login/presentation/login_page.dart';
import 'package:shop/app/modules/authentication/sign_up/presentation/sign_up_bindings.dart';
import 'package:shop/app/modules/authentication/sign_up/presentation/sign_up_page.dart';
import 'package:shop/app/modules/base/base_bindings.dart';
import 'package:shop/app/modules/base/base_page.dart';
import 'package:shop/app/modules/categories/presentation/categories_bindings.dart';
import 'package:shop/app/modules/home/presentation/home_bindings.dart';
import 'package:shop/app/modules/search/presentation/search_bindings.dart';
import 'package:shop/app/modules/splash/splash_bindings.dart';
import 'package:shop/app/modules/splash/splash_page.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_bindings.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_page.dart';

import '../../modules/cart/presentation/cart_bindings.dart';
import '../../modules/profile/presentation/profile_bindings.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names

  static List<GetPage> pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.BASE,
      page: () => const BasePage(),
      bindings: [
        BaseBindings(),
        HomeBindings(),
        SearchBindings(),
        CategoriesBindings(),
        CartBindings(),
        ProfileBindings(),
      ],
    ),
    GetPage(
      name: Routes.WISHLIST,
      page: () => const WishlistPage(),
      binding: WishlistBindings(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => const SignUpPage(),
      binding: SignUpBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBindings(),
      transition: Transition.fadeIn,
    ),
  ];
}
