import 'package:get/get.dart';
import 'package:shop/app/modules/search/data/repository/search_repository.dart';
import 'package:shop/app/modules/search/services/search_service.dart';

import '../../../server/api_base_helper.dart';
import '../../../utils/constants/url_builder.dart';
import '../../../utils/services/local_storage_service.dart';
import 'search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchService>(
      () => SearchService(
        localStorageService: Get.find<LocalStorageService>(),
      ),
    );
    Get.lazyPut<SearchRepository>(
      () => SearchRepository(
        apiBaseHelper: Get.find<ApiBaseHelper>(),
        urlBuilder: Get.find<UrlBuilder>(),
      ),
    );
    Get.lazyPut<SearchControllerr>(
      () => SearchControllerr(
        searchRepository: Get.find<SearchRepository>(),
        searchService: Get.find<SearchService>(),
      ),
    );
  }
}
