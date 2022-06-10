class Details {
  final String lDSName;
  final String prooftypenumber;
  final String addressLine1;
  final String addressLine2;
  final String cityName;
  final String postalCode;
  final String phone;
  final String gender;
  final String aadhaarnumber;
  final String panno;
  final String region$_identifier;
  final String country$_identifier;
  final String identifier;
  const Details(
      {this.lDSName,this.prooftypenumber,this.addressLine1,this.phone, this.gender, this.aadhaarnumber, this.panno,this.addressLine2,
        this.cityName,this.postalCode,this.region$_identifier,this.country$_identifier,this.identifier});

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        lDSName: json["lDSName"],
    prooftypenumber: json["prooftypenumber"],
    addressLine1:json['addressLine1'],
    addressLine2: json["addressLine2"],
        phone: json["phone"],
        gender: json["gender"],
        aadhaarnumber: json["aadhaarnumber"],
        panno: json["panno"],
    cityName: json["cityName"],
      postalCode:json['postalCode'],
      region$_identifier:json['region\$_identifier'],
      country$_identifier:json['country\$_identifier'],
      identifier:json['_identifier']


      );
}
