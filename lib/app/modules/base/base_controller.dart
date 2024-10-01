import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/core/navigators/categories_navigator.dart';
import 'package:shop/app/core/navigators/home_navigator.dart';
import 'package:shop/app/core/navigators/search_navigator.dart';
import 'package:shop/app/modules/cart/presentation/cart_controller.dart';
import 'package:shop/app/modules/profile/presentation/profile_page.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/modules/categories/presentation/categories_controller.dart';
import '../../core/navigators/cart_navigator.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find<BaseController>();
  late PersistentTabController tabController;
  final List<GlobalKey<NavigatorState>?> _navigatorKeys;
  final UserConfig _userConfig;
  BaseController({
    required UserConfig userConfig,
    required List<GlobalKey<NavigatorState>?> navigatorKeys,
  })  : _userConfig = userConfig,
        _navigatorKeys = navigatorKeys;

  late List<CustomNavBarScreen> navBarScreens;

  RxInt cartCount = 0.obs;
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) {
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    tabController = PersistentTabController(initialIndex: currentIndex);
    navBarScreens = [
      HomeNavigator(navigatorKey: homeNavigatorKey),
      SearchNavigator(navigatorKey: searchNavigatorKey),
      CategoriesNavigator(navigatorKey: categoriesNavigatorKey),
      CartNavigator(navigatorKey: cartNavigatorKey),
      const CustomNavBarScreen(screen: ProfilePage()),
    ];
    _init();
    super.onInit();
  }

  void _init() {
    // cartCount.value = _userConfig.cartCount.value;
    // _userConfig.cartCount.listen((count) {
    //   cartCount.value = count;
    // });
  }

  void changeTab(int index) {
    if (index == currentIndex) {
      _navigatorKeys[currentIndex]
          ?.currentState
          ?.popUntil((route) => route.isFirst);
    } else if (index == 2) {
      CategoriesController.to.init();
    } else if (index == 3) {
      CartController.to.init();
    }
    currentIndex = index;
    tabController.index = index;
  }
}
