import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/common/widgets/loading.dart';

import '../../utils/constants/enums.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.showNoInternetWidget.value) {
          return Center(
            child: KErrorWidget(
              error: "No Internet Connection",
              onRetry: controller.onRetry,
            ),
          );
        } else if (controller.state == ControllerState.LOADING) {
          return const Center(child: KLoadingWidget());
        }
        return Center(
          child: Text(
            "Welcome",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        );
      }),
    );
  }
}
