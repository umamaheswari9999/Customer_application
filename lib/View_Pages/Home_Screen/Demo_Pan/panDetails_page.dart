import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/getLoanStatus.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/loanstatus_class.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/panClass_page.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Home_page/HomeScreen.dart';
import 'dart:convert';
import '../../../main.dart';
import '../Pan_details/CustomInputBox.dart';
class panFetch extends StatefulWidget {
  const panFetch({Key key}) : super(key: key);
   Future<List<Details>> fetchRecentLoans(String panno) async {
    // URL
    final String url =
        'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchclientMasterDetails?l=Appal&p=welcome';
    // METHOD: POST
    // REQUEST BODY
    final String requestBody = json.encode({
      "data": {"poiNumber": panno}
    });
    print(panno);
    // API CALL
    final result = await http.post(Uri.parse(url), body: requestBody);
    // RESPONSE
    List<Details> listDetails = [];
    if (result.statusCode == 200) {
      var responseBody = result.body;
      var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
      var response = jsonResponse['response'];
      for (var record in response['data']) {
        print(record['ClientMaster_Header']);
        Details details = Details.fromJson(record['ClientMaster_Header']);
        listDetails.add(details);
      }print(listDetails.length);
      return listDetails;}}
      @override
  _panFetchState createState() => _panFetchState();
}
class _panFetchState extends State<panFetch> {
  bool _isLoading = false;
  List<Details> listofDetails = [];
  TextEditingController NameController = TextEditingController();
  TextEditingController AadharController = TextEditingController();
  TextEditingController GenderController = TextEditingController();
  TextEditingController PANController = TextEditingController();
  TextEditingController moblileNumberController = TextEditingController();
  bool isExist = false;
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

                              Navigator.push(context, MaterialPageRoute(builder: (_) => WalletApp()));
                              setState(() {

                              });


                            },
                          ),
                          Text(
                            'Add PAN details',
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
                        PANController.text = text.toUpperCase();
                        final val = TextSelection.collapsed(
                            offset: PANController.text.length);
                        PANController.selection = val;
                        setState(() {});
                        if (text.length == 10) {
                          widget
                              .fetchRecentLoans(PANController.text)
                              .then((value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                listofDetails = value;
                                GenderController.text =
                                    listofDetails[0].gender.toString();
                                moblileNumberController.text
                                =
                                    listofDetails[0].phone.toString();
                                AadharController.text =
                                    listofDetails[0].aadhaarnumber.toString();
                                NameController.text =
                                    listofDetails[0].lDSName.toString();
                              });
                            } else {
                              GenderController.text = '';
                              moblileNumberController.text = '';
                              AadharController.text = '';
                              NameController.text = '';
                            }
                          });
                        } else {
                          GenderController.text = '';
                          moblileNumberController.text = '';
                          AadharController.text = '';
                          NameController.text = '';
                        }
                      },
                      label: 'PAN Number',
                      inputHint: 'PAN',
                      inputFieldController: PANController,
                    ),
                    MyCustomInputBox(
                      onChanged: (text) {
                        final val = TextSelection.collapsed(
                            offset: NameController.text.length);
                        NameController.selection = val;
                        setState(() {});
                      },
                      label: 'Full Name',
                      inputHint: 'Customer Name',
                      inputFieldController: NameController,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      onChanged: (text) {
                        final val = TextSelection.collapsed(
                            offset: AadharController.text.length);
                        AadharController.selection = val;
                        setState(() {});
                      },
                      label: 'Aadhar Number',
                      inputHint: 'Aadhar',
                      inputFieldController: AadharController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      onChanged: (text) {
                        final val = TextSelection.collapsed(
                            offset: NameController.text.length);
                        PANController.selection = val;
                        setState(() {});
                      },
                      label: 'Gender',
                      inputHint: 'Gender',
                      inputFieldController: GenderController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'Mobile Number',
                      inputHint: 'Mobile Number',
                      inputFieldController: moblileNumberController,
                    ),
                    //
                    Text(
                      "Please double check and confirm your  \n  PAN name before you continue",
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8f9db5).withOpacity(0.45),
                      ),
                      //
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 340,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                        elevation: 0.0,
                        color: Colors.lightBlueAccent,
                        child: Text(
                          'Confirm PAN details',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        onPressed: () {
                          if (listofDetails.isEmpty) {
                            _formCreation(
                                'Appal',
                                'welcome',
                                NameController.text,
                                PANController.text,
                                AadharController.text,
                                GenderController.text,
                                moblileNumberController.text);
                            print("Record created");
                          }
                          else if (listofDetails.isNotEmpty) {
                            fetchDraftLoans(
                                    'Appal',
                                    'welcome',
                                    NameController.text,
                                    PANController.text,
                                    AadharController.text,
                                    GenderController.text,
                                    moblileNumberController.text)
                                .then((value) => print(value[0].loanno));
                            // print()
                          }
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

  Future<List<getDraftloandetails>> fetchDraftLoans(String Username, Password,
      Name, PAN, Aadhar, Gender, moblileNumber) async {
    List<getDraftloandetails> DraftloansList = [];
    // URL
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    final String url =
        "https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform?_where=loanrejected='N'and loanpreapproved='N' and loandisburse='N' and panno='${PANController.text}'";
    // METHOD: POST
    print(url);
    // REQUEST BODY
    final String requestBody = json.encode({
      "data": {
        "customername": Name,
        "prooftypenumber": Aadhar,
        "mobilenumber": moblileNumber,
        "gender": Gender,
        "panno": PAN
      }
    });
    // API CALL
    final result = await http.post(Uri.parse(url), body: requestBody);
    // RESPONSE
    if (result.statusCode == 200) {
      var responseBody = result.body;
      var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
      var response = jsonResponse['response'];
      for (var record in response['data']) {
        print(record);
        getDraftloandetails draftloan = getDraftloandetails.fromJson(record);
        DraftloansList.add(draftloan);
      }
      print(DraftloansList.length);
      return DraftloansList;
    }
  }

  _formCreation(String Username, Password, Name, PAN, Aadhar, Gender,
      moblileNumber) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
    request.body = json.encode({
      "data": {
        "customername": Name,
        "prooftypenumber": Aadhar,
        "mobilenumber": moblileNumber,
        "gender": Gender,
        "panno": PAN,
        "lDSApploanstatus": "DR"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } //Post call for new user with loan status for creating a loan

}
