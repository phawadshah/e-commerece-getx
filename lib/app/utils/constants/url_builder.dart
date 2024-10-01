import 'package:get/get.dart';
import 'package:shop/app/utils/constants/api_endpoints.dart';
import 'package:shop/app/utils/services/env_service.dart';

class UrlBuilder extends GetxService {
  final EnvService _envService;
  UrlBuilder({
    required EnvService envService,
  }) : _envService = envService;

  Uri buildUri({
    String? baseUrl,
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri.https(
      baseUrl ?? _envService.baseUrl,
      endpoint,
      queryParameters,
    );
    return uri;
  }

// Fetch All Products
  Uri allProducts({int limit = 10}) {
    return buildUri(
      endpoint: ApiEndpoints.ALL_PRODUCTS,
      queryParameters: {"limit": limit.toString()},
    );
  }

// Fetch All Categories
  Uri allCategories() {
    return buildUri(endpoint: ApiEndpoints.ALL_CATEGORIES);
  }

  // Search Products
  Uri searchProducts(String query) {
    return buildUri(
        endpoint: ApiEndpoints.SEARCH, queryParameters: {"q": query});
  }

  // Get One Category
  Uri categoryProducts(String category) {
    return buildUri(endpoint: "${ApiEndpoints.CATEGORY_PRODUCTS}/$category");
  }

  // Get One Product
  Uri product(int productId) {
    return buildUri(endpoint: "${ApiEndpoints.ALL_PRODUCTS}/$productId");
  }
}
