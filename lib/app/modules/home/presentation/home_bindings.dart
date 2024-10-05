import 'package:get/get.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';
import 'package:shop/app/utils/services/internet_conectivity.dart';

import '../../../server/api_base_helper.dart';
import '../../../utils/constants/url_builder.dart';

import '../data/repositories/home_repository.dart';
import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(
      () => HomeRepository(
        apiBaseHelper: Get.find<ApiBaseHelper>(),
        urlBuilder: Get.find<UrlBuilder>(),
      ),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(
        homeRepository: Get.find<HomeRepository>(),
        userConfig: Get.find<UserConfig>(),
        internetConnectivity: Get.find<Internet>(),
      ),
    );
  }
}
