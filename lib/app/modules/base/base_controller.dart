import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/core/navigators/categories_navigator.dart';
import 'package:shop/app/core/navigators/home_navigator.dart';
import 'package:shop/app/core/navigators/profile_navigator.dart';
import 'package:shop/app/core/navigators/search_navigator.dart';
import 'package:shop/app/modules/cart/presentation/cart_controller.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import '../../core/navigators/cart_navigator.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find<BaseController>();
  final Global _globale;

  late PersistentTabController tabController;
  // final List<GlobalKey<NavigatorState>?> _navigatorKeys;
  final UserConfig _userConfig;
  BaseController({
    required UserConfig userConfig,
    // required List<GlobalKey<NavigatorState>?> navigatorKeys,
    required Global global,
  })  : _userConfig = userConfig,
        // _navigatorKeys = navigatorKeys,
        _globale = global;

  late List<CustomNavBarScreen> navBarScreens;

  RxInt get cartCount => _userConfig.cartCount;
  final RxInt _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) {
    _currentIndex.value = index;
  }

  @override
  void onInit() {
    tabController = PersistentTabController(initialIndex: currentIndex);
    navBarScreens = [
      HomeNavigator(navigatorKey: _globale.homeNavigatorKey),
      SearchNavigator(navigatorKey: _globale.searchNavigatorKey),
      CategoriesNavigator(navigatorKey: _globale.categoriesNavigatorKey),
      CartNavigator(navigatorKey: _globale.cartNavigatorKey),
      ProfileNavigator(navigatorKey: _globale.profileNavigatorKey)
    ];

    super.onInit();
  }

  void changeTab(int index) async {
    if (index == currentIndex) {
      _globale.navigatorKeys[currentIndex]?.currentState
          ?.popUntil((route) => route.isFirst);
    } else if (index == 3) {
      await CartController.to.init();
    }
    currentIndex = index;
    tabController.index = index;
  }
}
