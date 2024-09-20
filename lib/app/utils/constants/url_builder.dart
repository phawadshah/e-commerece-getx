import 'package:shop/app/utils/constants/api_endpoints.dart';
import 'package:shop/app/utils/services/env_services.dart';

class UrlBuilder {
  final EnvServices _envService;
  UrlBuilder({
    required EnvServices envService,
  }) : _envService = envService;

  Uri buildUri({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri.https(
      _envService.baseUrl,
      endpoint,
      queryParameters,
    );
    return uri;
  }

  /// Fetch Laptops
  Uri laptops() {
    return buildUri(endpoint: ApiEndpoints.laptops);
  }

  /// Fetch Beauty
  Uri beauty() {
    return buildUri(endpoint: ApiEndpoints.beauty);
  }

  /// Fetch MenWatches
  Uri menWatches() {
    return buildUri(endpoint: ApiEndpoints.menWatches);
  }

  /// Fetch Furniture
  Uri furniture() {
    return buildUri(endpoint: ApiEndpoints.furniture);
  }

  /// Fetch Shoes
  Uri shoes() {
    return buildUri(endpoint: ApiEndpoints.shoes);
  }

  /// Fetch HomeDecor
  Uri homeDecor() {
    return buildUri(endpoint: ApiEndpoints.homeDecor);
  }

// Fetch All Products
  Uri allProducts() {
    return buildUri(endpoint: ApiEndpoints.allProducts);
  }

// Fetch All Categories
  Uri allCategories() {
    return buildUri(endpoint: ApiEndpoints.allCategories);
  }

  // Fetch SmartPhones
  Uri smartPhones() {
    return buildUri(endpoint: ApiEndpoints.smartPhones);
  }

  // Fetch Fragrances
  Uri fragrances() {
    return buildUri(endpoint: ApiEndpoints.fragrances);
  }

  // Fetch SkinCare
  Uri skinCare() {
    return buildUri(endpoint: ApiEndpoints.skinCare);
  }

  // Fetch Groceries
  Uri groceries() {
    return buildUri(endpoint: ApiEndpoints.groceries);
  }

  // Search Products
  Uri searchProducts(String query) {
    return buildUri(
        endpoint: ApiEndpoints.search, queryParameters: {"q": query});
  }

  // Get One Category
  Uri categoryProducts(String category) {
    return buildUri(endpoint: "${ApiEndpoints.categoryProducts}/$category");
  }

  // Get One Product
  Uri product(int productId) {
    return buildUri(endpoint: "${ApiEndpoints.allProducts}/$productId");
  }
}
