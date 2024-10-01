import 'dart:async';

import 'package:get/get.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';

import '../../utils/pages/app_pages.dart';
import '../../utils/services/internet_conectivity.dart';

class SplashController extends GetxController with LoadingMixin {
  final Internet _internetConnectivity;

  SplashController({
    required Internet internetConnectivity,
  }) : _internetConnectivity = internetConnectivity;

  RxBool showNoInternetWidget = false.obs;

  @override
  void onInit() async {
    Timer(const Duration(seconds: 2), () {
      _init();
    });
    super.onInit();
  }

  void _init() {
    _internetConnectivity.isConnected
        ? Get.offNamed(Routes.BASE)
        : showNoInternetWidget(true);
  }

  void onRetry() async {
    showNoInternetWidget(false);
    await executeWithLoading(
        delay: const Duration(milliseconds: 400), () => _init());
  }
}
