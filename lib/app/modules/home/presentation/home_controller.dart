import 'dart:developer';
import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../../categories/data/models/category.dart';
import '../data/models/product.dart';
import '../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository;
  final UserConfig _userConfig;
  HomeController(
      {required HomeRepository homeRepository, required UserConfig userConfig})
      : _homeRepository = homeRepository,
        _userConfig = userConfig;

  String title = 'Home';
  RxBool hasError = false.obs;
  RxString error = ''.obs;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<Product> laptops = <Product>[].obs;
  RxList<Product> beauty = <Product>[].obs;
  RxList<Product> skinCare = <Product>[].obs;
  RxList<Product> menWatches = <Product>[].obs;
  RxList<Product> furniture = <Product>[].obs;
  RxList<Product> shoes = <Product>[].obs;
  RxList<Product> homeDecor = <Product>[].obs;
  RxList<Product> groceries = <Product>[].obs;
  RxList<Product> allProducts = <Product>[].obs;
  RxList<int> wishList = <int>[].obs;

  @override
  void onInit() async {
    _initUserConfig();
    await _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    await _fetchCategories();
    await _fetchLaptops();
    await _fetchBeauty();
    await _fetchMenWatches();
    await _fetchSkinCare();
    await _fetchFurniture();
    await _fetchShoes();
    await _fetchHomeDecor();
    await _fetchGroceries();
    await _fetchAllProducts();
  }

  void _initUserConfig() {
    log("total wishlist items: ${_userConfig.wishlistItemsIds.length}");
    wishList = _userConfig.wishlistItemsIds;

    /// Listen if the list is changed
    _userConfig.wishlistItemsIds.listen((items) {
      wishList(items);
    });
  }

  void onCategoryTap(CategoryModel category) {
    Get.toNamed(
      Routes.PRODCUTS,
      id: homeNavigationId,
      arguments: {
        'category': category,
        'tag': "${Routes.HOME}/${category.name}",
      },
    );
  }

  void onProductTap(Product product) {
    Get.toNamed(
      Routes.PRODUCTDETAILS,
      id: homeNavigationId,
      arguments: {
        'product': product,
        'tag': "${Routes.HOME}/${product.id}",
      },
    );
  }

  void onFavTap() {
    Get.toNamed(Routes.WISHLIST, id: homeNavigationId);
  }

  Future<void> onHeartTap(Product product) async {
    await _userConfig.addToWhislist(product);
  }

  _fetchCategories() async {
    final results = await _homeRepository.fetchCategories();
    results.fold((e) {
      hasError(true);
      error(e.toString());
    }, (results) {
      categories.value = results;
    });
  }

  _fetchLaptops() async {
    final results = await _homeRepository.fetchLaptops();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      laptops.value = results;
    });
  }

  _fetchBeauty() async {
    final results = await _homeRepository.fetchBeauty();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      beauty.value = results;
    });
  }

  _fetchMenWatches() async {
    final results = await _homeRepository.fetchMenWatches();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      menWatches.value = results;
    });
  }

  _fetchSkinCare() async {
    final results = await _homeRepository.fetchSkinCare();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      skinCare.value = results;
    });
  }

  _fetchFurniture() async {
    final results = await _homeRepository.fetchFurniture();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      furniture.value = results;
    });
  }

  _fetchShoes() async {
    final results = await _homeRepository.fetchShoes();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      shoes.value = results;
    });
  }

  _fetchGroceries() async {
    final results = await _homeRepository.fetchGroceries();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      groceries.value = results;
    });
  }

  _fetchHomeDecor() async {
    final results = await _homeRepository.fetchHomeDecor();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      homeDecor.value = results;
    });
  }

  _fetchAllProducts() async {
    final results = await _homeRepository.fetchAllProducts();
    results.fold((error) {
      log(error.toString());
    }, (results) {
      allProducts.value = results;
    });
  }
}
