class OAuthError {
  String error;
  String errorDescription;

  OAuthError({
    this.error,
    this.errorDescription,
  });

  factory OAuthError.fromJson(Map<String, dynamic> json) {
    return OAuthError(
        error: json['error'], errorDescription: json['error_description']);
  }

  Map<String, dynamic> toJson(OAuthError instance) => <String, dynamic>{
        'error': instance.error,
        'error_description': instance.errorDescription,
      };
}
