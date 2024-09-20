import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shop/app/core/configs/user_config.dart';

import '../../../../server/api_base_helper.dart';
import '../../../../server/exceptions/app_exceptions.dart';
import '../../../../utils/constants/url_builder.dart';
import '../../../categories/data/models/category.dart';
import '../models/product.dart';

class HomeRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;
  final UserConfig _userConfig;

  HomeRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
    required UserConfig userConfig,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder,
        _userConfig = userConfig {
    _getWishlist();
  }

  late List<int> _wishlistItemsIds;

  void _getWishlist() {
    _wishlistItemsIds = _userConfig.wishlistItemsIds;
    log("wishlistItemsIds: $_wishlistItemsIds");
  }

  RxBool isConnected = false.obs;
  Future<Either<AppException, T>> _fetchData<T>({
    required Uri url,
    required T Function(dynamic data) parse,
  }) async {
    try {
      final results = await _apiBaseHelper.request(url);
      return Right(parse(results));
    } catch (e) {
      if (e is AppException) {
        return Left(e);
      }
      return Left(AppException(e.toString()));
    }
  }

  _parseData(dynamic data) {
    return (data['products'] as List<dynamic>)
        .map(
          (product) => Product.fromJson(product,
              isFav: _wishlistItemsIds.any((w) => w == product["id"])),
        )
        .toList();
  }

  Future<Either<AppException, List<CategoryModel>>> fetchCategories() async {
    Uri url = _urlBuilder.allCategories();
    return await _fetchData(
        url: url,
        parse: (data) => (data as List<dynamic>)
            .map((category) => CategoryModel.fromJson(category))
            .toList());
  }

  Future<Either<AppException, List<Product>>> fetchLaptops() async {
    Uri url = _urlBuilder.laptops();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchBeauty() async {
    Uri url = _urlBuilder.beauty();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchMenWatches() async {
    Uri url = _urlBuilder.menWatches();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchFurniture() async {
    Uri url = _urlBuilder.furniture();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchShoes() async {
    Uri url = _urlBuilder.shoes();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchHomeDecor() async {
    Uri url = _urlBuilder.homeDecor();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchSmartPhones() async {
    final url = _urlBuilder.smartPhones();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchFrangrances() async {
    Uri url = _urlBuilder.fragrances();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchSkinCare() async {
    Uri url = _urlBuilder.skinCare();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchGroceries() async {
    Uri url = _urlBuilder.groceries();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchAllProducts() async {
    Uri url = _urlBuilder.allProducts();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }
}
