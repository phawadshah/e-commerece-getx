import 'package:get/route_manager.dart';
import 'package:shop/app/modules/base/base_bindings.dart';
import 'package:shop/app/modules/base/base_page.dart';
import 'package:shop/app/modules/cart/presentation/cart_bindings.dart';
import 'package:shop/app/modules/categories/presentation/categories_bindings.dart';
import 'package:shop/app/modules/home/presentation/home_bindings.dart';
import 'package:shop/app/modules/search/presentation/search_bindings.dart';
import 'package:shop/app/modules/splash/splash_bindings.dart';
import 'package:shop/app/modules/splash/splash_page.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_bindings.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_page.dart';

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
      ],
    ),
    GetPage(
      name: Routes.WISHLIST,
      page: () => const WishlistPage(),
      binding: WishlistBindings(),
    ),
  ];
}
