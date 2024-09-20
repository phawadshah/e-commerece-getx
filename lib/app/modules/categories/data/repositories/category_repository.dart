import 'package:dartz/dartz.dart';
import 'package:shop/app/modules/categories/data/models/category.dart';
import 'package:shop/app/server/api_base_helper.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/utils/constants/url_builder.dart';

class CategoryRepository {
  final ApiBaseHelper _apiBaseHelper;
  final UrlBuilder _urlBuilder;

  CategoryRepository({
    required ApiBaseHelper apiBaseHelper,
    required UrlBuilder urlBuilder,
  })  : _apiBaseHelper = apiBaseHelper,
        _urlBuilder = urlBuilder;

  Future<Either<AppException, List<CategoryModel>>> getCategories() async {
    Uri url = _urlBuilder.allCategories();
    try {
      final results = await _apiBaseHelper.request(url);
      return Right((results as List<dynamic>)
          .map((category) => CategoryModel.fromJson(category))
          .toList());
    } catch (e) {
      if (e is AppException) {
        return Left(e);
      }
      return Left(AppException(e.toString()));
    }
  }
}
