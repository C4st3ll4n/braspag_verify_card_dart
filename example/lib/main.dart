import 'package:braspag_oauth_dart/braspag_oauth_dart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo OAuth Braspag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<BraspagOAuth>(
              future: BraspagOAuth.getToken(
                  clientId: "SEU CLIENT ID",
                  clientSecret: "SEU CLIENT SECRET",
                  enviroment: OAuthEnviroment.SANDBOX),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      OAuthException errors = snapshot.error;
                      print("--------------------------------------");
                      print('Status => ${errors.message}');
                      print(
                          'Retorno OAuth => Error: ${errors.errorsOAuth.error}, Error Description: ${errors.errorsOAuth.errorDescription}');
                      print("--------------------------------------");
                      return Center(
                        child: Column(
                          children: <Widget>[
                            Text('Status => ${errors.message}'),
                            Text(
                                'Retorno OAuth => Error: ${errors.errorsOAuth.error}, Error Description: ${errors.errorsOAuth.errorDescription}'),
                          ],
                        ),
                      );
                    } else
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Access Token: ${snapshot.data.accessToken}'),
                            Text('TokenType: ${snapshot.data.tokenType}'),
                            Text('ExpiresIn: ${snapshot.data.expiresIn}'),
                          ],
                        ),
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
