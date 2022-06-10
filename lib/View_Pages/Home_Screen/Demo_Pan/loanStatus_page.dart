import 'dart:convert';

LoanStatus loanStatusFromJson(String str) => LoanStatus.fromJson(json.decode(str));
String loanStatusToJson(LoanStatus data) => json.encode(data.toJson());
class LoanStatus {
  LoanStatus({
    this.loanpreapproved,
    this.loandisburse,
    this.loanrejected,
    this.recordTime,
  });
  bool loanpreapproved;
  bool loandisburse;
  bool loanrejected;
  int recordTime;
  factory LoanStatus.fromJson(Map<String, dynamic> json) => LoanStatus(
    loanpreapproved: json["loanpreapproved"],
    loandisburse: json["loandisburse"],
    loanrejected: json["loanrejected"],
    recordTime: json["recordTime"],
  );
  Map<String, dynamic> toJson() => {
    "loanpreapproved": loanpreapproved,
    "loandisburse": loandisburse,
    "loanrejected": loanrejected,
    "recordTime": recordTime,
  };
}
