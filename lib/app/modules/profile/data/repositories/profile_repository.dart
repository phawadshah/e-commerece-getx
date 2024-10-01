import 'package:dartz/dartz.dart';
import 'package:shop/app/utils/services/auth_service.dart';

import '../../../../server/exceptions/app_exceptions.dart';

class ProfileRepository {
  final AuthService _authService;
  ProfileRepository({
    required AuthService authService,
  }) : _authService = authService;

  Future<Either<AppException, bool>> logout() async {
    try {
      return Right(await _authService.signOut());
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
