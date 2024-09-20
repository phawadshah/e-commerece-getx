// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';
import '../../utils/services/data/models/product_storage_model.dart';

/* 
Config user is mostly used in that case where the user is not logged in
Else we can save the data in the database
*/
class UserConfig extends GetxService {
  final LocalStorageService _localStorageService;
  UserConfig({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  RxList<int> wishlistItemsIds = <int>[].obs;
  RxList<Product> previousSearches = <Product>[].obs;

  RxList<ProductStorageModel> cartItems = <ProductStorageModel>[].obs;
  RxDouble cartTotal = 0.0.obs;
  RxInt cartCount = 0.obs;

  @override
  void onInit() {
    _getCart();
    _getTotal();
    _getWishlist();
    _getSearchedProduct();
    super.onInit();
  }

  /// ================== WISHLIST ====================
  _getWishlist() {
    final data = _localStorageService.read(key: StorageConstants.WISHLIST);
    data != null ? wishlistItemsIds.value = List<int>.from(data) : null;
    log("wishlist lenght :: ${wishlistItemsIds.length}");
  }

  Future<void> addToWhislist(Product product) async {
    // Every time wishlist changes we will update it in local storage
    if (wishlistItemsIds.any((w) => w == product.id)) {
      wishlistItemsIds.remove(product.id);
    } else {
      wishlistItemsIds.add(product.id);
    }
    await updateWishlist(product);
  }

  Future<void> removeFromWhislist(Product product) async {
    wishlistItemsIds.remove(product.id);
    await updateWishlist(product);
  }

  Future<void> updateWishlist(Product product) async {
    log("wishlistItemsIds: $wishlistItemsIds");
    await _localStorageService.write(
      key: StorageConstants.WISHLIST,
      data: List<int>.from(wishlistItemsIds),
    );
  }

  /// ================== CART ====================
  _getCart() {
    // This func runs only one time when app starts
    final data = _localStorageService.read(key: StorageConstants.CART);
    data != null
        ? cartItems.value = (data as List<dynamic>)
            .map((x) => (ProductStorageModel.fromJson((x))))
            .toList()
        : null;
  }

  _getTotal() {
    // This func runs only one time when app starts
    cartItems.fold(0.0,
        (sum, item) => cartTotal.value = sum + (item.price * item.quantity));
    cartItems.fold(0, (count, item) => cartCount.value = count + item.quantity);
  }

  Future<void> addToCart(Product product) async {
    cartTotal.value += product.price;
    cartCount.value += 1;
    // if we have already the item in cart just increment the quantity
    if (cartItems.any((p) => p.id == product.id)) {
      cartItems.where((p) => p.id == product.id).first.quantity += 1;
    } else {
      // if we don't have the item in cart we will add it
      cartItems.add(ProductStorageModel(id: product.id, price: product.price));
    }
    await _updateCart();
  }

  Future<void> removeFromCart(Product product) async {
    cartTotal.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity *
            product.price;
    cartCount.value -=
        cartItems.where((p) => (p.id == product.id)).first.quantity;
    cartItems.removeWhere((p) => p.id == product.id);

    await _updateCart();
  }

  Future<void> decrementQuantity(Product product) async {
    cartTotal.value -= product.price;
    cartCount.value -= 1;
    // Decrement the quantity if we have more than 1
    if (cartItems.where((p) => p.id == product.id).first.quantity > 1) {
      cartItems.where((p) => p.id == product.id).first.quantity -= 1;
    } else {
      // if we have only one item with the same id we will remove it
      cartItems.removeWhere((p) => p.id == product.id);
    }
    await _updateCart();
  }

  Future<void> _updateCart() async {
    // Every time cart changes we will update it in local storage
    return await _localStorageService.write(
      key: StorageConstants.CART,
      data: List<dynamic>.from(
        cartItems.map((x) => x.toJson()),
      ),
    );
  }

  /// ================== SEARCH ====================

  _getSearchedProduct() {
    final data =
        _localStorageService.read(key: StorageConstants.PREVIOUSSEARCHES);
    data != null
        ? previousSearches.value = (data as List<dynamic>)
            .map((product) => (Product.fromJson(json.decode(product))))
            .toList()
        : null;
  }

  Future<void> addSearchedProducts(Product product) async {
    previousSearches.add(product);
    return await _localStorageService.write(
      key: StorageConstants.PREVIOUSSEARCHES,
      data: List<dynamic>.from(previousSearches.map((x) => x.toJson())),
    );
  }

  Future<void> removeSearch(Product product) async {
    previousSearches.remove(product);
    return await _localStorageService.write(
      key: StorageConstants.PREVIOUSSEARCHES,
      data: List<dynamic>.from(previousSearches.map((x) => x.toJson())),
    );
  }

  Future<void> clearSearchHistory() async {
    previousSearches.clear();
    return await _localStorageService.delete(
        key: StorageConstants.PREVIOUSSEARCHES);
  }
}
