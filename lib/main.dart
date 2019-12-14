import 'package:flutter/material.dart';
import 'package:digiwaste_dev/Home/userHomeScreen.dart';
import 'package:digiwaste_dev/Login/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Admin/transporterScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  static const PrimaryColor = const Color(0xFFFC663C);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
        body: _isLoggedIn ? Home() :  LogIn(),
       //body: Transporter()
      ),

    );
  }
}
