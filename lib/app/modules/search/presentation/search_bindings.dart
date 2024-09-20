import 'package:get/get.dart';
import 'package:shop/app/modules/search/data/repository/search_repository.dart';
import 'package:shop/app/utils/services/env_services.dart';

import '../../../server/api_base_helper.dart';
import '../../../core/configs/user_config.dart';
import '../../../utils/constants/url_builder.dart';
import 'search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchRepository>(
      () => SearchRepository(
        apiBaseHelper: ApiBaseHelper(),
        urlBuilder: UrlBuilder(
          envService: Get.find<EnvServices>(),
        ),
      ),
    );
    Get.lazyPut<SearchControllerr>(() => SearchControllerr(
          searchRepository: Get.find<SearchRepository>(),
          userConfig: Get.find<UserConfig>(),
        ));
  }
}
