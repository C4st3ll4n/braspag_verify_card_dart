class ErrorResponseOAuth implements Exception {
  final String code;
  final String message;

  ErrorResponseOAuth({this.code, this.message});
}
