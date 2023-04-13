class AuthException implements Exception {
  final dynamic message;

  const AuthException([this.message]);
}

class AuthStatusCodeException extends AuthException {
  const AuthStatusCodeException(this.statusCode, [dynamic message])
      : super(message);

  final int statusCode;
}
