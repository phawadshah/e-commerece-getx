import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/modules/search/data/repository/search_repository.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

class SearchControllerr extends GetxController {
  final SearchRepository _searchRepository;
  final UserConfig _userConfig;
  SearchControllerr({
    required SearchRepository searchRepository,
    required UserConfig userConfig,
  })  : _searchRepository = searchRepository,
        _userConfig = userConfig;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final FocusNode _searchFocusNode = FocusNode();
  FocusNode get searchFocusNode => _searchFocusNode;

  Rx<String> searchText = "".obs;
  final RxList<Product> searchResults = <Product>[].obs;
  final RxList<Product> previousSearches = <Product>[].obs;

  RxBool hasError = false.obs;
  RxString error = ''.obs;
  @override
  void onInit() {
    _init();
    _registerListener();
    super.onInit();
  }

  _init() {
    previousSearches.value = _userConfig.previousSearches;
    _userConfig.previousSearches.listen((results) {
      previousSearches.value = results;
    });
  }

  void onScreenTap() => _searchFocusNode.unfocus();

  void onClearTap() {
    _searchController.clear();
    searchText.value = "";
    searchResults.value = [];
  }

  void onRemoveHistoryItemTap(Product product) async {
    await _userConfig.removeSearch(product);
  }

  void onClearAllTap() async {
    await _userConfig.clearSearchHistory();
  }

  void onSearchItemTap(Product product) async {
    _searchFocusNode.unfocus();
    !previousSearches.contains(product)
        ? await _userConfig.addSearchedProducts(product)
        : null;
    Get.toNamed(
      Routes.PRODUCTDETAILS,
      id: searchNavigationId,
      arguments: {
        "product": product,
        'tag': "${Routes.SEARCH}/${product.id}",
      },
    );
  }

  void _registerListener() {
    searchController.addListener(_onSearchFieldChange);
  }

  void _onSearchFieldChange() {
    if (searchController.text.isEmpty) {
      searchText.value = "";
      searchResults.clear();
    } else {
      if (searchController.text.trim().length > 1) {
        searchText.value = searchController.text;
        _search(searchText.value);
      }
    }
  }

  _search(String query) async {
    hasError(false);
    error('');
    searchResults.value = [];
    final results = await _searchRepository.searchProducts(query);
    results.fold(
      (e) {
        hasError(true);
        error(e.toString());
      },
      (data) => searchResults.value = data,
    );
  }
}
