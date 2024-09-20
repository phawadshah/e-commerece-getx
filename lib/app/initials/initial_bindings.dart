import 'package:get/get.dart';
import 'package:shop/app/core/configs/user_config.dart';
import 'package:shop/app/utils/services/env_services.dart';
import 'package:shop/app/utils/services/internet_conectivity.dart';
import 'package:shop/app/utils/services/local_storage_service.dart';

class InitialBindings {
  Future<void> initInitials() async {
    /// ======== Env Services ==========
    Get.lazyPut<EnvServices>(() => EnvServices());
    await Get.find<EnvServices>().loadEnv();

    /// ======== Env Services ==========
    Get.lazyPut<LocalStorageService>(() => LocalStorageService());
    await Get.find<LocalStorageService>().initStorage();

    /// ======== User Config ==========
    Get.put<UserConfig>(
      UserConfig(localStorageService: Get.find<LocalStorageService>()),
    );

    /// ======== Internet Conectivity ==========
    Get.lazyPut<InternetConnectivity>(() => InternetConnectivity());
  }
}
