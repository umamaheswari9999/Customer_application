import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/AddingBankdetails.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/ClientMasterlocations_class.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/Static_classgender.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/bankdetailsexistingUser_Class.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/currentAddress_class.dart';

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
  List<ClientMaster_Locations> myLocations = [];
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
  Color defColor = Colors.grey;
  Widget selection = const SizedBox();
  String dietGoalId;
  var id;
  String _selectedgender = null;
  String _selectedmaritalstatus = null;
  String _selectedoccupation = null;
  String _selectedresidency = null;

  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController AltermobileController =
      new TextEditingController();
  final TextEditingController fatharNameController =
      new TextEditingController();
  final TextEditingController motherNameController =
      new TextEditingController();
  final TextEditingController employerNameController =
      new TextEditingController();
  final TextEditingController officemobileController =
      new TextEditingController();
  final TextEditingController officeemailController =
      new TextEditingController();
  final TextEditingController designationController =
      new TextEditingController();
  final TextEditingController AnnualIncomeController =
      new TextEditingController();
  final TextEditingController personalemailController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.lDSApploanstatus == 'DR') {
      _currentStep = 0;
    } else if (widget.lDSApploanstatus == 'RKYC') {
      fetchDetailsfrompanno(widget.panno).then((value) {
        if (value.isNotEmpty) {
          print(value);
          myLocations.addAll(value);
          setState(() {});
        }
      });
      _currentStep = 1;
    } else if (widget.lDSApploanstatus == 'AI') {
      print(widget.gender);
      _selectedgender = widget.gender;
      mobileController.text = widget.mobilenumber;
      _UpdatingSttatusoBDandAdditionaldatails('Appal','welcome',widget.panno).then((value) {
        if (value==true) {

          setState(() {});
        }
      });
      _currentStep = 2;
    } else if (widget.lDSApploanstatus == 'BD') {
      fetchDetailsfrompanno(widget.panno).then((value) {
        if (value.isNotEmpty) {
          print(value);

          setState(() {});
        }
      });
      _currentStep = 3;
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                                verify = OTPController1.text + OTPController2.text + OTPController3.text + OTPController4.text + OTPController5.text + OTPController6.text;
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
                                          currentAddres = Addressline1 + '\n' + Addressline2 + '\n' + cityName + ',' + postalCode + '\n' + stateName + ',' + countryName;
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
                                    borderRadius: BorderRadius.circular(5.0)),
                                onPressed: () async {
                                  _SendKYCotp('Appal', 'welcome').then((value) {
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
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: myLocations.length,
                        itemBuilder: (context, index) {
                          print(myLocations[index].currentAddress.identifier);
                          return Padding(
                            padding: EdgeInsets.all(1.0),
                            child: ListTile(
                                onTap: () {
                                  setState(() {
                                    dietGoalId =
                                        myLocations[index].currentAddress.id;
                                    defColor = Colors.green;
                                    selection = const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    );
                                  });
                                  print(dietGoalId);
                                },
                                title: Text(
                                  myLocations[index].currentAddress.identifier,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black87,
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800),
                                ),
                                leading: Container(
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: defColor,
                                    ),
                                  ),
                                  child: _buildOnTapSelectionFunc(
                                      myLocations[index].currentAddress.id,
                                      dietGoalId),
                                )),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: () async {
                            _UpdatingStatustoAIwithAddress(
                                    'Appal', 'welcome', widget.id, dietGoalId)
                                .then((value) {
                              print(value);
                              if (value) {
                                setState(() {
                                  _currentStep += 1;
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
                title: new Text('Additional Information'),
                content: Column(
                  children: <Widget>[
                    Text(
                      'GENDER',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800),
                    ),
                    Wrap(
                      spacing: 26,
                      children: [
                        for (var record in StaticData.genders)
                          ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor:
                                Theme.of(context).colorScheme.secondary,
                            label: Text(record.title),
                            selected: record.id == _selectedgender,
                            padding: const EdgeInsets.all(2),
                            labelStyle: const TextStyle(fontSize: 14),
                            onSelected: (selected) {
                              if (selected) {
                                _selectedgender = record.id;
                              } else {
                                _selectedgender = null;
                              }
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                    Text(
                      'MARITAL STATUS',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800),
                    ),
                    Wrap(
                      spacing: 26,
                      children: [
                        for (var record in StaticData.maritalStatus)
                          ChoiceChip(
                            backgroundColor: Colors.white,
                            selectedColor:
                                Theme.of(context).colorScheme.secondary,
                            label: Text(record.title),
                            selected: record.id == _selectedmaritalstatus,
                            padding: const EdgeInsets.all(2),
                            labelStyle: const TextStyle(fontSize: 14),
                            onSelected: (selected) {
                              if (selected) {
                                _selectedmaritalstatus = record.id;
                              } else {
                                _selectedmaritalstatus = null;
                              }
                              setState(() {});
                            },
                          ),
                      ],
                    ),
                    Text(
                      'OCCUPATION TYPE',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              isDense: true,
                              hint: Text("Occupation Type"),
                              value: _selectedoccupation,
                              items:
                                  StaticData.occupationTypes.map((occupations) {
                                return DropdownMenuItem(
                                    value: occupations.id,
                                    child: Text(occupations.title));
                              }).toList(),
                              onChanged: (value) {
                                // snapshot.data.where((element) => element.emiduedate);
                                setState(() {
                                  _selectedoccupation = value;
                                });
                                print(_selectedoccupation);
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'RESIDENCY TYPE',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.blueGrey,
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              isDense: true,
                              hint: Text("Residency Type"),
                              value: _selectedresidency,
                              items: StaticData.residenceTypes.map((occupations) {
                                return DropdownMenuItem(
                                    value: occupations.id,
                                    child: Text(occupations.title));
                              }).toList(),
                              onChanged: (value) {
                                // snapshot.data.where((element) => element.emiduedate);
                                setState(() {
                                  _selectedresidency = value;
                                });
                                print(_selectedresidency);
                              }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        controller: fatharNameController,
                        decoration: InputDecoration(
                          hintText: "FATHER NAME",
                          labelText: 'Father Name',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        controller: motherNameController,
                        decoration: InputDecoration(
                          hintText: "MOTHER NAME",
                          labelText: 'Mother Name',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: TextFormField(
                        controller: employerNameController,
                        decoration: InputDecoration(
                          hintText: "Employer Name",
                          labelText: 'EMPLOYER NAME',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: TextFormField(
                        controller: officemobileController,
                        decoration: InputDecoration(
                          hintText: "Office Phone Number",
                          labelText: 'OFFICE PHONE NUMBER',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: TextFormField(
                        controller: officeemailController,
                        decoration: InputDecoration(
                          hintText: "Official Email Id",
                          labelText: 'OFFICIAL EMAIL ID',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: TextFormField(
                        controller: personalemailController,
                        decoration: InputDecoration(
                          hintText: "Designation",
                          labelText: 'DESIGNATION',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: TextFormField(
                        controller: AnnualIncomeController,
                        decoration: InputDecoration(
                          hintText: "Annual Income",
                          labelText: 'ANNUAL INCOME',
                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:8,
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          onPressed: () async {

                            print(_currentStep)
;                            _UpdatingSttatusoBDandAdditionaldatails(
                                    'Appal', 'welcome', widget.id)
                                .then((value) {
                              print(value);
                              if (value) {
                                setState(() {
                                  _currentStep += 1;
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
                title: new Text('Bank Details'),
                content: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 48,
                decoration:  BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell( // child tapped will fire onTap
                  child: Center(
                    child: RichText(text: TextSpan(children: [
                          TextSpan(
                          style: TextStyle(color: Colors.grey)),
                        WidgetSpan(child: GestureDetector(child:Row(
                          children: [
                             Icon(Icons.add,color: Colors.green, size: 20,),
                            Text('ADD BANK ACCOUNT', style: TextStyle(color: Colors.green),),
                          ],
                        ), onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddingBANKdetails(id:widget.id)),
                          );
                        },))
                            ]),),
                  )
                ),
              ),
                    )
                  ],
                ),
                isActive: _currentStep >= 0,
                state: _currentStep >= 0
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: new Text('eSign & eMandate'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("E-SIGN",style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,),textAlign: TextAlign.justify),
                    Text("To proceed further to disburse the loan\n customer has to sign the application\n document"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: new Icon(Icons.schedule),
                          highlightColor: Colors.orange,
                          color: Colors.orangeAccent,
                        ),
                        Text("eSign link send successfully.\n Waiting for eSign completion.",style: TextStyle(color:Colors.black87,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Container(
                      width: 340,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.black87,
                          child: Text(
                            'RESEND LINK',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: () async {
                            _SendKYCotp('Appal', 'welcome').then((value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  _isOTPRequired = true;
                                  serverOTP = value;
                                });
                              }
                            });
                          }),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 340,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: RaisedButton(
                          elevation: 0.0,
                          color: Colors.lightBlueAccent,
                          child: Text(
                            'CHECK STATUS',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          onPressed: () async {
                            _SendKYCotp('Appal', 'welcome').then((value) {
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  /// For fetching Customer Details from the PAN number for Address
  Future<List<ClientMaster_Locations>> fetchDetailsfrompanno(String panno) async {
    // URL
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
    List<ClientMaster_Locations> current = [];

    if (result.statusCode == 200) {
      var responseBody = result.body;
      var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
      var response = jsonResponse['response'];
      for (var record in response['data']) {
        for (var address in record['ClientMaster_Locations']) {
          CurrentAddress currenobj =
              CurrentAddress.fromJson(address['currentAddress']);
          ClientMaster_Locations location =
              ClientMaster_Locations(currentAddress: currenobj);
          current.add(location);
        }
      }
      return current;
    }
  }
/// For Bank details fetching API for Bank details
    Future<List<bankexistingDetails>> fetchBankDetails(String Username,Password, ifsccode) async {
      // URL
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
      var headers = <String, String>{'authorization': basicAuth};
      final String url =
          ' https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchBankDetails';
      // METHOD: POST
      // REQUEST BODY
      final String requestBody = json.encode({
        "data": {"ifscCode": ifsccode}
      });


      // API CALL
      final result = await http.post(Uri.parse(url), body: requestBody,headers: headers);
      // RESPONSE
      List<bankexistingDetails> listDetails = [];
      if (result.statusCode == 200) {
        var responseBody = result.body;
        var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
        for (var record in jsonResponse['response'] ){
          print(record);
          bankexistingDetails details = bankexistingDetails.fromJson(record);
          listDetails.add(details);}
        print(listDetails.length);
        return listDetails;
      }
    }
//   Future<List<bankexistingDetails>> fetchBankDetailsfromifsccode(String Username, Password, ifsccode) async {
//     // URL
//     String basicAuth =
//         'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
//     var headers = <String, String>{'authorization': basicAuth};
//     String otp;
//     var request = http.Request(
//         'POST',
//         Uri.parse(
//             ' https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchBankDetails'));
//     final String requestBody = json.encode({
//       "data": {"ifscCode": ifsccode}
//     });
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     List<bankexistingDetails> listDetails = [];
//     if (response.statusCode == 200) {
//       var responseBody = response.body;
//       var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
//
//
//       for (var response1 in jsonResponse['response']) {
//         bankexistingDetails details = bankexistingDetails.fromJson(response1['response']);
//         listDetails.add(details);
//       }
//       print(listDetails.length);
//       return listDetails;
//     }
//   }
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

  ///------------------Updating ldsloanstatus DR Draft TO RKYC - Review KYC Details--------------------------------///
  _UpdatingStatustoRKYC(String Username, Password, id) async {
    print("Status is Updated");
    print(id);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse('https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
    request.body = json.encode({
      "data": {"id": id, "lDSApploanstatus": "RKYC"}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      // print(response.reasonPhrase);
    }
  }

  ///----------Updating ldsloanstatus RKYC Draft TO AI - Updating Address Details-------------------------------------------///
  Future<bool> _UpdatingStatustoAIwithAddress(
      String Username, Password, id, currentAddressid) async {
    print("Status is Updated to AI");
    print(id);
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
    request.body = json.encode({
      "data": {
        "id": id,
        "lDSApploanstatus": "AI",
        "location": "EBCE46629F5149DB8447AC3DE88D6818",
        "currentaddress": currentAddressid
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    bool status = false;
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      status = true;
    } else {
      // print(response.reasonPhrase);
      status = false;
    }
    return status;
  }

  ///--------------- Updating Additional details and ldaapploanstatus to BD-------------------------------------////
  Future<bool> _UpdatingSttatusoBDandAdditionaldatails(
      String Username, Password, id) async {
    print("Status is Updated");

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
    var headers = <String, String>{'authorization': basicAuth};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
    request.body = json.encode({
      "data": {
        "id": id,
        "gender": _selectedgender,
        "maritalstatus": _selectedmaritalstatus,
        "occupationtype": _selectedoccupation,
        "residentialstatus": _selectedresidency,
        "mobilenumber": widget.mobilenumber,
        "alternatenumber": AltermobileController.text,
        "fathername": fatharNameController.text,
        "employername": employerNameController.text,
        "officephonenumber": officemobileController.text,
        "officialEmail": officemobileController.text,
        "designation": designationController.text,
        "annualincome": 1000000,
        "emailid": personalemailController.text,
        "lDSApploanstatus": "BD"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    bool statusbd = false;
    if (response.statusCode == 200) {
      statusbd = true;
    } else {
      statusbd = true;
    }
    return statusbd;
  }

  ///For Radio button
  _buildOnTapSelectionFunc(String id, String dietGoalId) {
    if (dietGoalId != null) {
      if (id.toLowerCase().trim() == dietGoalId.toLowerCase().trim()) {
        return selection;
      }
    }
  }

  /// For OTP TextField
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
  /// For Details entering field in step2
  Container detailsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: mobileController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(Icons.phone, color: Colors.black),
              hintText: "Mobile Number",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintStyle: TextStyle(color: Colors.black),
            ),
          )
        ],
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
    _currentStep < 3 ? setState(() => _currentStep += 2) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
