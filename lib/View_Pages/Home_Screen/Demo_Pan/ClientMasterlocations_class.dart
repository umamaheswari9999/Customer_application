import 'dart:convert';

import 'currentAddress_class.dart';
ClientMaster_Locations currentAddressFromJson(String str) => ClientMaster_Locations.fromJson(json.decode(str));
String currentAddressToJson(ClientMaster_Locations data) => json.encode(data.toJson());
class ClientMaster_Locations {
  ClientMaster_Locations({
    this.currentAddress,

  });
  CurrentAddress currentAddress;



  factory ClientMaster_Locations.fromJson(Map<String, dynamic> json) => ClientMaster_Locations(
    currentAddress: json["currentAddress"],

  );

  Map<String, dynamic> toJson() => {
    "permanentAddress": currentAddress,


  };
}
