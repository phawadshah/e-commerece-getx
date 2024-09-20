import 'package:get/get.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/modules/wishlist/data/repositories/wishlist_repository.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';

import '../../home/data/models/product.dart';

class WishlistController extends GetxController {
  final UserConfig _userConfig;
  final WishlistRepository _wishlistRepository;
  WishlistController(
      {required UserConfig userConfig,
      required WishlistRepository wishlistRepository})
      : _userConfig = userConfig,
        _wishlistRepository = wishlistRepository;

  RxList<Product> wishlist = <Product>[].obs;
  RxList<int> productIds = <int>[].obs;

  RxBool hasError = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() async {
    await _fetchProducts();
    super.onInit();
  }

  Future _fetchProducts() async {
    productIds.value = _userConfig.wishlistItemsIds;
    for (var id in productIds) {
      final errorOrProduct = await _wishlistRepository.fetchProduct(id);
      errorOrProduct.fold((e) {
        hasError(true);
        error(e.toString());
      }, (product) {
        wishlist.add(product);
      });
    }
  }

  void onRetry() async {
    hasError(false);
    error('');
    await _fetchProducts();
  }

  void onDeleteTap(Product product) async {
    wishlist.any((w) => w.id == product.id) ? wishlist.remove(product) : null;
    await _userConfig.removeFromWhislist(product);
  }
}
