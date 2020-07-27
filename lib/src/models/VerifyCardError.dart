class VerifyCardError {
  int code;
  String message;

  VerifyCardError({
    this.code,
    this.message,
  });

  factory VerifyCardError.fromJson(Map<String, dynamic> json) {
    return VerifyCardError(
        code: json['Code'] as int, message: json['Message'] as String);
  }

  Map<String, dynamic> toJson(VerifyCardError instance) => <String, dynamic>{
        'Code': instance.code,
        'Message': instance.message,
      };
}
