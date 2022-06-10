class getDraftloandetails {
  final String loanno;

  const getDraftloandetails({this.loanno});

  factory getDraftloandetails.fromJson(Map<String, dynamic> json) => getDraftloandetails(
    loanno: json["loanno"],
  );
}
