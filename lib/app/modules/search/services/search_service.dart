import 'package:get/get.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:shop/app/modules/search/data/models/search_product_model.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';

class SearchService extends GetxService {
  final LocalStorageService _localStorageService;
  SearchService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  RxList<SearchProductModel> previousSearches = <SearchProductModel>[].obs;

  @override
  void onInit() {
    _getSearchedProduct();
    super.onInit();
  }

  _getSearchedProduct() {
    final data =
        _localStorageService.read(key: StorageConstants.PREVIOUSSEARCHES);
    data != null
        ? previousSearches.value = (data as List<dynamic>)
            .map((product) =>
                (SearchProductModel.fromJson(json.decode(product))))
            .toList()
        : null;
  }

  Future<void> addSearchedProducts(SearchProductModel product) async {
    previousSearches.add(product);
    return await _updateSearchHistory();
  }

  Future<void> removeSearch(SearchProductModel product) async {
    previousSearches.remove(product);
    return await _updateSearchHistory();
  }

  Future<void> clearSearchHistory() async {
    previousSearches.clear();
    return await _localStorageService.delete(
        key: StorageConstants.PREVIOUSSEARCHES);
  }

  Future<void> _updateSearchHistory() async {
    return await _localStorageService.write(
      key: StorageConstants.PREVIOUSSEARCHES,
      data: List<dynamic>.from(previousSearches.map((s) => s.toJson())),
    );
  }
}
