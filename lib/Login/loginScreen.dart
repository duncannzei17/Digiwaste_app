import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:digiwaste_dev/Home/userHomeScreen.dart';
import 'package:digiwaste_dev/SignUp/signUpScreen.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Transporter/transporterHomeScreen.dart';
import 'package:digiwaste_dev/Admin/adminHomeScreen.dart';


class LogIn extends StatefulWidget {
//  MyApp({Key key}) : super(key: key);
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {


  bool _isLoading = false;
/*
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
*/
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  _showMsg(msg) { //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.05), BlendMode.dstATop),
            image: AssetImage('images/mountains.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: ListView(

            children: <Widget>[
              ///////////  background///////////
              new Container(
                padding: EdgeInsets.fromLTRB(20,100,20,20),
                child: Center(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 50.0,
                  ),
                ),
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "EMAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: TextFormField(

                        style: TextStyle(color: Color(0xFF000000)),
                        controller: mailController,
                        cursorColor: Color(0xFF9b9b9b),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border:InputBorder.none,
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.deepOrange,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        validator: (String value) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(value))
                            return 'Enter Valid Email';
                          else
                            return null;
                        },
                        onSaved: (String val) {
                          _email = val;
                        },

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: new Text(
                        "PASSWORD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child:   TextFormField(
                        //  key: _formKey,
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Color(0xFF9b9b9b),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.deepOrange,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Color(0xFF9b9b9b),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              new Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FlatButton(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 10, right: 10),
                            child: Text(
                              _isLoading ? 'Auth...' : 'LOG IN',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          color: Colors.red,
                          disabledColor: Colors.grey,
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(20.0)),
                          onPressed:_validateInputs,
                          // _isLoading ? null :  _handleLogin
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => SignUp()));
                    },
                    child: Text(
                      'Create new Account',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  void _login() async{

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      if (body['user']['user_type'] == 2){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => AdminHome()));
      }else if (body['user']['user_type'] == 1){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => TransporterHome()));
      }else{
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => Home()));
      }

    }else{
      _showMsg(body['message']);
    }


    setState(() {
      _isLoading = false;
    });


  }

   _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      //_formKey.currentState.save();
print("hello world");
_login();
print("hello world");
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }



}
