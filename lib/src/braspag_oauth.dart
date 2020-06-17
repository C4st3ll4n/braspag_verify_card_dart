import 'package:braspag_oauth_dart/braspag_oauth_dart.dart';
import 'package:braspag_oauth_dart/src/braspag_oauth_api.dart';
import 'package:dio/dio.dart';

class BraspagOAuth {
  String accessToken;
  String tokenType;
  int expiresIn;

  BraspagOAuth({this.accessToken, this.tokenType, this.expiresIn});

  BraspagOAuth.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }

  static Future<BraspagOAuth> getToken(
      {String clientId,
      String clientSecret,
      Enviroment enviroment = Enviroment.SANDBOX}) async {
    Dio dio = Dio();
    return BraspagOAuthApi(dio).getAccessToken(
        clientId: clientId, clientSecret: clientSecret, enviroment: enviroment);
  }
}
