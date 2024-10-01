// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/services/cart_service.dart';
import 'package:shop/app/utils/services/wishlist_service.dart';
import '../../../initials/controllers.dart/previously_viewed_controller.dart';
import '../../pages/app_pages.dart';
import '../local_storage_service.dart';

/* 
Config user is mostly used in that case where the user is not logged in
Else we can save the data in the database
*/
class UserConfig extends GetxService {
  final AuthController _authController;
  final WishlistService _wishlistService;
  final CartService _cartService;

  UserConfig({
    required AuthController authController,
    required WishlistService wishlistService,
    required CartService cartService,
  })  : _authController = authController,
        _wishlistService = wishlistService,
        _cartService = cartService;

  late String _uid;
  String get uid => _uid;
  bool get isAuthenticated => _authController.isAuthenticated.value;

  RxList<int> wishlistItemsIds = <int>[].obs;
  RxList<StorageProduct> cartItems = <StorageProduct>[].obs;

  RxDouble cartTotal = 0.0.obs;
  RxInt cartCount = 0.obs;

  @override
  void onInit() async {
    await _loadUserConfigData();
    super.onInit();
  }

  Future<void> _loadUserConfigData() async {
    clearUserConfigData();
    if (_authController.user != null) {
      _uid = _authController.user!.uid;
      wishlistItemsIds.value = await _wishlistService.getItems(uid);
      cartItems.value = await _cartService.getItemsFromFirebase(uid);
    } else {
      cartItems.value =
          _cartService.getItemsFromLocalStorage() as List<StorageProduct>;
    }
    _getTotal();
  }

  Future<void> manageUserConfig() async {
    if (_authController.user != null) {
      _uid = _authController.user!.uid;
      await _cartService.addListToFirebase(cartItems, uid: uid);
      await _cartService.clearLocalStorage();
      await Get.find<PreviouslyViewedController>().loadPreviouslyViewedItems();
    }
    await _loadUserConfigData();
  }

  void clearUserConfigData() {
    wishlistItemsIds.clear();
    cartItems.clear();
    _getTotal();
  }

  void _getTotal() {
    final totalAndCount = cartItems.fold(
      [0.0, 0],
      (acc, p) => [acc[0] + (p.price * p.quantity), acc[1] + p.quantity],
    );
    cartTotal.value = totalAndCount[0].toDouble();
    cartCount.value = totalAndCount[1].toInt();
  }

  // =========================== WISHLIST =================================

  Future<void> addItemToWhislist(Product product) async {
    if (!isAuthenticated) {
      Get.toNamed(Routes.LOGIN);
    } else {
      if (wishlistItemsIds.any((w) => w == product.id)) {
        await removeItemFromWhislist(product);
      } else {
        wishlistItemsIds.add(product.id);
        await _wishlistService.addProduct(uid, product.id);
      }
    }
  }

  Future<void> removeItemFromWhislist(Product product) async {
    wishlistItemsIds.remove(product.id);
    await _wishlistService.removeProduct(uid, product.id);
  }

  // ============================ CART =================================

  bool _isProductInCart(int? productId) =>
      cartItems.any((p) => p.id == productId);

  Future<void> addItemToCart(Product product) async {
    cartTotal.value += product.price;
    cartCount.value += 1;
    if (_isProductInCart(product.id)) {
      _incrementCartItemQuantity(product.id);
    } else {
      _addNewItemToCart(product);
    }
  }

  Future<void> decrementCartItemQuantity(Product product) async {
    cartTotal.value -= product.price;
    cartCount.value -= 1;
    if (cartItems.where((p) => p.id == product.id).first.quantity > 1) {
      _decrementCartItemQuantity(product.id);
    } else {
      _removeItemFromCart(product.id);
    }
  }

  Future<void> removeItemFromCart(Product product) async {
    cartTotal.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity *
            product.price;
    cartCount.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity;
    _removeItemFromCart(product.id);
  }

  _incrementCartItemQuantity(int productId) async {
    var product = cartItems.firstWhere((p) => p.id == productId);
    product.quantity += 1;
    if (isAuthenticated) {
      await _cartService.updateItemInFirebase(product, uid: uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }

  void _addNewItemToCart(Product product) async {
    var storageProduct = (StorageProduct(id: product.id, price: product.price));
    cartItems.add(storageProduct);
    if (isAuthenticated) {
      await _cartService.addItemToFirebase(storageProduct, uid: _uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }

  void _decrementCartItemQuantity(int productId) async {
    var product = cartItems.firstWhere((p) => p.id == productId);
    product.quantity -= 1;
    if (isAuthenticated) {
      await _cartService.updateItemInFirebase(product, uid: _uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }

  void _removeItemFromCart(int productId) async {
    var product = cartItems.firstWhere((p) => p.id == productId);
    cartItems.remove(product);
    if (isAuthenticated) {
      await _cartService.removeItemFromFirebase(product, uid: _uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }
}
