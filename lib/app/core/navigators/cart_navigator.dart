import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/modules/cart/presentation/cart_bindings.dart';
import 'package:shop/app/modules/cart/presentation/cart_page.dart';

import '../../utils/pages/app_pages.dart';

class CartNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? _navigatorKey;
  const CartNavigator(
      {super.key, required GlobalKey<NavigatorState>? navigatorKey})
      : _navigatorKey = navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: Routes.CART,
      onGenerateRoute: _onGenerateRoute,
    );
  }
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
