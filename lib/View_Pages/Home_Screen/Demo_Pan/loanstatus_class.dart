class draftLoannoInformation {
  String customername;
  String mobilenumber;
  String prooftypenumber;
  String loanno;
  String lDSApploanstatus;


  draftLoannoInformation({
    this.customername,
    this.mobilenumber,
    this.prooftypenumber,
    this.loanno,
    this.lDSApploanstatus


  });
  factory draftLoannoInformation.fromJson(Map<String, dynamic> json) {
    var additionalFieldValue="";


    return draftLoannoInformation(

        customername:json['customername'],
        mobilenumber:json['mobilenumber'],
        prooftypenumber:json['prooftypenumber'],
        loanno:json['loanno'],
        lDSApploanstatus:json['lDSApploanstatus']

      //id1:json['bankname\u{0024}_identifier']
    );
  }
}