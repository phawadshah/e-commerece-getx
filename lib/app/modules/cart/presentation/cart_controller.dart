import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shop/app/modules/cart/data/cartProductModel.dart';
import 'package:shop/app/modules/cart/repositories/cart_repository.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';

class CartController extends GetxController with LoadingMixin {
  static CartController get to => Get.find<CartController>();
  final UserConfig _userConfig;
  final CartRepository _cartRepository;
  CartController({
    required UserConfig userConfig,
    required CartRepository cartRepository,
  })  : _userConfig = userConfig,
        _cartRepository = cartRepository;

  RxList<CartProductModel> cartItems = <CartProductModel>[].obs;
  RxList<int> productIds = <int>[].obs;

  RxDouble total = 0.0.obs;
  StreamSubscription<double>? totalSubscription;

  RxBool hasError = false.obs;
  RxString error = ''.obs;

  void init() async {
    productIds.value = _userConfig.cartItems.map((p) => p.id).toList();
    total.value = _userConfig.cartTotal.value;
    await _fetchProducts(productIds);
    _registerStreams();
  }

  void _registerStreams() {
    _userConfig.cartTotal.listen((sum) => total.value = sum);
  }

  void onRetry() async {
    error('');
    hasError(false);
    await executeWithLoading(
      delay: const Duration(milliseconds: 700),
      () => _fetchProducts(productIds),
    );
  }

  Future _fetchProducts(List<int> ids) async {
    log("ids :: ${ids.length}");
    final results = await _cartRepository.fetchCartProducts(ids);
    results.fold((e) {
      log("error");
      hasError(true);
      error(e.toString());
    }, (data) {
      cartItems.clear();
      data
          .map((e) => cartItems.add(CartProductModel(
              product: e,
              quantity: _userConfig.cartItems
                  .where((p) => p.id == e.id)
                  .first
                  .quantity)))
          .toList();
      cartItems.refresh();
    });
  }

  void onRemoveTap(Product product) async {
    cartItems.removeWhere((e) => e.product.id == product.id);
    cartItems.refresh();
    await _userConfig.removeFromCart(product);
  }

  void onDecrementtap(Product product) async {
    if (cartItems.where((e) => e.product.id == product.id).first.quantity ==
        1) {
      cartItems.removeWhere((e) => e.product.id == product.id);
    } else {
      cartItems.where((e) => e.product.id == product.id).first.quantity -= 1;
    }
    cartItems.refresh();
    await _userConfig.decrementQuantity(product);
  }

  void onAddTap(Product product) async {
    cartItems.where((e) => e.product.id == product.id).first.quantity += 1;
    cartItems.refresh();
    await _userConfig.addToCart(product);
  }
}
