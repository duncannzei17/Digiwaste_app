import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();

}
class _PaymentState extends State<Payment> {
  //var number=TextEditingController();
  Future<void> startCheckout({String userPhone, double amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    try {
      //Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https", host: "sandbox.safaricom.co.ke", path: "/callback"),
          accountReference: "digitrash",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');

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
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: (){
            startCheckout(userPhone: "254719724004",amount: 300);
          },
          child: Text("Subscribe monthly "),
        ),
      ),
    );
  }

}