import 'package:dartz/dartz.dart';

import '../../../../server/api_base_helper.dart';
import '../../../../server/exceptions/app_exceptions.dart';
import '../../../../utils/constants/url_builder.dart';
import '../../../categories/data/models/category.dart';
import '../models/product.dart';

class HomeRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;

  HomeRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder;

  Future<Either<AppException, T>> _fetchData<T>({
    required Uri url,
    required T Function(dynamic data) parse,
  }) async {
    try {
      final results = await _apiBaseHelper.request(url);
      return Right(parse(results));
    } catch (e) {
      return Left(e is AppException ? e : AppException(e.toString()));
    }
  }

  Future<Either<AppException, List<CategoryModel>>> fetchCategories() async {
    Uri url = _urlBuilder.allCategories();
    return await _fetchData<List<CategoryModel>>(
        url: url,
        parse: (data) => (data as List<dynamic>)
            .map((category) => CategoryModel.fromJson(category))
            .toList());
  }

  Future<Either<AppException, List<Product>>> fetchProducts(
    String endpoint,
  ) async {
    Uri url = _urlBuilder.buildUri(endpoint: endpoint);
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  Future<Either<AppException, List<Product>>> fetchAllProducts() async {
    Uri url = _urlBuilder.allProducts();
    return await _fetchData(url: url, parse: (data) => _parseData(data));
  }

  List<Product> _parseData(dynamic data) {
    return (data['products'] as List<dynamic>)
        .map((product) => Product.fromJson(product))
        .toList();
  }
}
