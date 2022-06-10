class bankexistingDetails {
  final String inpifsccode;
  final String inpbankbranch;
  final String inpbanknameId;
  final String inpmicr;

  const bankexistingDetails(
      {this.inpifsccode,this.inpbankbranch,this.inpbanknameId, this.inpmicr});

  factory bankexistingDetails.fromJson(Map<String, dynamic> json) => bankexistingDetails(
      inpifsccode: json["inpifsccode"],
      inpbankbranch: json["inpbankbranch"],
      inpbanknameId:json['inpbanknameId'],
      inpmicr: json["inpmicr"],);
}
