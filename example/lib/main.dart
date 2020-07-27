import 'package:braspag_verify_card_dart/verifycard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo VerifyCard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'VerifyCard Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<VerifyCardResponse>(
              future: sendCard(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      ErrorResponse errors = snapshot.error;
                      print("--------------------------------------");
                      print('Status => ${errors.code}');
                      print("Message => ${errors.message}");
                      print("--------------------------------------");
                      return Container();
                    } else {
                      return Column(
                        children: <Widget>[
                          Text("---------------------------------------"),
                          Text("Status: ${snapshot.data.status}"),
                          Text(
                              "ProviderReturnMessage: ${snapshot.data.providerReturnMessage}"),
                          Text(
                              "ProviderReturnCode: ${snapshot.data.providerReturnCode}"),
                          Text("---------------------------------------"),
                          Text("Bindata:"),
                          Text("Providers: ${snapshot.data.binData.provider}"),
                          Text("CardType: ${snapshot.data.binData.cardType}"),
                          Text("Code: ${snapshot.data.binData.code}"),
                          Text("Message: ${snapshot.data.binData.message}"),
                          Text(
                              "CorporateCard: ${snapshot.data.binData.corporateCard}"),
                          Text("Issuer: ${snapshot.data.binData.issuer}"),
                          Text(
                              "IssuerCode: ${snapshot.data.binData.issuerCode}"),
                          Text("CardBin: ${snapshot.data.binData.cardBin}"),
                          Text(
                              "CardLast4Digits: ${snapshot.data.binData.cardLast4Digits}"),
                          Text("---------------------------------------"),
                        ],
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<VerifyCardResponse> sendCard() async {
  var verifyCard = VerifyCard(
      clientId: "Client Id",
      clientSecret: "Client Secret",
      merchantId: "Merchant Id",
      enviroment: VerifyEnviroment.SANDBOX);

  return await verifyCard.verify(
      request: VerifyCardRequest(
          provider: "Cielo30",
          card: CardConsultation(
              cardNumber: "9876543210123456",
              holder: "Darth Vader",
              expirationDate: "01/2030",
              securityCode: "123",
              brand: "Visa",
              type: TypeCard.CREDIT_CARD)));
}
