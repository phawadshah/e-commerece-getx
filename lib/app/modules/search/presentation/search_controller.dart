import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/modules/search/data/models/search_product_model.dart';
import 'package:shop/app/modules/search/data/repository/search_repository.dart';
import 'package:shop/app/modules/search/services/search_service.dart';

import 'package:shop/app/utils/pages/app_pages.dart';

class SearchControllerr extends GetxController {
  final SearchRepository _searchRepository;
  final SearchService _searchService;

  SearchControllerr({
    required SearchRepository searchRepository,
    required SearchService searchService,
  })  : _searchRepository = searchRepository,
        _searchService = searchService;

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final FocusNode _searchFocusNode = FocusNode();
  FocusNode get searchFocusNode => _searchFocusNode;

  Rx<String> searchText = "".obs;
  final RxList<Product> searchResults = <Product>[].obs;
  final RxList<SearchProductModel> previousSearches =
      <SearchProductModel>[].obs;

  RxBool hasError = false.obs;
  RxString error = ''.obs;
  @override
  void onInit() {
    _init();
    _registerListener();
    super.onInit();
  }

  _init() {
    previousSearches.value = _searchService.previousSearches;
  }

  void onScreenTap() => _searchFocusNode.unfocus();
  void _registerListener() {
    searchController.addListener(_onSearchFieldChange);
  }

  void onClearTap() {
    _searchController.clear();
    searchText.value = "";
    searchResults.value = [];
  }

  void onClearHistoryItemTap(SearchProductModel product) async {
    await _searchService.removeSearch(product);
  }

  void onClearAllTap() async {
    await _searchService.clearSearchHistory();
  }

  Future<void> onHistoryItemTap(SearchProductModel product) async {
    _searchFocusNode.unfocus();
    !previousSearches.contains(product)
        ? await _searchService.addSearchedProducts(product)
        : null;
    await _fetchProduct(product.id);
  }

  Future<void> _fetchProduct(int id) async {
    final errorOrProduct = await _searchRepository.fetchProduct(id);
    errorOrProduct.fold((e) {
      hasError(true);
      error(e.toString());
    }, (product) {
      _goToProductDetailsScreen(product);
    });
  }

  Future<void> onSearchItemTap(Product product) async {
    _searchFocusNode.unfocus();
    !previousSearches.any((s) => s.id == product.id)
        ? await _searchService.addSearchedProducts(
            SearchProductModel(id: product.id, title: product.title))
        : null;
    _goToProductDetailsScreen(product);
  }

  void _goToProductDetailsScreen(Product product) {
    Get.toNamed(
      Routes.PRODUCTDETAILS,
      id: searchNavigationId,
      arguments: {
        "product": product,
        'tag': "${Routes.SEARCH}/${product.id}",
      },
    );
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
    final errorOrProducts = await _searchRepository.searchProducts(query);
    errorOrProducts.fold(
      (e) {
        hasError(true);
        error(e.toString());
      },
      (products) => searchResults.value = products,
    );
  }
}
