import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../modules/profile/presentation/profile_bindings.dart';
import '../../modules/profile/presentation/profile_page.dart';
import '../../utils/pages/app_pages.dart';

class ProfileNavigator implements CustomNavBarScreen {
  final GlobalKey<NavigatorState>? _navigatorKey;

  const ProfileNavigator({required GlobalKey<NavigatorState>? navigatorKey})
      : _navigatorKey = navigatorKey;

  @override
  RouteAndNavigatorSettings? get routeAndNavigatorSettings =>
      RouteAndNavigatorSettings(
        initialRoute: Routes.PROFILE,
        navigatorKey: _navigatorKey,
        onGenerateRoute: _onGenerateRoute,
      );

  @override
  Widget get screen => const ProfilePage();
}

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  Get.routing.args = settings.arguments;
  String route = settings.name!;
  switch (route) {
    case Routes.PROFILE:
      return GetPageRoute(
        routeName: Routes.PROFILE,
        page: () => const ProfilePage(),
        binding: ProfileBindings(),
      );
    default:
      return null;
  }
}
