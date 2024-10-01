import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/product_details/presentation/product_details_bindings.dart';
import 'package:shop/app/modules/product_details/presentation/product_details_page.dart';
import 'package:shop/app/modules/products/presentation/products_bindings.dart';
import 'package:shop/app/modules/products/presentation/products_page.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_bindings.dart';
import 'package:shop/app/modules/wishlist/presentation/wishlist_page.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../../modules/home/presentation/home_bindings.dart';
import '../../modules/home/presentation/home_page.dart';

class HomeNavigator extends StatelessWidget implements CustomNavBarScreen {
  final GlobalKey<NavigatorState>? _navigatorKey;
  const HomeNavigator(
      {super.key, required GlobalKey<NavigatorState>? navigatorKey})
      : _navigatorKey = navigatorKey;

  @override
  Widget build(BuildContext context) {
    return screen;
  }

  @override
  RouteAndNavigatorSettings? get routeAndNavigatorSettings =>
      RouteAndNavigatorSettings(
        navigatorKey: _navigatorKey,
        initialRoute: Routes.HOME,
        onGenerateRoute: _onGenerateRoute,
      );

  @override
  Widget get screen => const HomePage();
}

Route? _onGenerateRoute(RouteSettings settings) {
  Get.routing.args = settings.arguments;
  String route = settings.name!;
  final arguments = settings.arguments as Map<String, dynamic>?;
  String tag;
  if (arguments != null) {
    tag = arguments['tag'] as String;
  } else {
    tag = '';
  }
  switch (route) {
    case Routes.HOME:
      return GetPageRoute(
        routeName: Routes.HOME,
        page: () => const HomePage(),
        binding: HomeBindings(),
      );

    case Routes.WISHLIST:
      return GetPageRoute(
        routeName: Routes.WISHLIST,
        page: () => const WishlistPage(),
        binding: WishlistBindings(),
      );

    case Routes.PRODCUTS:
      return GetPageRoute(
        routeName: Routes.PRODCUTS,
        page: () => ProductsPage(
          // Overide Tag to get the right controller
          uniqueTag: tag,
          // This page is used in other navigators also
          // That's why assigning navigationKey
          navigationId: homeNavigationId,
        ),
        binding: ProductsBindings(
          // Tag is used to create multiple instances of same controller
          uniqueTag: tag,
        ),
      );

    case Routes.PRODUCTDETAILS:
      return GetPageRoute(
        routeName: Routes.PRODUCTDETAILS,
        page: () => ProductDetailsPage(
          uniqueTag: tag,
          navigationId: homeNavigationId,
        ),
        binding: ProductDetailsBindings(uniqueTag: tag),
      );

    default:
      return null;
  }
}
