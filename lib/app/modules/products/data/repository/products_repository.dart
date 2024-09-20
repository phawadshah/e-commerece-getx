import 'package:dartz/dartz.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

class ProductsRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;

  ProductsRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder;

  Future<Either<AppException, List<Product>>> fetchCategoryProduct(
    String category,
  ) async {
    Uri url = _urlBuilder.categoryProducts(category);
    try {
      final response = await _apiBaseHelper.request(url);
      return Right((response['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e))
          .toList());
    } catch (e) {
      if (e is AppException) {
        return Left(e);
      }
      return Left(AppException("Something went wrong"));
    }
  }
}
