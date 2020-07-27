# Verify Card

Para consultar dados de um cartão, é necessário fazer um POST no serviço VerifyCard. O VerifyCard é composto por dois serviços: Zero Auth e Consulta BIN. O Zero Auth é um serviço que indentifica se um cartão é válido ou não, através de uma operação semelhante a uma autorização, porém com valor de R$ 0,00. A Consulta BIN é um serviço disponível para clientes Cielo 3.0 que retorna as características do BIN tais como bandeira e tipo do cartão, a partir do BIN (6 primeiros dígitos do cartão). Os dois serviços podem ser consumidos simultaneamente através do VerifyCard, conforme o exemplo baixo. Também é possível que o processo de autorização seja condicionado automaticamente a um retorno de sucesso do ZeroAuth. Para habilitar este fluxo, por favor, entre em contato com nosso time de suporte.

## Instalação

- Será necessário adicionar a seguinte dependência ao **pubspec.yaml** do seu app:

```yaml
    dependencies:
      braspag_verify_card_dart: ^1.0.0
```

## Modo de uso

Para iniciar o cliente do SDK será necessário informar *Client id*, *Client secret*, *Merchant Id* e o *Ambiente*:
- **String Client Id** = Obrigatório.
- **String Client Secret** = Obrigatório.
- **String Merchant Id** = Obrigatório.
- **VerifyEnviroment enviroment** = Não Obrigatório, caso não seja informado o SDK ultilizará **SANDBOX**.

Instancie **VerifyCard** como exemplo abaixo:

```dart
var verifyCard = VerifyCard(
        clientId: "CLIENT ID",
        clientSecret: "CLIENT SECRET",
        merchantId: "MERCHANT ID",
        enviroment: VerifyEnviroment.SANDBOX);
```

### Requisição

- **String CardNumber** = Obrigatório.
- **String Holder** = Obrigatório.
- **String ExpirationDate** = Obrigatório.
- **String SecurityCode** = Obrigatório.
- **String Brand** = Obrigatório.
- **TypeCard Type** = Obrigatório.

```dart
await verifyCard.verify(
      request: VerifyCardRequest(
        provider: "Cielo30",
        card: CardConsultation(
            cardNumber: "5266135176906859",
            holder: "Darth Vader",
            expirationDate: "01/2030",
            securityCode: "123",
            brand: "Visa",
            type: TypeCard.CREDIT_CARD),
      ),
    );
```
### Detalhamento Retorno de Erro

No caso de erro será retornado um objeto do tipo **ErrorResponse**. 
No exemplo abaixo foi capturado usando um FutureBuilder ou StreamBuilder:

```dart
...
if (snapshot.hasError) {
                    ErrorResponse errors = snapshot.error;
                    print('StatusCode: ${errors.code}, '
                        'Message: ${errors.message} ');
                    return Container();
                    }
...
```

## Manual

Para mais informações sobre a integração com o VerifyCard, vide o manual em: [Verify Card](https://braspag.github.io//manual/braspag-verify-card)
