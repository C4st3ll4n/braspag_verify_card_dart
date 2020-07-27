class VerifyCardRequest {
  String provider;
  CardConsultation card;

  VerifyCardRequest({this.provider, this.card});

  VerifyCardRequest.fromJson(Map<String, dynamic> json) {
    provider = json['Provider'];
    card = json['Card'] != null
        ? new CardConsultation.fromJson(json['Card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Provider'] = this.provider;
    if (this.card != null) {
      data['Card'] = this.card.toJson();
    }
    return data;
  }
}

class CardConsultation {
  String cardNumber;
  String holder;
  String expirationDate;
  String securityCode;
  String brand;
  String type;

  CardConsultation(
      {this.cardNumber,
      this.holder,
      this.expirationDate,
      this.securityCode,
      this.brand,
      this.type});

  CardConsultation.fromJson(Map<String, dynamic> json) {
    cardNumber = json['CardNumber'];
    holder = json['Holder'];
    expirationDate = json['ExpirationDate'];
    securityCode = json['SecurityCode'];
    brand = json['Brand'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CardNumber'] = this.cardNumber;
    data['Holder'] = this.holder;
    data['ExpirationDate'] = this.expirationDate;
    data['SecurityCode'] = this.securityCode;
    data['Brand'] = this.brand;
    data['Type'] = this.type;
    return data;
  }
}

class TypeCard {
  static final DEBIT_CARD = "DebitCard";
  static final CREDIT_CARD = "CreditCard";
}
