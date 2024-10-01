import 'dart:developer';
import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/utils/constants/api_endpoints.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../../categories/data/models/category.dart';
import '../data/models/product.dart';
import '../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository;
  final UserConfig _userConfig;
  HomeController({
    required HomeRepository homeRepository,
    required UserConfig userConfig,
  })  : _homeRepository = homeRepository,
        _userConfig = userConfig;

  String title = 'Home';
  RxBool hasError = false.obs;
  RxString error = ''.obs;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<Product> allProducts = <Product>[].obs;
  RxList<int> get wishList => _userConfig.wishlistItemsIds;

  // ========== Fetch Data ========== //
  RxList<RxList<Product>> products = <RxList<Product>>[].obs;

  @override
  void onInit() async {
    await _loadData();
    super.onInit();
  }

  Future<void> onHeartTap(Product product) async =>
      await _userConfig.addItemToWhislist(product);

  void onFavTap() => Get.toNamed(Routes.WISHLIST, id: Global.homeNavigationId);

  Future<void> _loadData() async {
    await _fetchCategories();
    await _fetchData();
    await _fetchAllProducts();
  }

  void onCategoryTap(CategoryModel category) {
    Get.toNamed(
      Routes.PRODCUTS,
      id: Global.homeNavigationId,
      arguments: {
        'category': category,
        'tag': "${Routes.HOME}/${category.name}",
      },
    );
  }

  void onProductTap(Product product) {
    Get.toNamed(
      Routes.PRODUCTDETAILS,
      id: Global.homeNavigationId,
      arguments: {
        'product': product,
        'tag': "${Routes.HOME}/${product.id}",
      },
    );
  }

  Future _fetchCategories() async {
    final results = await _homeRepository.fetchCategories();
    results.fold((e) {
      hasError(true);
      error(e.toString());
    }, (results) {
      categories.value = results;
    });
  }

  Future _fetchData() async {
    for (var endPoint in _endPoints) {
      final results = await _homeRepository.fetchProducts(endPoint);
      results.fold((e) {
        hasError(true);
        error(e.toString());
      }, (results) {
        products.add(results.obs);
      });
    }
  }

  Future _fetchAllProducts() async {
    final results = await _homeRepository.fetchAllProducts();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      allProducts.value = results;
    });
  }
}

List<String> _endPoints = const [
  ApiEndpoints.LAPTOPS,
  ApiEndpoints.BEAUTY,
  ApiEndpoints.MEN_WATCHES,
  ApiEndpoints.SKIN_CARE,
  ApiEndpoints.FURNITURE,
  ApiEndpoints.MEN_SHOES,
  ApiEndpoints.HOME_DECOR,
  ApiEndpoints.GROCERIES,
];
