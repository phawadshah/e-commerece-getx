import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop/app/modules/cart/presentation/cart_bindings.dart';
import 'package:shop/app/modules/cart/presentation/cart_page.dart';

import '../../utils/pages/app_pages.dart';

class CartNavigator extends StatelessWidget implements CustomNavBarScreen {
  final GlobalKey<NavigatorState>? _navigatorKey;
  const CartNavigator(
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
        initialRoute: Routes.CART,
        onGenerateRoute: _onGenerateRoute,
      );

  @override
  Widget get screen => const CartPage();
}

Route? _onGenerateRoute(RouteSettings settings) {
  Get.routing.args = settings.arguments;
  String route = settings.name!;
  switch (route) {
    case Routes.CART:
      return GetPageRoute(
        routeName: Routes.CART,
        page: () => const CartPage(),
        binding: CartBindings(),
      );
    default:
      return null;
  }
}
