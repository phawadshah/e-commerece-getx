import 'package:dartz/dartz.dart';
import 'package:shop/app/server/api_base_helper.dart';

import '../../../../server/exceptions/app_exceptions.dart';
import '../../../../utils/constants/url_builder.dart';
import '../../../home/data/models/product.dart';

class SearchRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;
  SearchRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder;

  Future<Either<AppException, List<Product>>> searchProducts(
      String query) async {
    Uri url = _urlBuilder.searchProducts(query);
    try {
      final response = await _apiBaseHelper.request(url);
      return Right((response["products"] as List<dynamic>)
          .map((product) => Product.fromJson(product))
          .toList());
    } catch (e) {
      if (e is AppException) {
        return Left(e);
      }
      return Left(AppException(e.toString()));
    }
  }
}
