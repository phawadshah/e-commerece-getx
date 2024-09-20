import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

class CartRepository {
  final UrlBuilder _urlBuilder;
  final ApiBaseHelper _apiBaseHelper;

  CartRepository({
    required UrlBuilder urlBuilder,
    required ApiBaseHelper apiBaseHelper,
  })  : _urlBuilder = urlBuilder,
        _apiBaseHelper = apiBaseHelper;

  Future<Either<AppException, List<Product>>> fetchCartProducts(
    List<int> ids,
  ) async {
    List<Product> products = [];
    for (int id in ids) {
      final productOrError = await fetchProduct(_urlBuilder.product(id));
      productOrError.fold((error) {
        log("message");
        return Left(error);
      }, (product) {
        products.add(product);
      });
    }
    return Right(products);
  }

  Future<Either<AppException, Product>> fetchProduct(Uri url) async {
    try {
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
