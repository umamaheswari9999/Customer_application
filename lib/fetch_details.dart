import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/panClass_page.dart';

class StepperVerification extends StatefulWidget {
  final String id;
  final String panno;
  final String lDSApploanstatus;
  final String prooftypenumber;
  final String mobilenumber;
  final String gender;
  final String customername;

  const StepperVerification(
      {Key key,
        this.id,
        this.panno,
        this.lDSApploanstatus,
        this.prooftypenumber,
        this.mobilenumber,
        this.gender,
        this.customername})
      : super(key: key);
  @override
  _StepperVerificationState createState() => _StepperVerificationState();
}

class _StepperVerificationState extends State<StepperVerification> {
  String customerName = "";
  String AadharNumber = "";
  String Addressline1 = "";
  String Addressline2 = "";
  String countryName = "";
  String stateName = "";
  String cityName = "";
  String postalCode = "";
  String Addressline1Per = "";
  String Addressline2Per = "";
  String countryNamePer = "";
  String stateNamePer = "";
  String cityNamePer = "";
  String postalCodePer = "";
  int _currentStep = 0;
  bool _isOTPRequired = false;
  String serverOTP = "";
  String currentAddres = "";
  String permanentAddres = "";
  StepperType stepperType = StepperType.vertical;
  TextEditingController OTPController1 = TextEditingController();
  TextEditingController OTPController2 = TextEditingController();
  TextEditingController OTPController3 = TextEditingController();
  TextEditingController OTPController4 = TextEditingController();
  TextEditingController OTPController5 = TextEditingController();
  TextEditingController OTPController6 = TextEditingController();
  String verify = "";
  var site;
  var id;
  String _selectedAddress = "currentAdd";
  @override
  void initState() {
    super.initState();

    if (widget.lDSApploanstatus == 'DR') {
      _currentStep = 0;
    } else if (widget.lDSApploanstatus == 'RKYC') {
      fetchDetailsfrompanno(widget.panno).then((value) {
        if (value.isNotEmpty) {
          print(value[2].country$_identifier);
          customerName = value[0].lDSName;

          ///Current Address Fields
          Addressline1 = value[1].addressLine1;
          Addressline2 = value[1].addressLine2;
          cityName = value[1].cityName;
          postalCode = value[1].postalCode;
          stateName = value[1].region$_identifier;
          countryName = value[1].country$_identifier;
          currentAddres = Addressline1 +
              '\n' +
              Addressline2 +
              '\n' +
              cityName +
              ',' +
              postalCode +
              '\n' +
              stateName +
              ',' +
              countryName;

          ///Permanent Address Fields
          Addressline1Per = value[2].addressLine1;
          Addressline2Per = value[2].addressLine2;
          cityNamePer = value[2].cityName;
          postalCodePer = value[2].postalCode;
          stateNamePer = value[2].region$_identifier;
          countryNamePer = value[2].country$_identifier;
          permanentAddres = Addressline1Per +
              '\n' +
              Addressline2Per +
              '\n' +
              cityNamePer +
              ',' +
              postalCodePer +
              '\n' +
              stateNamePer +
              ',' +
              countryNamePer;
          setState(() {});
        }
      });
      _currentStep = 1;
    } else {
      _currentStep = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('KYC Verification'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      Container(),
                      Container(),
                    ],
                  );
                },
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[
                  _isOTPRequired
                      ? Step(
                    title: new Text('OTP Verification'),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            textSection(OTPController1),
                            SizedBox(
                              width: 10,
                            ),
                            textSection(OTPController2),
                            SizedBox(
                              width: 10,
                            ),
                            textSection(OTPController3),
                            SizedBox(
                              width: 10,
                            ),
                            textSection(OTPController4),
                            SizedBox(
                              width: 10,
                            ),
                            textSection(OTPController5),
                            SizedBox(
                              width: 10,
                            ),
                            textSection(OTPController6),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              print(_currentStep);
                              verify = OTPController1.text +
                                  OTPController2.text +
                                  OTPController3.text +
                                  OTPController4.text +
                                  OTPController5.text +
                                  OTPController6.text;
                              print(verify);
                              _VerifyKYCotp('Appal', 'welcome', verify)
                                  .then((value) {
                                if (_currentStep <= 0 &&
                                    value == true &&
                                    value != null) {
                                  _UpdatingStatustoRKYC(
                                    'Appal',
                                    'welcome',
                                    widget.id,
                                  );
                                  setState(() {
                                    _currentStep += 1;
                                  });
                                  if (_currentStep == 1) {
                                    fetchDetailsfrompanno(widget.panno)
                                        .then((value) {
                                      if (value.isNotEmpty) {
                                        print(value[1].addressLine2);
                                        print(
                                            value[2].region$_identifier);
                                        customerName = value[0].lDSName;

                                        /// Current Address Fields
                                        Addressline1 =
                                            value[1].addressLine1;
                                        Addressline2 =
                                            value[1].addressLine2;
                                        cityName = value[1].cityName;
                                        postalCode = value[1].postalCode;
                                        stateName =
                                            value[1].region$_identifier;
                                        countryName =
                                            value[1].country$_identifier;
                                        currentAddres = Addressline1 +
                                            '\n' +
                                            Addressline2 +
                                            '\n' +
                                            cityName +
                                            ',' +
                                            postalCode +
                                            '\n' +
                                            stateName +
                                            ',' +
                                            countryName;

                                        /// Permanent Address Fields
                                        Addressline1Per =
                                            value[2].addressLine1;
                                        Addressline2Per =
                                            value[2].addressLine2;
                                        cityNamePer = value[2].cityName;
                                        postalCodePer =
                                            value[2].postalCode;
                                        stateNamePer =
                                            value[2].region$_identifier;
                                        countryNamePer =
                                            value[2].country$_identifier;
                                        permanentAddres =
                                            Addressline1Per +
                                                '\n' +
                                                Addressline2Per +
                                                '\n' +
                                                cityNamePer +
                                                ',' +
                                                postalCodePer +
                                                '\n' +
                                                stateNamePer +
                                                ',' +
                                                countryNamePer;
                                        setState(() {});
                                      }
                                    });
                                  }
                                }
                              });
                            },
                            child: Text("Verify"))
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  )
                      : Step(
                    title: new Text('KYC'),
                    content: Column(
                      children: <Widget>[
                        Text(
                            "KYC is not completed for this customer.\n KYC is compulsory to disburse the loan.\n Do you want to proceed further?"),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 340,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: RaisedButton(
                              elevation: 0.0,
                              color: Colors.lightBlueAccent,
                              child: Text(
                                'START KYC',
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(5.0)),
                              onPressed: () async {
                                _SendKYCotp('Appal', 'welcome')
                                    .then((value) {
                                  print(value);
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      _isOTPRequired = true;
                                      serverOTP = value;
                                    });
                                  }
                                });
                              }),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('KYC Review'),
                    content: Column(
                      children: <Widget>[
                        Text(
                          'Current Address',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.blueGrey,
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: ListTile(
                                title: Text(
                                  currentAddres,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black87,
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800),
                                ),
                                leading: Radio(
                                    value: "currentAdd",
                                    groupValue: _selectedAddress,
                                    onChanged: (String value) {
                                      setState(() {
                                        _selectedAddress = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          // Radio(
                          //   value: 1,
                          //   groupValue: id,
                          //   onChanged: (val) {
                          //     setState(() {
                          //       id = 1;
                          //     });
                          //   },
                          // ),
                          // Text(
                          //   currentAddres,
                          //   style: TextStyle(
                          //       decoration: TextDecoration.none,
                          //       color: Colors.black87,
                          //       fontSize: 13.0,
                          //       fontFamily: 'Roboto',
                          //       fontWeight: FontWeight.w800),
                          // ),

                          // more widgets ...
                        ]),
                        Text(
                          'Permanent Address',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.blueGrey,
                              fontSize: 13.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(1.0),
                              child: ListTile(
                                title: Text(
                                  permanentAddres,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black87,
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800),
                                ),
                                leading: Radio(
                                    value: "perAdd",
                                    groupValue: _selectedAddress,
                                    onChanged: (String value) {
                                      setState(() {
                                        _selectedAddress = value;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          // Radio(
                          //   value: 1,
                          //   groupValue: id,
                          //   onChanged: (val) {
                          //     setState(() {
                          //       id = 1;
                          //     });
                          //   },
                          // ),
                          // Text(
                          //   currentAddres,
                          //   style: TextStyle(
                          //       decoration: TextDecoration.none,
                          //       color: Colors.black87,
                          //       fontSize: 13.0,
                          //       fontFamily: 'Roboto',
                          //       fontWeight: FontWeight.w800),
                          // ),

                          // more widgets ...
                        ]),

                        // Text(
                        //   'Permanent Address',
                        //   textDirection: TextDirection.ltr,
                        //   style: TextStyle(
                        //       decoration: TextDecoration.none,
                        //       color: Colors.blueGrey,
                        //       fontSize: 13.0,
                        //       fontFamily: 'Roboto',
                        //       fontWeight: FontWeight.w800),
                        // ),

                        // Row(children: [
                        //   Radio(
                        //     value: 1,
                        //     groupValue: id,
                        //     onChanged: (val) {
                        //       setState(() {
                        //         id = 1;
                        //       });
                        //     },
                        //   ),
                        //   Text(
                        //     permanentAddres,
                        //     style: TextStyle(
                        //         decoration: TextDecoration.none,
                        //         color: Colors.black87,
                        //         fontSize: 13.0,
                        //         fontFamily: 'Roboto',
                        //         fontWeight: FontWeight.w800),
                        //   ),
                        //
                        //   // more widgets ...
                        // ]),

                        // TextFormField(
                        //   decoration: InputDecoration(labelText: 'Postcode'),
                        // ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Mobile Number'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          InputDecoration(labelText: 'Mobile Number'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  /// For fetching Customer Details from the PAN number
  Future<List<Details>> fetchDetailsfrompanno(String panno) async {
    // URL
    List current = [];
    List permanent = [];
    final String url =
        'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchclientMasterDetails?l=Appal&p=welcome';
    // REQUEST BODY
    final String requestBody = json.encode({
      "data": {"poiNumber": panno}
    });
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
        print(record['ClientMaster_Locations'][0]['currentAddress']['addressLine1']);
        Details details = Details.fromJson(record['ClientMaster_Header']);
        Details details1 = Details.fromJson(record['ClientMaster_Locations'][0]['currentAddress']);
        Details details2 = Details.fromJson(record['ClientMaster_Locations'][0]['permanentAddress']);
        for (var address in record['ClientMaster_Locations']) {
          current.add(address['currentAddress']);
          current.add(address['permanentAddress']);
          for(int i = 0; i < current.length; i++){
            final String addressLine1 = current[i]['addressLine1'];
            final String addressLine2=current[i]['addressLine2'];
            print(addressLine1);

          }
        }
        listDetails.add(details);
        listDetails.add(details1);
        listDetails.add(details2);
      }
      return listDetails;
    }
  }

  /// For sending OTP to the user for kyc verification
  Future<String> _SendKYCotp(String Username, Password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    String otp;
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.KYC_Otp'));
    request.body = json.encode({
      "data": {"preEnquiryFormId": widget.id}
    });
    request.headers.addAll(headers);
    return request.send().then((value) {
      return http.Response.fromStream(value).then((response) {
        var result = json.decode(response.body) as Map<String, dynamic>;
        otp = result['data']['OTP'];
        print(otp);
        print(result['data']['OTP']);
        return result['data']['OTP'];
      });
    });
  }

  /// For Verifying otp and creating record in ClientMaster
  Future<bool> _VerifyKYCotp(String Username, Password, enteredotp) async {
    bool status = false;
    if (serverOTP == enteredotp) {
      status = true;
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
      var headers = <String, String>{'authorization': basicAuth};

      var request = http.Request(
          'POST',
          Uri.parse(
              'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.KYC_Data'));
      request.body = json.encode({
        "data": {
          "preEnquiryFormId": widget.id,
          "otp": serverOTP,
          "consentcreatedby": "D5F96992150A4F03A9CC07BA922FE3FF",
          "browserused": "text",
          "consentapprovedip": "",
          " consentcreatedon": ""
        }
      });
      request.headers.addAll(headers);
      request.send().then((value) {
        http.Response.fromStream(value).then((response) {
          json.decode(response.body) as Map<String, dynamic>;
        });
      });
    } else {
      status = false;
      showErrorDialog('entered otp is incorrect');
    }
    print(status);
    return status;
  }

  ///Error showing dialogueBox
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

  ///Updating ldsloanstatus DR Draft TO RKYC - Review KYC Details,
  _UpdatingStatustoRKYC(String Username, Password, id) async {
    print("Sttus is Updated");
    print(id);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
    request.body = json.encode({
      "data": {"id": id, "lDSApploanstatus": "RKYC"}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Widget textSection(TextEditingController controller) {
    return SizedBox(
      height: 50,
      width: 40,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
