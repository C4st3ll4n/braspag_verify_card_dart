import 'dart:convert';

import 'package:braspag_oauth_dart/braspag_oauth_dart.dart';
import 'package:braspag_oauth_dart/src/OAuthClient.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

main() {
  group("Testes de retorno da BraspagOAuth", () {
    final Dio dio = Dio();
    OAuthClient braspagOAuth;
    DioAdapterMock dioAdapterMock;

    setUp(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      braspagOAuth = OAuthClient(dio);
    });

    var id = "39fe0f51-e774-4390-86e7-d4b62a4b477a";
    var secret = "gglmf4ZCZjg6iVTHd1O1EnCuOfz/o/GUJp3rQ3dll9c=";

    var basicAuth = 'Basic ' + base64Encode(utf8.encode('$id:$secret'));

    final responsePayload = jsonEncode({
      "access_token": "eeeeeeeeeeeeeee",
      "token_type": "bearer",
      "expires_in": 1234,
    });

    //test simulated response payload
    test("Testes usando Mock", () async {
      when(dioAdapterMock.fetch(any, any, any)).thenAnswer(
          (_) async => ResponseBody.fromString(responsePayload, 400));

      when(dioAdapterMock.fetch(
              argThat(predicate<RequestOptions>((x) =>
                  x.baseUrl
                      .replaceAll("sandbox", "")
                      .contains("https://auth.braspag.com.br/") &&
                  x.path == "oauth2/token" &&
                  x.method == "POST" &&
                  x.headers["content-type"] ==
                      "application/x-www-form-urlencoded" &&
                  x.headers["authorization"] == basicAuth)),
              any,
              any))
          .thenAnswer((_) async =>
              ResponseBody.fromString(responsePayload, 200, headers: {
                Headers.contentTypeHeader: [Headers.jsonContentType],
              }));

      var response = await braspagOAuth.getAccessToken(
          clientId: id,
          clientSecret: secret,
          enviroment: OAuthEnviroment.SANDBOX);

      expect(response, isA<BraspagOAuth>());
    });

    //test sending all parameters
    test("Enviando Todos Parâmetros", () async {
      var response = await BraspagOAuth.getToken(
          clientId: id,
          clientSecret: secret,
          enviroment: OAuthEnviroment.SANDBOX);
      expect(response, isA<BraspagOAuth>());
    });

    //test sign key
    test("Testando chave de assinatura", () async {
      var token = basicAuth.replaceAll("Basic ", "");
      var jsonDec = utf8.decode(base64Decode(token));
      var split = jsonDec.split(":");
      var signGlobal = split[1];

      expect(signGlobal, secret);
    });

    //test not sending environment
    test("Não Enviando Ambiente", () async {
      var response =
          await BraspagOAuth.getToken(clientId: id, clientSecret: secret);
      expect(response, isA<BraspagOAuth>());
    });

    // calling production with sandbox credentials
    test("Credenciais de Sandbox chamando Produção", () async {
      var response = BraspagOAuth.getToken(
          clientId: id,
          clientSecret: secret,
          enviroment: OAuthEnviroment.PRODUCAO);
      expect(response, isA<Future<BraspagOAuth>>());
    });

    // error test client invalid
    test("Client Invalido", () async {
      var response = BraspagOAuth.getToken(clientId: "", clientSecret: "");
      expect(response, isA<Future<BraspagOAuth>>());
    });
  });
}
