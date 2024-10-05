import 'package:shop/app/utils/constants/error_texts.dart';

class AuthExceptions implements Exception {
  final String code;
  final String message;

  AuthExceptions(this.code, this.message);

  @override
  String toString() {
    switch (code) {
      case 'network-request-failed':
        return ErrorTexts.noInternetConnection;
      case 'invalid-credential':
        return ErrorTexts.invalidCredentials;
      case 'wrong-password':
        return ErrorTexts.wrongPasswordProvided;
      case 'invalid-email':
        return ErrorTexts.invalidEmail;
      case 'user-disabled':
        return ErrorTexts.userNotFound;
      case 'user-not-found':
        return ErrorTexts.userNotFound;
      case 'email-already-in-use':
        return ErrorTexts.emailAlreadyExists;
      case 'operation-not-allowed':
        return ErrorTexts.operationNotAllowed;
      default:
        return message;
    }
  }
}
