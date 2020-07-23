# OAUTH /braspag_oauth_dart

Library em Dart para auxiliar na obtenção do AccessToken para OAuth Braspag, podendo ser usada em Flutter ou Dart.

## Modo de uso

### Instalação

- Será necessário adicionar a seguinte dependência ao **pubspec.yaml** do seu projeto:

```yaml
    dependencies:
      braspag_oauth_dart: ^1.1.0
```

### Utilização
Para iniciar com o SDK será necessário importar o pacote abaixo.

```dart
import 'package:braspag_oauth_dart/oauth.dart';
```

Será necessário também informar *Client Id*, *Client Secret* e o *Ambiente*:

- **String Client Id** = Obrigatório.
- **String Client Secret** = Obrigatório.
- **OAuthEnviroment Enviroment** = Não Obrigatório, caso não seja informado o SDK ultilizará **SANDBOX**.

### Obtendo Token

```dart
 await BraspagOAuth.getToken(
      clientId: "CLIENT ID", clientSecret: "CLIENT SECRET", enviroment: OAuthEnviroment.SANDBOX);
```
### Detalhamento Retorno de Erro

No caso de erro será retornado um objeto do tipo **ErrorResponseOAuth**. 
No exemplo abaixo foi capturado usando um FutureBuilder ou StreamBuilder:

```dart
...
if (snapshot.hasError) {
                    ErrorResponseOAuth errors = snapshot.error;
                    print('StatusCode: ${errors.code}, '
                        'Message: ${errors.message} ');
                    return Container();
                    }
...
```
