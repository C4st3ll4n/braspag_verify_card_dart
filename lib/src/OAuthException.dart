import 'package:braspag_oauth_dart/src/OAuthError.dart';

class OAuthException implements Exception {
  final OAuthError errorsOAuth;
  final String message;

  OAuthException(this.errorsOAuth, this.message);
}
