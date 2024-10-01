import 'package:get/get.dart';

import '../../utils/services/internet_conectivity.dart';
import 'splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(
      internetConnectivity: Get.find<Internet>(),
    ));
  }
}
