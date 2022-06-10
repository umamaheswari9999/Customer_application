class BankNameDetails {
  final String name;
  final String id;

  const BankNameDetails(
      {this.name,this.id});

  factory BankNameDetails.fromJson(Map<String, dynamic> json) => BankNameDetails(
    name: json["name"],
    id: json["id"],
   );
}
