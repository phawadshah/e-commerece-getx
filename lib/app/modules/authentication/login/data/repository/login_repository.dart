import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/modules/authentication/login/data/models/login_model.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';
import 'package:shop/app/utils/services/configs/user_config.dart';

import '../../../../../utils/log/logger.dart';
import '../../../data/models/user.dart';

class LoginRepository {
  final UserController _userController;
  final AuthController _authController;
  final UserConfig _userConfig;

  LoginRepository({
    required UserController userController,
    required AuthController authController,
    required UserConfig userConfig,
  })  : _userController = userController,
        _authController = authController,
        _userConfig = userConfig;

  Future<Either<AppException, Either<AppException, bool>>> login(
      LoginModel user) async {
    try {
      fauth.UserCredential userCredential = await _authController.login(user);
      return Right(await getUser(userCredential));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  Future<Either<AppException, bool>> getUser(
      fauth.UserCredential userCredentials) async {
    try {
      User? results =
          await _userController.getUser(userCredentials.user!.uid).then(
        (user) async {
          _userController.user = user;
          await _userConfig.manageUserConfig();
          return user;
        },
      );
      return Right(results != null);
    } catch (e) {
      KLogger.error(e.toString());

      return Left(AppException(e.toString()));
    }
  }
}
