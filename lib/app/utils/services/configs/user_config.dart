// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';

import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/services/cart_service.dart';
import 'package:shop/app/utils/services/wishlist_service.dart';
import '../../pages/app_pages.dart';
import '../data/models/product_storage_model.dart';

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
  RxList<ProductStorageModel> cartItems = <ProductStorageModel>[].obs;

  RxDouble cartTotal = 0.0.obs;
  RxInt cartCount = 0.obs;

  @override
  Future<void> onInit() async {
    if (_authController.user != null) {
      _uid = _authController.user!.uid;
      wishlistItemsIds.value = await _wishlistService.getItems(uid);
    }
    super.onInit();
  }

  Future<void> addToWhislist(Product product) async {
    if (!isAuthenticated) {
      Get.toNamed(Routes.LOGIN);
    } else {
      if (wishlistItemsIds.any((w) => w == product.id)) {
        wishlistItemsIds.remove(product.id);
        await _wishlistService.removeProduct(uid, product.id);
      } else {
        wishlistItemsIds.add(product.id);
        await _wishlistService.addProduct(uid, product.id);
      }
    }
  }

  Future<void> removeFromWhislist(Product product) async {
    if (wishlistItemsIds.any((w) => w == product.id)) {
      wishlistItemsIds.remove(product.id);
      await _wishlistService.removeProduct(uid, product.id);
    }
  }

  // ============================ CART =================================
  Future<void> addToCart(Product product) async {
    cartTotal.value += product.price;
    cartCount.value += 1;
    if (_isProductInCart(product.id)) {
      _incrementProductQuantity(product.id);
    } else {
      _addNewProductToCart(product);
    }
    if (isAuthenticated) {
      await _cartService.addItemToFirebase(product, uid: _uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }

  Future<void> decrementQuantity(Product product) async {
    cartTotal.value -= product.price;
    cartCount.value -= 1;
    // Decrement the quantity if we have more than 1
    if (cartItems.where((p) => p.id == product.id).first.quantity > 1) {
      cartItems.where((p) => p.id == product.id).first.quantity -= 1;
      if (isAuthenticated) {
        await _cartService.updateItemInFirebase(product, uid: _uid);
      } else {
        await _cartService.updateCartLocally(cartItems);
      }
    } else {
      // if we have only one item with the same id we will remove it
      cartItems.removeWhere((p) => p.id == product.id);
      if (isAuthenticated) {
        await _cartService.removeItemFromFirebase(product, uid: _uid);
      } else {
        await _cartService.updateCartLocally(cartItems);
      }
    }
  }

  Future<void> removeFromCart(Product product) async {
    cartTotal.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity *
            product.price;
    cartCount.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity;
    cartItems.removeWhere((p) => p.id == product.id);
    if (isAuthenticated) {
      await _cartService.removeItemFromFirebase(product, uid: _uid);
    } else {
      await _cartService.updateCartLocally(cartItems);
    }
  }

  bool _isProductInCart(int? productId) =>
      cartItems.any((p) => p.id == productId);

  void _incrementProductQuantity(int productId) {
    var product = cartItems.firstWhere((p) => p.id == productId);
    product.quantity += 1;
  }

  void _addNewProductToCart(Product product) => cartItems.add(
      ProductStorageModel(id: product.id, price: product.price, quantity: 1));
}
