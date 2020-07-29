import 'package:braspag_verify_card_dart/src/models/VerifyCardRequest.dart';
import 'package:braspag_verify_card_dart/verifycard.dart';
import 'package:test/test.dart';

main() {
  //TODO PLACE YOUR CREDENTIALS HERE

  var clientId = "client id";
  var clientSecret = "client secret";
  var merchantId = "merchant id";

  var verifyCard = VerifyCard(
      clientId: clientId,
      clientSecret: clientSecret,
      merchantId: merchantId,
      enviroment: VerifyEnviroment.SANDBOX);
  var request = VerifyCardRequest(
      provider: "Cielo30",
      card: CardConsultation(
          cardNumber: "9876543210123456",
          holder: "Darth Vader",
          expirationDate: "01/2030",
          securityCode: "123",
          brand: "Visa",
          type: TypeCard.CREDIT_CARD));

  group("correct credentials", () {
    VerifyCardResponse response;
    setUp(() async {
      response = await verifyCard.verify(request: request);
    });

    test('return verify response', () {
      expect(response, isA<VerifyCardResponse>());
    });

    test('return is not error response', () {
      expect(response, isNot(isA<ErrorResponse>()));
    });
  });

  group("icorrect credentials", () {
    var verifyCard = VerifyCard(
        clientId: "",
        clientSecret: "",
        merchantId: "",
        enviroment: VerifyEnviroment.SANDBOX);

    var requestEmpty = VerifyCardRequest();

    var requestComplete = VerifyCardRequest(
        provider: "Cielo30",
        card: CardConsultation(
            cardNumber: "9876543210123456",
            holder: "Darth Vader",
            expirationDate: "01/2030",
            securityCode: "123",
            brand: "Visa",
            type: TypeCard.CREDIT_CARD));

    test("not entering credentials", () async {
      try {
        await verifyCard.verify(request: requestComplete);
      } catch (e) {
        expect(e, isA<ErrorResponse>());
      }
    });

    test("Teste sem informacoes no request", () async {
      try {
        await verifyCard.verify(request: VerifyCardRequest());
      } catch (e) {
        expect(e, isA<ErrorResponse>());
      }
    });
  });
}
