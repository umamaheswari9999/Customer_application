class PermanentAddressDetails {
  final String addressLine1;
  final String addressLine2;
  final String cityName;
  final String country$_identifier;
  final String region$_identifier;

  const PermanentAddressDetails (
      {this.addressLine1,this.addressLine2,this.cityName,this.country$_identifier, this.region$_identifier});

  factory PermanentAddressDetails .fromJson(Map<String, dynamic> json) => PermanentAddressDetails(
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    cityName:json['cityName'],
    country$_identifier: json["country\$_identifier"],
    region$_identifier: json["region\$_identifier"],
  );
}
