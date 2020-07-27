class VerifyCardResponse {
  int status;
  String providerReturnCode;
  String providerReturnMessage;
  BinData binData;

  VerifyCardResponse(
      {this.status,
      this.providerReturnCode,
      this.providerReturnMessage,
      this.binData});

  VerifyCardResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    providerReturnCode = json['ProviderReturnCode'];
    providerReturnMessage = json['ProviderReturnMessage'];
    binData =
        json['BinData'] != null ? new BinData.fromJson(json['BinData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ProviderReturnCode'] = this.providerReturnCode;
    data['ProviderReturnMessage'] = this.providerReturnMessage;
    if (this.binData != null) {
      data['BinData'] = this.binData.toJson();
    }
    return data;
  }
}

class BinData {
  String provider;
  String cardType;
  bool foreignCard;
  String code;
  String message;
  bool corporateCard;
  String issuer;
  String issuerCode;
  String cardBin;
  String cardLast4Digits;

  BinData(
      {this.provider,
      this.cardType,
      this.foreignCard,
      this.code,
      this.message,
      this.corporateCard,
      this.issuer,
      this.issuerCode,
      this.cardBin,
      this.cardLast4Digits});

  BinData.fromJson(Map<String, dynamic> json) {
    provider = json['Provider'];
    cardType = json['CardType'];
    foreignCard = json['ForeignCard'];
    code = json['Code'];
    message = json['Message'];
    corporateCard = json['CorporateCard'];
    issuer = json['Issuer'];
    issuerCode = json['IssuerCode'];
    cardBin = json['CardBin'];
    cardLast4Digits = json['CardLast4Digits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Provider'] = this.provider;
    data['CardType'] = this.cardType;
    data['ForeignCard'] = this.foreignCard;
    data['Code'] = this.code;
    data['Message'] = this.message;
    data['CorporateCard'] = this.corporateCard;
    data['Issuer'] = this.issuer;
    data['IssuerCode'] = this.issuerCode;
    data['CardBin'] = this.cardBin;
    data['CardLast4Digits'] = this.cardLast4Digits;
    return data;
  }
}
