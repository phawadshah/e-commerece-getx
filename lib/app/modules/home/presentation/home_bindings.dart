import 'package:get/get.dart';
import 'package:shop/app/core/configs/user_config.dart';

import '../../../server/api_base_helper.dart';
import '../../../utils/constants/url_builder.dart';
import '../../../utils/services/env_services.dart';
import '../data/repositories/home_repository.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(
        apiBaseHelper: ApiBaseHelper(),
        userConfig: Get.find<UserConfig>(),
        urlBuilder: UrlBuilder(
          envService: Get.find<EnvServices>(),
        ),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        homeRepository: Get.find<HomeRepository>(),
        userConfig: Get.find<UserConfig>(),
      ),
    );
  }
}
