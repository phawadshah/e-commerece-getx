import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/modules/authentication/sign_up/data/model/singup_model.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import '../../../../../utils/services/configs/user_config.dart';
import '../../../data/models/user.dart';

/* 
THIS REPO WILL DEAL BETWEEN THE SERVICES AND THE CONTROLLER
WE WILL BE INJECTING AUTHSERVICE AND USERSERVICE
THIS REPO WILL ONLY BE INJECTED TO SIGNUP CONTROLLER
*/
class SignupRepository {
  final AuthController _authController;
  final UserController _userController;
  final UserConfig _userConfig;

  SignupRepository({
    required AuthController authController,
    required UserController userController,
    required UserConfig userConfig,
  })  : _authController = authController,
        _userController = userController,
        _userConfig = userConfig;

  Future<Either<dynamic, Either<AppException, bool>>> singUp(
    SingupModel user,
  ) async {
    try {
      fauth.UserCredential response = await _authController.singup(user);
      return Right(
          await registerUser(User.fromCredentials(response, user.name!)));
    } catch (e) {
      return Left(e);
    }
  }

  Future<Either<AppException, bool>> registerUser(User user) async {
    try {
      return Right(await _userController.createNewUser(user).then(
        (value) async {
          _userController.user = user;
          await _userConfig.manageUserConfig();
          return value;
        },
      ));
    } catch (e) {
      /* IF THE USER GETS AUTHENTICATED BUT CANNOT BE ADDED TO THE DATABASE
      THE USER WILL BE DELETED FROM THE AUTHENTICATION SERVICE TOO
      */
      // await _authController.deleteUser(user);
      return Left(AppException(e.toString()));
    }
  }
}
