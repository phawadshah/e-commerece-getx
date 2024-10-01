import 'package:get/get.dart';
import 'package:shop/app/utils/log/logger.dart';

import '../../modules/home/data/models/product.dart';
import '../../utils/services/previously_viewed_service.dart';
import 'auth_controller.dart';

class PreviouslyViewedController extends GetxController {
  final AuthController _authController;
  final PreviouslyViewedService _previouslyViewedService;

  PreviouslyViewedController({
    required AuthController authController,
    required PreviouslyViewedService previouslyViewedService,
  })  : _authController = authController,
        _previouslyViewedService = previouslyViewedService;

  late String _uid;
  String get uid => _uid;
  bool get isAuthenticated => _authController.isAuthenticated.value;
  RxList<Product> previouslyViewedProducts = <Product>[].obs;

  @override
  void onInit() async {
    await loadPreviouslyViewedItems();
    super.onInit();
  }

  Future<void> loadPreviouslyViewedItems() async {
    clear();
    if (_authController.user != null) {
      KLogger.debug("Fetching previously viewed items");
      _uid = _authController.user!.uid;
      await _getItems();
    }
  }

  Future<void> _getItems() async {
    if (!isAuthenticated) return;
    previouslyViewedProducts.clear();
    previouslyViewedProducts.value =
        await _previouslyViewedService.getItems(uid);
  }

  Future<void> addViewedProduct(Product product) async {
    if (!isAuthenticated) return;
    previouslyViewedProducts.add(product);
    await _previouslyViewedService.add(uid, product);
  }

  void clear() {
    previouslyViewedProducts.clear();
  }
}
