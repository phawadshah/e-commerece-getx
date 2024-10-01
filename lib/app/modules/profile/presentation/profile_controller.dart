import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/error_dialog.dart';
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/modules/authentication/data/models/user.dart';
import 'package:shop/app/utils/log/logger.dart';
import 'package:shop/app/utils/mixins/loading_mixin.dart';
import 'package:shop/app/utils/pages/app_pages.dart';

import '../data/repositories/profile_repository.dart';

class ProfileController extends GetxController with LoadingMixin {
  final ProfileRepository _profileRepository;
  final AuthController _authController;
  final UserController _userController;

  ProfileController({
    required ProfileRepository profileRepository,
    required AuthController authController,
    required UserController userController,
  })  : _profileRepository = profileRepository,
        _authController = authController,
        _userController = userController;

  late User user;
  Rx<bool> isLoggedIn = false.obs;

  @override
  void onInit() {
    KLogger.debug(
        "profile controller init called :: ${_userController.user.name}");
    user = _userController.user;
    isLoggedIn.value = _authController.isAuthenticated.value;
    _authController.isAuthenticated.listen((value) {
      KLogger.debug("is logged in :: $value");
      isLoggedIn.value = value;
    });
    super.onInit();
  }

  void onLoginTap() {
    Get.toNamed(Routes.LOGIN);
  }

  void onItemTap(int index) async {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        await _logout();
        break;
    }
  }

  Future<void> _logout() async {
    final results = await executeWithLoading(
        delay: const Duration(milliseconds: 700),
        () => _profileRepository.logout());
    results.fold((error) {
      kErrorDialog(Get.context!, error.toString());
    }, (data) {
      _authController.clear();
      _userController.clear();
    });
  }

  List<String> titles = [
    "Settings",
    "Help",
    "About",
    "Logout",
  ];

  List<IconData> icons = [
    Icons.settings,
    Icons.help,
    Icons.info,
    Icons.logout,
  ];
}
