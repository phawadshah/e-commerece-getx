import '../../utils/constants/error_texts.dart';

class AppException implements Exception {
  final String? message;

  AppException(this.message);

  @override
  String toString() {
    return "$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(
      [String super.message = ErrorTexts.errorDuringCommunication]);
}

class BadRequestException extends AppException {
  BadRequestException([String super.message = ErrorTexts.invalidRequest]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String super.message = ErrorTexts.unauthorised]);
}

class InvalidInputException extends AppException {
  InvalidInputException([String super.message = ErrorTexts.invalidInput]);
}

class InvalidCredentialsException extends AppException {
  InvalidCredentialsException(
      [String super.message = ErrorTexts.invalidCredentials]);
}

class NoInternetConnectionException extends AppException {
  NoInternetConnectionException(
      [String super.message = ErrorTexts.noInternetConnection]);
}

class ResourceNotFoundException extends AppException {
  ResourceNotFoundException(
      [String super.message = ErrorTexts.resourceNotFound]);
}

class TimeoutException extends AppException {
  TimeoutException([String super.message = ErrorTexts.timeout]);
}

class SomethingWentWrongException extends AppException {
  SomethingWentWrongException(
      [String super.message = ErrorTexts.somethingWentWrong]);
}

class NoPermissionException extends AppException {
  NoPermissionException([String super.message = ErrorTexts.noPermission]);
}

class ApiConnectionException extends AppException {
  ApiConnectionException(
      [String super.message = ErrorTexts.apiConnectionError]);
}

class InvalidResponseException extends AppException {
  InvalidResponseException([String super.message = ErrorTexts.invalidResponse]);
}
