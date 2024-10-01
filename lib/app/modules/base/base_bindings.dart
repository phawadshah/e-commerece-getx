import 'package:get/get.dart';
import 'package:shop/app/core/global/global.dart';
import 'package:shop/app/modules/base/base_controller.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController(
        userConfig: Get.find<UserConfig>(), navigatorKeys: navigatorKeys));
  }
}
