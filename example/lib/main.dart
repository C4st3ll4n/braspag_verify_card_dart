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
                  clientId: "CLIENT ID",
                  clientSecret: "CLIENT SECRET",
                  enviroment: Enviroment.SANDBOX),
              builder: (context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    else
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
