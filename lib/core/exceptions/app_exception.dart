abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message, {super.code});
}

class ValidationException extends AppException {
  ValidationException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}
