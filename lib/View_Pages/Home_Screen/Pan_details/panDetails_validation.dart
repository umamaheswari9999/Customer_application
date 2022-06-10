import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallet_app/View_Pages/Home_Screen/Pan_details/CustomInputBox.dart';
class pandetailsPage extends StatelessWidget {
  DateTime _dob;

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    DateTime _dob;
    TextEditingController NameController = TextEditingController();
    TextEditingController DOBController =  TextEditingController();
    TextEditingController PANController =  TextEditingController();
    TextEditingController AadharController =  TextEditingController();
    TextEditingController GenderController =  TextEditingController();
    TextEditingController moblileNumberController =  TextEditingController();

    return SafeArea(
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
                        //  Text("EZFINANAZ", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, top: 5),
                            child: Text(
                              'Let\'s get Started',
                              style: TextStyle(
                                fontFamily: 'Nunito Sans',
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MyCustomInputBox(
                      label: 'Full Name',
                      inputHint: 'Customer Name',
                        inputFieldController:NameController,

                    ),
                    //
                    SizedBox(
                      height: 5,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'Date of Birth',
                      inputHint: 'dd-mm-yyyy',
                      inputFieldController:DOBController,
                    ),
                    //
                    SizedBox(
                      height: 5,
                    ),
                    //
                    MyCustomInputBox(
                      label: 'PAN Number',
                      inputHint: 'PAN',
                      inputFieldController:PANController,
                    ),
                    //
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
                          _formCreation('Appal','welcome',NameController.text,DOBController.text,PANController.text,AadharController.text,GenderController.text,moblileNumberController.text);
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => ShowcaseDeliveryTimeline()));
                        },
                      ),
                    ),
                  ],
                ),
                ClipPath(
                  clipper: OuterClippedPart(),
                  child: Container(
                    color: Color(0xff0962ff),
                    width: scrWidth,
                    height: scrHeight,
                  ),
                ),
                //
                ClipPath(
                  clipper: InnerClippedPart(),
                  child: Container(
                    color: Color(0xff0c2551),
                    width: scrWidth,
                    height: scrHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _formCreation(String Username ,Password,Name,DOB,PAN,Aadhar,Gender,moblileNumber) async {
    String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$Username:$Password'));
      var headers= <String, String>{'authorization': basicAuth};
      var request = http.Request('POST', Uri.parse('https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform/'));
      request.body = json.encode({
        "data": {
          "customername": Name,
          "prooftypenumber": Aadhar,
          "mobilenumber": moblileNumber,
          "dateofbirth": DOB,
          "gender": Gender,
          "panno": PAN
        }
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }

    }
}



class Neu_button extends StatelessWidget {
  Neu_button({this.char});
  String char;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(12, 11),
            blurRadius: 26,
            color: Color(0xffaaaaaa).withOpacity(0.1),
          )
        ],
      ),
      //
      child: Center(
        child: Text(
          char,
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: Color(0xff0962FF),
          ),
        ),
      ),
    );
  }
}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);
    //
    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);
    //
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);

    //
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}