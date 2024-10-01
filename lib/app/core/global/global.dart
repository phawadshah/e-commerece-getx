import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Global extends GetxService {
  static const homeNavigationId = 0;
  static const searchNavigationId = 1;
  static const categoriesNavigatioId = 2;
  static const cartNavigationId = 3;
  static const profileNavigationId = 4;

  GlobalKey<NavigatorState>? homeNavigatorKey = Get.nestedKey(homeNavigationId);
  GlobalKey<NavigatorState>? categoriesNavigatorKey =
      Get.nestedKey(categoriesNavigatioId);
  GlobalKey<NavigatorState>? searchNavigatorKey =
      Get.nestedKey(searchNavigationId);
  GlobalKey<NavigatorState>? cartNavigatorKey = Get.nestedKey(cartNavigationId);

  GlobalKey<NavigatorState>? profileNavigatorKey =
      Get.nestedKey(profileNavigationId);

  List<GlobalKey<NavigatorState>?> get navigatorKeys => [
        homeNavigatorKey,
        searchNavigatorKey,
        categoriesNavigatorKey,
        cartNavigatorKey,
        profileNavigatorKey,
      ];
}
