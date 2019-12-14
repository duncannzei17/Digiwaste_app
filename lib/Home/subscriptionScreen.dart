import 'dart:convert';

import 'package:digiwaste_dev/Admin/transporterScreen.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:digiwaste_dev/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subscription extends StatefulWidget {
  Subscription() {
    MpesaFlutterPlugin.setConsumerKey("F3MZV1LEiRE7E8hnDMPc1jbe7FL4OanQ");
    MpesaFlutterPlugin.setConsumerSecret("QyVmrn9tHIclGLTw");
  }

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  var userData;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //var number=TextEditingController();
  Future<void> startCheckout({String userPhone, double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https",
              host: "sandbox.safaricom.co.ke",
              path: "/callback"),
          accountReference: "digitrash",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey:
          'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      /*Update your db with the init data received from initialization response,
      * Remaining bit will be sent via callback url*/
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:40),
            Image(
              image: new AssetImage("images/mpesa-logo.png"),
              height: 120.0,
              width: 120.0,
            ),
            SizedBox(height: 80,),
            Container(
                alignment: Alignment.center,
                height: 50.0,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.0),
                  gradient: LinearGradient(
                      colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft),
                ),
                child: Center(
                    child: MaterialButton(
                      onPressed: () {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: " Transaction Confirmation",
                          //desc: "Make Payment to digiWaste account?",
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Text("Send to:       DigiWaste"),
                              Text("Amount:       400"),
                              Text("Charges:      15")
                            ],
                          ),

                          buttons: [
                            DialogButton(
                              child: Text(
                                "NO",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              gradient: LinearGradient(colors: [
                                Color(0xFFFB415B),
                                Color(0xFFEE5623)
                              ]),

                            ),
                            DialogButton(
                              child: Text(
                                "YES",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {
                                startCheckout(userPhone: "254719724004", amount: 1);
                                //  Navigator.pop(context);

                              },
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(19, 123, 71, 1.0),
                                Color.fromRGBO(19, 123, 19, 1.0)
                              ]),
                            )
                          ],
                        ).show();
                        //startCheckout(userPhone: "254719724004", amount: 400);
                      },
                      child: Text(
                        "Monthly Subscription @ Ksh 400",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ))),
            SizedBox(height: 50,),
            Container(

                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            gradient: LinearGradient(
                                colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft),
                          ),
                          child: Center(
                              child: MaterialButton(
                                onPressed: () {
                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Confirm Transaction",
                                    //desc: "Make Payment to digiWaste account?",
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Text("Send to:       DigiWaste"),
                                        Text("Amount:       1000"),
                                        Text("Charges:      15")
                                      ],
                                    ),

                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "NO",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        gradient: LinearGradient(colors: [
                                          Color(0xFFFB415B),
                                          Color(0xFFEE5623)
                                        ]),

                                      ),
                                      DialogButton(
                                        child: Text(
                                          "YES",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () {
                                          startCheckout(userPhone: "254719724004", amount: 1);
                                          //  Navigator.pop(context);

                                        },
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(19, 123, 71, 1.0),
                                          Color.fromRGBO(19, 123, 19, 1.0)
                                        ]),
                                      )
                                    ],
                                  ).show();
                                },
                                child: Text(
                                  "Three Months Subscription @ Ksh 1000",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )))
                    ])),
          ],
        ),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Icon(
                FontAwesomeIcons.userCircle,
                size: 100.0,
                color: Color(0xFF9b9b9b),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFF835F),
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.truck),
              title: Text('Transporters'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Transporter()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.truck),
              title: Text('Schedules'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Transporter()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.truck),
              title: Text('Payment'),
              onTap: () {
          //
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout'),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  final planetThumbnail = new Container(
    // margin: new EdgeInsets.symmetric(vertical: 16.0),

    child: new Image(
      image: new AssetImage("images/mpesa-logo.png"),
      height: 92.0,
      width: 92.0,
    ),
  );

  void logout() async {
    // logout from the server ...
    var res = await CallApi().getData('logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LogIn()));
    }
  }
}