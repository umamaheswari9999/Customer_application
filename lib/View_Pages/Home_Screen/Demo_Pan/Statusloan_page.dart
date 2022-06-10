import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/panClass_page.dart';
import 'dart:convert';
import '../Pan_details/CustomInputBox.dart';
import 'loanStatus_page.dart';
class panFetch extends StatefulWidget {
  const panFetch({Key key}) : super(key: key);
  Future<List<Details>> fetchRecentLoans(String panno) async {
    // URL
    final String url = 'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchclientMasterDetails?l=Appal&p=welcome';
    // METHOD: POST
    // REQUEST BODY
    final String requestBody = json.encode({
      "data": {
        "poiNumber": panno
      }
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
      for(var record in response['data']){
        print(record['ClientMaster_Header']);
        Details details = Details.fromJson(record['ClientMaster_Header']);
        listDetails.add(details);}


      print(listDetails.length);
      return listDetails;
    }
  }
  @override
  _panFetchState createState() => _panFetchState();
}
class _panFetchState extends State<panFetch> {
  bool _isLoading = false;
  List<Details> listofDetails=[];
  TextEditingController NameController = TextEditingController();
  TextEditingController AadharController =  TextEditingController();
  TextEditingController GenderController =  TextEditingController();
  TextEditingController PANController =  TextEditingController();
  TextEditingController moblileNumberController =  TextEditingController();
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
                    Container(
                      child: Row(
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(Icons.arrow_back_outlined),
                            highlightColor: Colors.white,
                            onPressed: (){},
                            //  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          ),
                          SizedBox(width: 16,),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 40),

                            child: Text(
                              'Add PAN details',
                              style: TextStyle(
                                fontFamily: 'Cardo',
                                fontSize: 35,
                                color: Color(0xff0C2551),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            //
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // _isLoading?textSection():CircularProgressIndicator(),
                    MyCustomInputBox(
                      onChanged: (text){
                        print(text.length);
                        if(text.length==10
                        ) {
                          widget.fetchRecentLoans(PANController.text).then((value) {
                            if(value.isNotEmpty){
                              setState(() {
                                listofDetails=value;
                                GenderController.text=listofDetails[0].gender.toString();
                                moblileNumberController.text=listofDetails[0].phone.toString();
                                AadharController.text=listofDetails[0].aadhaarnumber.toString();
                                NameController.text=listofDetails[0].lDSName.toString();
                              });
                            }
                            else{
                              GenderController.text='';
                              moblileNumberController.text='';
                              AadharController.text='';
                              NameController.text='';


                            }
                          });
                        }
                      },
                      label: 'PAN Number',
                      inputHint: 'PAN',

                      inputFieldController:PANController,
                    ),
                    MyCustomInputBox(
                      label: 'Full Name',
                      inputHint: 'Customer Name',
                      inputFieldController:NameController,
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'Aadhar Number',
                      inputHint: 'Aadhar',
                      inputFieldController:AadharController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'Gender',
                      inputHint: 'Gender',
                      inputFieldController:GenderController,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyCustomInputBox(
                      label: 'Mobile Number',
                      inputHint: 'Mobile Number',
                      inputFieldController:moblileNumberController,
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
                    SizedBox(height:10),
                    Container(
                      width: 340,
                      height:40,
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
                        onPressed: (){
                          print(PANController.text);
                          print(AadharController.text);
                          print(NameController.text);
                          print(GenderController.text);

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
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          Form(

            child: TextFormField(
              controller: PANController,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.phone, color: Colors.black),
                hintText: "PAN Number",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),


          )

        ],
      ),
    );
  }
  Future<List<LoanStatus>> fetchLoanStatus() async {
    final response = await http.get(Uri.parse("https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform?_where=loanrejected='N'and loanpreapproved='N' and loandisburse='N'&_endRow=0&_selectedProperties=loanrejected,loanpreapproved,loandisburse"));
    if (response.statusCode == 200) {
      final responsebody=jsonDecode(response.body) as Map<String, dynamic>;
      final res= responsebody['response'] as Map<String, dynamic>;
      final loans=(res['data']) as List<dynamic>;
      return loans.map<LoanStatus>((json)=>LoanStatus.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

}



