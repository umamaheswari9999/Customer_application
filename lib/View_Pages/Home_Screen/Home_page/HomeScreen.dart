import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallet_app/View_Pages/Home_Screen/Demo_Pan/stepper_page.dart';
import 'dart:convert';

class Loan {
  final String loanNo;
  final String customername;
  final String prooftypenumber;
  final String mobilenumber;
  final String gender;
  final String lDSApploanstatus;
  final String id;
  final String panno;
  const Loan(this.loanNo, this.customername, this.lDSApploanstatus, this.id,this.panno,this.prooftypenumber,this.mobilenumber,this.gender);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  Future<List<List<Loan>>> fetchRecentLoans() async {
    // URL
    final String url =
        'https://testsairoshni.nettlinx.com/erp/ws/com.saksham.loandetails.fetchAgentRecentLoans?l=Appal&p=welcome';
    // METHOD: POST

    // REQUEST BODY
    final String requestBody = json.encode({
      'data': {'userId': 'D5F96992150A4F03A9CC07BA922FE3FF'}
    });
    // API CALL
    final result = await http.post(Uri.parse(url), body: requestBody);
    // RESPONSE
    if (result.statusCode == 200) {
      var responseBody = result.body;
      var jsonResponse = json.decode(responseBody) as Map<String, dynamic>;
      var response = jsonResponse['response'] as Map<String, dynamic>;
      var data = response['data'] as List<dynamic>;
      var loans = data[0] as Map<String, dynamic>;
      var recentLoans = loans['recentLoansList'] as List<dynamic>;
      var preapprovedLoans = loans['preapprovedLoans'] as List<dynamic>;
      var disbursedLoans = loans['recentDisbursedLoans'] as List<dynamic>;
      var recentLoansList = <Loan>[];
      for (int i = 0; i < recentLoans.length; i++) {
        final String loan = recentLoans[i]['loanno'];
        final String customername = recentLoans[i]['customername'];
        final String id = recentLoans[i]['id'];
        final String panno = recentLoans[i]['panno'];
        final String prooftypenumber = recentLoans[i]['prooftypenumber'];
        final String mobilenumber = recentLoans[i]['mobilenumber'];
        final String gender = recentLoans[i]['gender'];
        // final String loanamount=recentLoans[i]['loanamount'];
        final String lDSApploanstatus = recentLoans[i]['lDSApploanstatus'];

        print(recentLoans[i]['loanno']);
        recentLoansList.add(Loan(loan,customername,lDSApploanstatus,id,panno,prooftypenumber,mobilenumber,gender));
      }
      // return recentLoansList;
      var preapprovedLoansList = <Loan>[];
      for (int j = 0; j < preapprovedLoans.length; j++) {
        final String loan1 = preapprovedLoans[j]['loanno'];
        final String customername1 = preapprovedLoans[j]['customername'];
        final String id1 = recentLoans[j]['id'];
        final String panno1 = recentLoans[j]['panno'];
        final String lDSApploanstatus1 = preapprovedLoans[j]['lDSApploanstatus'];
        final String prooftypenumber1 = recentLoans[j]['prooftypenumber'];
        final String mobilenumber1 = recentLoans[j]['mobilenumber'];
        final String gender1 = recentLoans[j]['gender'];
        print(preapprovedLoans[j]['loanno']);
        preapprovedLoansList
            .add(Loan(loan1, customername1, lDSApploanstatus1,id1,panno1,prooftypenumber1,mobilenumber1,gender1));
      }
      var disbursedLoansList = <Loan>[];
      for (int k = 0; k < disbursedLoans.length; k++) {
        final String loan2 = disbursedLoans[k]['loanno'];
        final String customername2 = disbursedLoans[k]['customername'];
        final String id2 = recentLoans[k]['id'];
        final String panno2 = recentLoans[k]['panno'];
        final String lDSApploanstatus2 = disbursedLoans[k]['lDSApploanstatus'];
        final String prooftypenumber2 = recentLoans[k]['prooftypenumber'];
        final String mobilenumber2 = recentLoans[k]['mobilenumber'];
        final String gender2 = recentLoans[k]['gender'];
        print(disbursedLoans[k]['loanno']);
        disbursedLoansList
            .add(Loan(loan2, customername2, lDSApploanstatus2,id2,panno2,prooftypenumber2,mobilenumber2,gender2));
      }

      return [recentLoansList, preapprovedLoansList, disbursedLoansList];
    } else {
      // error
      return [];
    }
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Loan> loansList = [];
  List<Loan> PreloanList = [];
  List<Loan> DisbursedloanList = [];

  @override
  void initState() {
    super.initState();
    widget.fetchRecentLoans().then((value) {
      print(value);
      setState(() {
        loansList = value[0];
        PreloanList = value[1];
        DisbursedloanList = value[2];
      });
    });
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          //Container for top data
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //  Text("EZFINANAZ", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),),
                    RichText(
                      text: TextSpan(
                        text: 'EZ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'FIN',
                              style: TextStyle(
                                color: Color.fromRGBO(150, 221, 95, 1),
                              )),
                          TextSpan(text: 'ANZ'),
                        ],
                      ),
                    ),

                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            color: Colors.lightBlue[100],
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "YOUR FIN BUDDY",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: Colors.blue[100]),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Icon(
                              Icons.date_range,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Send",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Icon(
                              Icons.public,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Request",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Icon(
                              Icons.attach_money,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Loan",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Icon(
                              Icons.trending_down,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Topup",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Colors.blue[100]),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recent Transactions",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.grey[800]),
                            )
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      //Container for buttons
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "All",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.grey[900]),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 10.0,
                                        spreadRadius: 4.5)
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.grey[900]),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 10.0,
                                        spreadRadius: 4.5)
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Expenses",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.grey[900]),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        blurRadius: 10.0,
                                        spreadRadius: 4.5)
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      //Container Listview for expenses and incomes
                      Container(
                        child: Text(
                          " RECENT DRAFT LOANS",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 180,
                        child: loansList.isEmpty
                            ? Text("Nothing is Here")
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 16, top: 4, right: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: loansList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  StepperVerification(
                                                    id: loansList[index].id,panno: loansList[index].panno,
                                                      lDSApploanstatus:loansList[index].lDSApploanstatus,
                                                      prooftypenumber:loansList[index].prooftypenumber,
                                                      mobilenumber:loansList[index].mobilenumber,
                                                      gender:loansList[index].gender,
                                                      customername:loansList[index].customername,)));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.all(10),
                                        width: 244,
                                        height: 199,
                                        child: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                '# ${loansList[index].loanNo}',
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                ' ${loansList[index].customername}',
                                                textDirection:
                                                    TextDirection.ltr,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black87,
                                                    fontSize: 13.0,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              const Divider(),
                                              SizedBox(
                                                height: 35,
                                              ),
                                              buildbar(progressBarValue(
                                                  loansList[index]
                                                      .lDSApploanstatus)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Text(
                          "RECENT PRE APPROVED LOANS",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.lightBlueAccent),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 180,
                        child: PreloanList.isEmpty
                            ? Text("Nothing is Here")
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 16, top: 4, right: 16),
                                scrollDirection: Axis.horizontal,
                                itemCount: PreloanList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.all(10),
                                        width: 244,
                                        height: 199,
                                        child: Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '# ${PreloanList[index].loanNo}',
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                ' ${PreloanList[index].customername}',
                                                textDirection:
                                                    TextDirection.ltr,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    decoration:
                                                    TextDecoration.none,
                                                    color: Colors.black87,
                                                    fontSize: 13.0,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              buildbar(progressBarValue(
                                                  PreloanList[index]
                                                      .lDSApploanstatus)),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }

  // ProgressBar creation
  Widget buildbar(int value) {
    return Container(
      width: 200,
      height: 10,
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
          color: Colors.white),
      child: LinearProgressIndicator(
        value: value / 100,
        backgroundColor: Colors.white,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  // ProgresBar value
  progressBarValue(String lDSApploanstatus) {
    if (lDSApploanstatus == "DR") {
      return 10;
    } else if (lDSApploanstatus == "RKYC") {
      return 20;
    } else if (lDSApploanstatus == "WKYC") {
      return 30;
    } else if (lDSApploanstatus == "AI") {
      return 40;
    } else if (lDSApploanstatus == "BD") {
      return 50;
    } else if (lDSApploanstatus == "LR") {
      return 60;
    } else if (lDSApploanstatus == "WPA" ||
        lDSApploanstatus == "PA" ||
        lDSApploanstatus == "WCV") {
      return 90;
    } else {
      return 80;
    }
  }
}
