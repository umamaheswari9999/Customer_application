import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
Future<List<draftLoannoInformation>> fetchAlbum(loanNo) async {
  final response = await http.get(Uri.parse("https://testsairoshni.nettlinx.com/erp/org.openbravo.service.json.jsonrest/Lds_Preenquiryform?l=Appal&p=welcome&_where=loanno='${loanNo}'"));
  print(response.statusCode);
  print(loanNo);
  if (response.statusCode == 200) {
    final responsebody=jsonDecode(response.body) as Map<String, dynamic>;
    final res= responsebody['response'] as Map<String, dynamic>;
    final loans=(res['data']) as List<dynamic>;
    return loans.map<draftLoannoInformation>((json)=>draftLoannoInformation.fromJson(json)).toList();

  }
  else {
    throw Exception('Failed to load data');
  }
}
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

class LoanPage extends StatefulWidget{
  final String loanNo;
  const LoanPage({Key key, this.loanNo}) : super(key: key);
  @override
  _LoanPageState createState() => _LoanPageState();
}
class _LoanPageState extends State<LoanPage> {
  Future <List<draftLoannoInformation>> futureAlbum;


  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(widget.loanNo);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Color(0xE9E9F6FF),
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('Loan Details '),
        ),
        body: Center(
          child: FutureBuilder<List<draftLoannoInformation>>(
            future: futureAlbum,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount:snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder:(context,index){
                      return Center(
                        child: Column(
                          children: [
                            //Add Some Vertical Space
                            SizedBox(height: 20),
                            Container(
                              child:Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                      child:Text(
                                        '${snapshot.data[index].loanno}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 23.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:170),
                                  ]),),
                            SizedBox(height:5),
                            Container(
                                child:Padding(
                                  padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                                  child:RichText(
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(text: 'Name of the Customer'),
                                        new TextSpan(text: '     ${snapshot.data[index].customername }', style: new TextStyle(color:Colors.lightBlueAccent)),
                                      ],
                                    ),

                                  ),
                                )
                            ),
                            SizedBox(height:5),

                            SizedBox(height:5),
                            Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black26,
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            ),
                            SizedBox(height:5),
                            Container(
                                child:Padding(
                                  padding:const EdgeInsets.only(right:50.0),
                                  child:Text(
                                    'Basic Details',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(height:5),
                            Container(
                              child:GridView.count(
                                  shrinkWrap: true,
                                  padding:EdgeInsets.only(right:5.0,left:5.0,top:8.0,bottom:8.0),
                                  crossAxisCount: 4,
                                  crossAxisSpacing:1.0,
                                  mainAxisSpacing: 1.0,
                                  children:<Widget>[
                                    Card(child:InkWell(child:Container(child:Wrap(
                                        children:<Widget>[

                                          Row(
                                              children:<Widget>[
                                                Padding(padding: EdgeInsets.only(left:8.0,top:8.0),
                                                  child:Text('Name',style:TextStyle(fontSize:16),),
                                                ),
                                              ]
                                          ),Row(
                                              children:<Widget>[
                                                Padding(padding: EdgeInsets.only(left:8.0,top:8.0),
                                                  child:Text('${snapshot.data[index].customername}',style:TextStyle(fontSize:16,color:Colors.lightBlueAccent),),
                                                ),
                                              ]
                                          ),
                                        ]
                                    )))
                                    ),
                                    Card(child:InkWell(child:Container(child:Wrap(
                                        children:<Widget>[
                                          Row(
                                              children:<Widget>[
                                                Padding(padding: EdgeInsets.only(left:8.0,top:8.0),
                                                  child:Text('Loan no',style:TextStyle(fontSize:16),),
                                                ),
                                              ]
                                          ),
                                          Row(
                                              children:<Widget>[
                                                Padding(padding: EdgeInsets.only(left:8.0,top:8.0),
                                                  child:Text('${snapshot.data[index].loanno}',style:TextStyle(fontSize:16,color:Colors.lightBlueAccent),),
                                                ),
                                              ]
                                          ),

                                        ]
                                    )))
                                    ),

                                  ]
                              ),

                            ),

                            SizedBox(height:5),
                            Container(


                            )
                          ],




                        ),
                      );
                    }
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();

            },

          ),
        ),

      ),
    );
  }
}