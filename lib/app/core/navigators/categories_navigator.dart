import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/categories/presentation/categories_bindings.dart';
import 'package:shop/app/modules/categories/presentation/categories_page.dart';
import 'package:shop/app/modules/product_details/presentation/product_details_bindings.dart';
import 'package:shop/app/modules/product_details/presentation/product_details_page.dart';
import 'package:shop/app/modules/products/presentation/products_bindings.dart';
import 'package:shop/app/modules/products/presentation/products_page.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

class CategoriesNavigator extends StatelessWidget
    implements CustomNavBarScreen {
  final GlobalKey<NavigatorState>? _navigatorKey;
  const CategoriesNavigator(
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
        initialRoute: Routes.CATEGORIES,
        onGenerateRoute: _onGenerateRoute,
      );

  @override
  Widget get screen => const CategoriesPage();
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
    case Routes.CATEGORIES:
      return GetPageRoute(
        routeName: Routes.CATEGORIES,
        page: () => const CategoriesPage(),
        binding: CategoriesBindings(),
      );

    case Routes.PRODCUTS:
      return GetPageRoute(
        routeName: Routes.PRODCUTS,
        page: () => ProductsPage(
          uniqueTag: tag,
          navigationId: categoriesNavigatioId,
        ),
        binding: ProductsBindings(
          uniqueTag: tag,
        ),
      );

    case Routes.PRODUCTDETAILS:
      return GetPageRoute(
        routeName: Routes.PRODUCTDETAILS,
        page: () => ProductDetailsPage(
          uniqueTag: tag,
          navigationId: categoriesNavigatioId,
        ),
        binding: ProductDetailsBindings(uniqueTag: tag),
      );

    default:
      return null;
  }
}
