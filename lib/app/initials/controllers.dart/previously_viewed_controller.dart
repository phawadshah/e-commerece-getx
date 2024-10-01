import 'package:get/get.dart';

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
  void onInit() {
    if (_authController.user != null) {
      _uid = _authController.user!.uid;
      _getItems();
    }
    super.onInit();
  }

  Future<void> _getItems() async {
    if (!isAuthenticated) return;
    previouslyViewedProducts.clear();
    previouslyViewedProducts.value =
        await _previouslyViewedService.getItems(uid);
  }

  Future<void> addViewedProduct(Product product) async {
    if (!isAuthenticated) return;
    previouslyViewedProducts.insert(0, product);
    await _previouslyViewedService.add(uid, product);
  }

  void clear() {
    previouslyViewedProducts.clear();
  }
}
