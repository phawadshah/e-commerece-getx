import 'package:flutter/material.dart';
import 'package:get/get.dart';

const homeNavigationId = 0;
const searchNavigationId = 1;
const categoriesNavigatioId = 2;
const cartNavigationId = 3;

GlobalKey<NavigatorState>? homeNavigatorKey = Get.nestedKey(homeNavigationId);
GlobalKey<NavigatorState>? categoriesNavigatorKey =
    Get.nestedKey(categoriesNavigatioId);
GlobalKey<NavigatorState>? searchNavigatorKey =
    Get.nestedKey(searchNavigationId);
GlobalKey<NavigatorState>? cartNavigatorKey = Get.nestedKey(cartNavigationId);

List<GlobalKey<NavigatorState>?> get navigatorKeys => [
      homeNavigatorKey,
      searchNavigatorKey,
      categoriesNavigatorKey,
      cartNavigatorKey
    ];
