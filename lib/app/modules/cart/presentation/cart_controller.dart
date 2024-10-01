import 'dart:async';
import 'package:get/get.dart';
import 'package:shop/app/modules/cart/data/models/cart_item.dart';
import 'package:shop/app/modules/cart/data/repositories/cart_repository.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';
import '../../../initials/controllers.dart/previously_viewed_controller.dart';

class CartController extends GetxController with LoadingMixin {
  static CartController get to => Get.find<CartController>();
  final UserConfig _userConfig;
  final CartRepository _cartRepository;
  final PreviouslyViewedController _previouslyViewedController;
  CartController({
    required UserConfig userConfig,
    required CartRepository cartRepository,
    required PreviouslyViewedController previouslyViewedController,
  })  : _userConfig = userConfig,
        _cartRepository = cartRepository,
        _previouslyViewedController = previouslyViewedController;

  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxList<int> productIds = <int>[].obs;

  RxList<Product> previouslyViewedItems = <Product>[].obs;
  RxList<int> wishListItems = <int>[].obs;

  RxDouble total = 0.0.obs;
  StreamSubscription<double>? totalSubscription;

  RxBool hasError = false.obs;
  RxString error = ''.obs;

  void init() async {
    _initUserConfig();
    await executeWithLoading(
      () => _fetchProducts(productIds),
    );
    _registerStreams();
  }

  void _initUserConfig() {
    // productIds.value = _userConfig.cartItems.map((p) => p.id).toList();
    // total.value = _userConfig.cartTotal.value;
    previouslyViewedItems.value =
        _previouslyViewedController.previouslyViewedProducts;

    _previouslyViewedController.previouslyViewedProducts.listen((items) {
      previouslyViewedItems(items);
    });

    wishListItems = _userConfig.wishlistItemsIds;
    // Listen if the list is changed
    _userConfig.wishlistItemsIds.listen((items) {
      wishListItems(items);
    });
  }

  void _registerStreams() {
    // _userConfig.cartTotal.listen((sum) => total.value = sum);
    // _userConfig.cartItems.listen((items) {
    //   productIds.value = items.map((p) => p.id).toList();
    // });
  }

  void onRetry() async {
    error('');
    hasError(false);
    // await executeWithLoading(
    //   delay: const Duration(milliseconds: 700),
    //   () => _fetchProducts(_userConfig.cartItems.map((p) => p.id).toList()),
    // );
  }

  Future _fetchProducts(List<int> ids) async {
    cartItems.clear();
    // for (var id in ids) {
    //   final errorOrProduct = await _cartRepository.fetchProduct(id);
    //   errorOrProduct.fold((e) {
    //     hasError(true);
    //     error(e.toString());
    //   }, (product) {
    //     cartItems.add(CartItem(
    //         quantity: _userConfig.cartItems
    //             .where((p) => p.id == product.id)
    //             .first
    //             .quantity,
    //         product: product));
    //   });
    // }
  }

  void onRemoveTap(Product product) async {
    cartItems.removeWhere((e) => e.product.id == product.id);
    cartItems.refresh();
    // await _userConfig.removeFromCart(product);
  }

  void onDecrementtap(Product product) async {
    if (cartItems.where((e) => e.product.id == product.id).first.quantity ==
        1) {
      cartItems.removeWhere((e) => e.product.id == product.id);
    } else {
      cartItems.where((e) => e.product.id == product.id).first.quantity -= 1;
    }
    cartItems.refresh();
    // await _userConfig.decrementQuantity(product);
  }

  void onAddTap(Product product) async {
    cartItems.where((e) => e.product.id == product.id).first.quantity += 1;
    cartItems.refresh();
    // await _userConfig.addToCart(product);
  }
}
