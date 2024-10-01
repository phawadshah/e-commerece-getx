import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:shop/app/initials/controllers.dart/auth_controller.dart';
import 'package:shop/app/initials/controllers.dart/user_controller.dart';
import 'package:shop/app/modules/authentication/login/data/models/login_model.dart';
import 'package:shop/app/server/exceptions/app_exceptions.dart';

import '../../../../../utils/log/logger.dart';
import '../../../data/models/user.dart';

class LoginRepository {
  final UserController _userController;
  final AuthController _authController;

  LoginRepository({
    required UserController userController,
    required AuthController authController,
  })  : _userController = userController,
        _authController = authController;

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
      User? results = await _userController
          .getUser(userCredentials.user!.uid)
          .then((user) => _userController.user = user);
      return Right(results != null);
    } catch (e) {
      KLogger.error(e.toString());

      return Left(AppException(e.toString()));
    }
  }
}
