import 'dart:convert';

import 'package:braspag_oauth_dart/src/braspag_oauth.dart';
import 'package:braspag_oauth_dart/src/braspag_oauth_enviroment.dart';
import 'package:dio/dio.dart';

class BraspagOAuthApi {
  Dio dio;
  BraspagOAuthApi(this.dio);

  Future<BraspagOAuth> getAccessToken(
      {String clientId, String clientSecret, Enviroment enviroment}) async {
    try {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));

      Map<String, String> body = {'grant_type': 'client_credentials'};

      dio.options
        ..baseUrl = baseUrl(enviroment)
        ..headers["content-type"] = "application/x-www-form-urlencoded"
        ..headers["authorization"] = basicAuth;

      var response = await dio.post("oauth2/token", data: body);

      return BraspagOAuth.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        return Future.error(e.response);
      } else {
        return Future.error("Falha ao obter credenciais.");
      }
    }
  }
}

String baseUrl(Enviroment enviroment) {
  return enviroment == Enviroment.PRODUCAO
      ? "https://auth.braspag.com.br/"
      : "https://authsandbox.braspag.com.br/";
}
