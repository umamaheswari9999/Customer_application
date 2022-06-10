import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/Static_classgender.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/bankNameclass.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/bankdetailsexistingUser_Class.dart';
import 'dart:convert';
import '../Pan_details/CustomInputBox.dart';
class AddingBANKdetails extends StatefulWidget {
  final String id;
  const AddingBANKdetails({Key key, this.id}) : super(key: key);
  Future<bankexistingDetails> fetchBankDetails(
      String Username, Password, ifsccode) async {
    // URL
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    final String url =
        'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchBankDetails';
    // METHOD: POST
    // REQUEST BODY
    final String requestBody = json.encode({
      "data": {"ifscCode": ifsccode}
    });
    print(ifsccode);
    print("values here");
    // API CALL
    final result = await http.post(Uri.parse(url), body: requestBody, headers: headers);
    // RESPONSE
    bankexistingDetails bed;
    if (result.statusCode == 200) {
      var responseBody = result.body;
      var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
      print(jsonResponse['response']);
      bed = bankexistingDetails.fromJson(jsonResponse['response']);
      return bed;}}
  @override
  _AddingBANKdetailsState createState() => _AddingBANKdetailsState();
}class _AddingBANKdetailsState extends State<AddingBANKdetails> {
  bool _isLoading = false;
  List<bankexistingDetails> listofDetails = [];
  TextEditingController BankController = TextEditingController();
  TextEditingController AccountnumberController = TextEditingController();
  TextEditingController AccounttypeController = TextEditingController();
  TextEditingController IfscCodeController = TextEditingController();
  TextEditingController MICRNumberController = TextEditingController();
  TextEditingController BranchController = TextEditingController();
  bool isExist = false;
  String _selectedbank;
  String _selectedaccounttype = null;
  List banknamesId = [];
  List<BankNameDetails> Banknamesdetails=[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Banknames('Appal', 'welcome').then((value) {
        Banknamesdetails = value;
        setState(() {});
      });
    });
    _selectedaccounttype=StaticData.accountTypes[1].title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.arrow_back_outlined),
                            highlightColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Text(
                            'Add Bank details',
                            style: TextStyle(
                              fontFamily: 'Cardo',
                              fontSize: 35,
                              color: Color(0xff0C2551),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyCustomInputBox(
                      onChanged: (text) {
                        IfscCodeController.text = text.toUpperCase();
                        final val = TextSelection.collapsed(
                            offset: IfscCodeController.text.length);
                        IfscCodeController.selection = val;
                        setState(() {});
                        if (text.length == 11) {
                          widget
                              .fetchBankDetails(
                                  'Appal', 'welcome', IfscCodeController.text)
                              .then((value) {
                            if (value != null) {
                              print(value.inpmicr);
                              setState(() {
                                BranchController.text = value.inpbankbranch;
                                MICRNumberController.text = value.inpmicr;
                                _selectedbank=Banknamesdetails.where((element) => element.id==value.inpbanknameId).first.id;


                              });
                            } else {
                              BranchController.text = '';
                              MICRNumberController.text = '';
                            }
                          });
                        } else {
                          BranchController.text = '';
                          MICRNumberController.text = '';
                        }
                      },
                      label: 'IFSC CODE',
                      inputHint: 'IFSC CODE',
                      inputFieldController: IfscCodeController,
                    ),
                    MyCustomInputBox(
                      onChanged: (text) {
                        final val = TextSelection.collapsed(
                            offset: AccountnumberController.text.length);
                        AccountnumberController.selection = val;
                        setState(() {});
                      },
                      label: 'ACCOUNT NUMBER',
                      inputHint: 'Account Number',
                      inputFieldController: AccountnumberController,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              isDense: true,
                              hint: Text("Account Type"),
                              value: _selectedaccounttype,
                              items: StaticData.accountTypes.map((occupations) {
                                return DropdownMenuItem(
                                    value: occupations.id,
                                    child: Text(occupations.title));
                              }).toList(),
                              onChanged: (value) {
                                // snapshot.data.where((element) => element.emiduedate);
                                setState(() {
                                  _selectedaccounttype = value;
                                });
                                print(_selectedaccounttype);
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'BRANCH NAME',
                      inputHint: 'Branch Name',
                      inputFieldController: BranchController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                              isDense: true,
                              hint: Text("BANK NAME"),
                              value: _selectedbank,
                              items: Banknamesdetails.map((bank) {
                                return DropdownMenuItem<String>(
                                    value: bank.id,
                                    child: Text(
                                      bank.name,
                                    ));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedbank = value;
                                  print(_selectedbank);
                                  //  print(totalRows);
                                });
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'MICR CODE',
                      inputHint: 'Micr Code',
                      inputFieldController: MICRNumberController,
                    ),
                    //
                    SizedBox(height: 10),
                    Container(
                      width: 340,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'ADD BANK ACCOUNT',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        onPressed: () {
                          print(widget.id);
                          _Updatingbankdetailsfornewaccount('Appal', 'welcome', widget.id);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<BankNameDetails>> Banknames(String Username, Password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    final response2 = await http.get(
        Uri.parse(
            "https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/FIN_Financial_Account"),
        headers: headers);
    List<BankNameDetails> banknamedetails = [];
    if (response2.statusCode == 200) {
      final responsebody2 = jsonDecode(response2.body) as Map<String, dynamic>;
      print(responsebody2);
      final res2 = responsebody2['response'] as Map<String, dynamic>;
      for (var record in res2['data']) {
        var bankNameDetails = BankNameDetails.fromJson(record);
        banknamedetails.add(bankNameDetails);
      }
      print(banknamedetails.length);
      return banknamedetails;
    } else {
      throw Exception('Failed to load album');
    }
  }
  /// for adding new bank account
  Future<bool> _Updatingbankdetailsfornewaccount(String Username, Password, id) async {
    print("Status is Updated");
print(id);
print(_selectedbank);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse('https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.addBank'));
    request.body = json.encode({
      "data": {"data": {
          "preEnquiryFormId":id,
          "accnumber": AccountnumberController.text,
          "acctype": "Saving",
          "ifsccode": IfscCodeController.text,
          "bankname":_selectedbank,
          "branchname": BranchController.text,
          "micr":MICRNumberController.text,}}});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    bool statusbd = false;
    if (response.statusCode == 200) {
      statusbd = true;
      showErrorDialog("Invalid beneficiary account details");
    } else {
      showErrorDialog("Server Error");
      statusbd = true;
    }
    return statusbd;
  }
  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.lightBlueAccent,
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'OKAY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
  //
  // Future<List<getDraftloandetails>> fetchDraftLoans(String Username, Password,
  //     Name, PAN, Aadhar, Gender, moblileNumber) async {
  //   List<getDraftloandetails> DraftloansList = [];
  //   // URL
  //   String basicAuth =
  //       'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
  //   var headers = <String, String>{'authorization': basicAuth};
  //   final String url =
  //       "https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform?_where=loanrejected='N'and loanpreapproved='N' and loandisburse='N' and panno='${PANController.text}'";
  //   // METHOD: POST
  //   print(url);
  //   // REQUEST BODY
  //   final String requestBody = json.encode({
  //     "data": {
  //       "customername": Name,
  //       "prooftypenumber": Aadhar,
  //       "mobilenumber": moblileNumber,
  //       "gender": Gender,
  //       "panno": PAN
  //     }
  //   });
  //   // API CALL
  //   final result = await http.post(Uri.parse(url), body: requestBody);
  //   // RESPONSE
  //   if (result.statusCode == 200) {
  //     var responseBody = result.body;
  //     var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
  //     var response = jsonResponse['response'];
  //     for (var record in response['data']) {
  //       print(record);
  //       getDraftloandetails draftloan = getDraftloandetails.fromJson(record);
  //       DraftloansList.add(draftloan);
  //     }
  //     print(DraftloansList.length);
  //     return DraftloansList;
  //   }
  // }

  // _formCreation(String Username, Password, Name, PAN, Aadhar, Gender,
  //     moblileNumber) async {
  //   String basicAuth =
  //       'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
  //   var headers = <String, String>{'authorization': basicAuth};
  //   var request = http.Request(
  //       'POST',
  //       Uri.parse(
  //           'https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
  //   request.body = json.encode({
  //     "data": {
  //       "customername": Name,
  //       "prooftypenumber": Aadhar,
  //       "mobilenumber": moblileNumber,
  //       "gender": Gender,
  //       "panno": PAN,
  //       "lDSApploanstatus": "DR"
  //     }
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // } //Post call for new user with loan status for creating a loan

}
