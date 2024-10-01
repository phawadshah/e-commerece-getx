import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/previously_viewed_controller.dart';
import 'package:shop/app/modules/base/base_controller.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/modules/product_details/presentation/widgets/bottom_sheet.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';

class ProductDetailsController extends GetxController with LoadingMixin {
  late int navigationId;
  final UserConfig _userConfig;
  final PreviouslyViewedController _previouslyViewedController;
  ProductDetailsController(
      {required UserConfig userConfig,
      required PreviouslyViewedController previouslyViewedController})
      : _userConfig = userConfig,
        _previouslyViewedController = previouslyViewedController;
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  late Product _product;
  Product get product => _product;

  late double _total = 0.0;
  double get total => _total;

  RxBool hasError = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() {
    _init();
    // _total = _userConfig.cartTotal.value;
    // _userConfig.cartTotal.listen((sum) => _total = sum);
    super.onInit();
  }

  void _init() {
    try {
      _product = Get.arguments['product'] as Product;
      _previouslyViewedController.addViewedProduct(product);
    } catch (e) {
      hasError(true);
      error("We are sorry for the inconvenience!\nKindly retry in a while");
    }
  }

  void onImageSwiped() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onAddToCartTap() async {
    await executeWithLoading(delay: const Duration(milliseconds: 600),
        () async {
      // _userConfig.addToCart(_product);
    });

    Get.bottomSheet(
      backgroundColor: Colors.white,
      CartBottomSheet(
        title: product.title,
        total: total,
        onViewCartTap: () {
          Get.back();
          BaseController.to.changeTab(3);
        },
        onContinueShoppingTap: () {
          Get.back();
        },
      ),
    );
  }

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }
}
