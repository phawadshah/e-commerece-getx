class AppException {
  final String message;
  AppException(this.message);
  @override
  String toString() {
    return message;
  }
}

class FetchDataException extends AppException {
  FetchDataException(super.message);
}

class BadRequestException extends AppException {
  BadRequestException(super.message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException(super.message);
}

class InvalidInputException extends AppException {
  InvalidInputException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class ClientException extends AppException {
  ClientException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.message);
}

class ApiConnectionException extends AppException {
  ApiConnectionException(super.message);
}
