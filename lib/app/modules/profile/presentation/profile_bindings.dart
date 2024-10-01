import 'package:get/get.dart';
import 'package:shop/app/modules/profile/data/repositories/profile_repository.dart';
import '../../../initials/controllers.dart/auth_controller.dart';
import '../../../initials/controllers.dart/user_controller.dart';
import '../../../utils/services/auth_service.dart';
import 'profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(
      () => ProfileRepository(
        authService: Get.find<AuthService>(),
      ),
    );
    Get.lazyPut<ProfileController>(() => ProfileController(
          profileRepository: Get.find<ProfileRepository>(),
          authController: Get.find<AuthController>(),
          userController: Get.find<UserController>(),
        ));
  }
}
