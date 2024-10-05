import 'package:get/get.dart';
import 'package:shop/app/modules/authentication/sign_up/data/repository/signup_repository.dart';
import '../../../../initials/controllers.dart/auth_controller.dart';
import '../../../../initials/controllers.dart/user_controller.dart';
import '../../../../utils/services/configs/user_config.dart';
import 'sign_up_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupRepository>(
      () => SignupRepository(
        authController: Get.find<AuthController>(),
        userController: Get.find<UserController>(),
        userConfig: Get.find<UserConfig>(),
      ),
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(
        signupRepository: Get.find<SignupRepository>(),
      ),
    );
  }
}
