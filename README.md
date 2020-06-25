# OAUTH /braspag_oauth_dart

Library em Dart para auxiliar na obtenção do AccessToken para OAuth Braspag, podendo ser usada em Flutter ou Dart.

## Instalação

- Será necessário adicionar a seguinte dependência ao **pubspec.yaml** do seu app:

```yaml
    dependencies:
      braspag_oauth_dart: ^1.0.0
```

## Caso de uso

### Exemplo de Utilização

Para utilizar do SDK será necessário informar client id, client secret (validos) e o ambiente:

**String client_id** = Obrigatorio.
**String client_secret** = Obrigatorio.
**Enviroment ambiente** = Não Obrigatorio, caso não seja informado o SDK ultilizará **SANDBOX**.

```dart
import 'package:braspag_oauth_dart/braspag_oauth_dart.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo OAuth Braspag',
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
                  clientId: "SEUCLIENTID",
                  clientSecret: "SEUCLIENTSECRET",
                  enviroment: Enviroment.SANDBOX),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text(
                          '${snapshot.error}');
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

```

**Observações**:

- Caso queira que o ambiente seja **PRODUÇÃO** é obrigatorio informar:

 enviroment: **Enviroment.PRODUCAO**


