import 'package:braspag_oauth_dart/oauth.dart';
import 'package:braspag_verify_card_dart/src/models/VerifyCardError.dart';
import 'package:braspag_verify_card_dart/verifycard.dart';
import 'package:dio/dio.dart';

class VerifyCardClient {
  Dio dio;
  VerifyCardClient({this.dio});

  Future<VerifyCardResponse> verify(
      {String clientId,
      String clientSecret,
      String merchantId,
      VerifyEnviroment enviroment,
      VerifyCardRequest request}) async {
    try {
      BraspagOAuth oAuth = enviroment == VerifyEnviroment.SANDBOX
          ? await BraspagOAuth.getToken(
              clientId: clientId,
              clientSecret: clientSecret,
              enviroment: OAuthEnviroment.SANDBOX)
          : await BraspagOAuth.getToken(
              clientId: clientId,
              clientSecret: clientSecret,
              enviroment: OAuthEnviroment.PRODUCAO);

      dio.options
        ..baseUrl = _baseUrl(enviroment)
        ..headers["content-type"] = "application/json"
        ..headers["merchantId"] = merchantId
        ..headers["authorization"] = 'Bearer ${oAuth.accessToken}';

      var response = await dio.post("v2/verifycard", data: request.toJson());

      return VerifyCardResponse.fromJson(response.data);
    } on ErrorResponseOAuth catch (e) {
      _getErrorOAuth(e);
    } on DioError catch (e) {
      _getErrorVerifyCard(e);
    }
    return null;
  }
}

String _baseUrl(VerifyEnviroment enviroment) {
  return enviroment == VerifyEnviroment.PRODUCAO
      ? "https://api.braspag.com.br/"
      : "https://apisandbox.braspag.com.br/";
}

ErrorResponse _getErrorOAuth(ErrorResponseOAuth e) {
  throw ErrorResponse(code: e.code, message: e.message);
}

ErrorResponse _getErrorVerifyCard(DioError e) {
  if (e.response.statusCode != 403) {
    _getErrorDio(e);
  } else {
    throw ErrorResponse(
        code: "${e.response.statusCode.toString()} ${e.response.statusMessage}",
        message: e.message);
  }
  return null;
}

ErrorResponse _getErrorDio(DioError e) {
  if (e?.response != null) {
    VerifyCardError errorsVerifyCard =
        VerifyCardError.fromJson(e.response.data[0]);

    throw ErrorResponse(
        code: "${e.response.statusCode.toString()} ${e.response.statusMessage}",
        message: errorsVerifyCard.message);
  } else {
    throw ErrorResponse(
        code: "${e.response.statusCode.toString()} ${e.response.statusMessage}",
        message: "Unknown Error");
  }
}
