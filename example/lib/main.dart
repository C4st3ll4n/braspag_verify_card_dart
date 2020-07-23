import 'package:braspag_oauth_dart/oauth.dart';
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
              future: getToken(
                  clientId: "CLIENT ID",
                  clientSecret: "CLIENT SECRET",
                  enviroment: OAuthEnviroment.SANDBOX),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      ErrorResponseOAuth errors = snapshot.error;
                      print("--------------------------------------");
                      print('Code => ${errors.code}');
                      print('Message: ${errors.message}');
                      print("--------------------------------------");
                      return Container();
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

Future<BraspagOAuth> getToken(
    {String clientId, String clientSecret, OAuthEnviroment enviroment}) async {
  return await BraspagOAuth.getToken(
      clientId: clientId, clientSecret: clientSecret, enviroment: enviroment);
}
