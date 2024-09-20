import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/core/navigators/categories_navigator.dart';
import 'package:shop/app/core/navigators/home_navigator.dart';
import 'package:shop/app/core/navigators/search_navigator.dart';
import 'package:shop/app/modules/cart/presentation/cart_controller.dart';
import 'package:shop/app/core/configs/user_config.dart';
import '../../core/navigators/cart_navigator.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find<BaseController>();
  final List<GlobalKey<NavigatorState>?> _navigatorKeys;
  final UserConfig _userConfig;
  BaseController({
    required UserConfig userConfig,
    required List<GlobalKey<NavigatorState>?> navigatorKeys,
  })  : _userConfig = userConfig,
        _navigatorKeys = navigatorKeys;

  late List<Widget> pages;

  RxInt cartCount = 0.obs;
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) {
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    pages = [
      HomeNavigator(navigatorKey: homeNavigatorKey),
      SearchNavigator(navigatorKey: searchNavigatorKey),
      CategoriesNavigator(navigatorKey: categoriesNavigatorKey),
      CartNavigator(navigatorKey: cartNavigatorKey),
    ];
    _init();
    super.onInit();
  }

  void _init() {
    cartCount.value = _userConfig.cartCount.value;
    _userConfig.cartCount.listen((count) {
      cartCount.value = count;
    });
  }

  void changeTab(int index) {
    if (index == currentIndex) {
      _navigatorKeys[currentIndex]
          ?.currentState
          ?.popUntil((route) => route.isFirst);
    } else if (index == 3) {
      CartController.to.init();
    }
    currentIndex = index;
  }
}
