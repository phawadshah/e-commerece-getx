import 'package:get/get.dart';
import 'package:shop/app/modules/categories/data/models/category.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/modules/products/data/repository/products_repository.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

class ProductsController extends GetxController with LoadingMixin {
  late int navigationId;
  late String tag;
  final ProductsRepository _productsRepository;
  ProductsController({
    required ProductsRepository productsRepository,
  }) : _productsRepository = productsRepository;

  RxList<Product> products = <Product>[].obs;
  RxString category = ''.obs;
  RxBool hasError = false.obs;
  RxString error = ''.obs;

  @override
  void onInit() async {
    _init();
    super.onInit();
  }

  void _init() async {
    try {
      final args = Get.arguments['category'] as CategoryModel;
      category.value = args.name;
      await fetchCategoryProducts(args.slug);
    } catch (e) {
      hasError(true);
      error("We are sorry for the inconvenience!\nKindly retry in a while");
    }
  }

  void onProductTap(Product product) {
    Get.toNamed(
      Routes.PRODUCTDETAILS,
      id: navigationId,
      arguments: {"product": product, "tag": "$tag/${product.id}"},
    );
  }

  void onRetry() async {
    hasError(false);
    error('');
    await fetchCategoryProducts(category.value);
  }

  Future fetchCategoryProducts(String category) async {
    final results = await executeWithLoading(
        delay: const Duration(milliseconds: 300),
        () => _productsRepository.fetchCategoryProduct(category));
    results.fold((e) {
      hasError(true);
      error(e.toString());
    }, (data) {
      products.value = data;
    });
  }
}
