import 'package:dartz/dartz.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

class WishlistRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;

  WishlistRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder;

  Future<Either<AppException, Product>> fetchProduct(int id) async {
    try {
      Uri url = _urlBuilder.product(id);
      final response = await _apiBaseHelper.request(url);
      return Right(Product.fromJson(response));
    } catch (e) {
      if (e is AppException) {
        return Left(e);
      }
      return Left(AppException("Something went wrong"));
    }
  }
}
