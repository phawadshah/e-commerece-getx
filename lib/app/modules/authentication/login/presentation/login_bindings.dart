import 'package:get/get.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/modules/authentication/login/data/repository/login_repository.dart';
import '../../../../initials/controllers.dart/auth_controller.dart';
import '../../../../utils/services/user_service.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepository(
          authController: Get.find<AuthController>(),
          userController: Get.find<UserController>(),
        ));
    Get.lazyPut<LoginController>(() => LoginController(
          loginRepository: Get.find<LoginRepository>(),
        ));
  }
}
