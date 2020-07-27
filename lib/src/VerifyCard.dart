import 'package:braspag_verify_card_dart/src/network/VerifyCardClient.dart';
import 'package:dio/dio.dart';

import '../verifycard.dart';

class VerifyCard {
  String clientId;
  String clientSecret;
  String merchantId;
  VerifyEnviroment enviroment;

  VerifyCard(
      {this.clientId,
      this.clientSecret,
      this.merchantId,
      this.enviroment = VerifyEnviroment.SANDBOX});

  Future<VerifyCardResponse> verify({VerifyCardRequest request}) {
    Dio dio = Dio();
    VerifyCardClient verifyCard = VerifyCardClient(dio: dio);
    return verifyCard.verify(
        clientId: clientId,
        clientSecret: clientSecret,
        merchantId: merchantId,
        request: request,
        enviroment: enviroment);
  }
}
