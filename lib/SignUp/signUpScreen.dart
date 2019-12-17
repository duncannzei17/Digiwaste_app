  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:digiwaste_dev/Location/userLocation.dart';
  import 'package:digiwaste_dev/Login/loginScreen.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:digiwaste_dev/Api/api.dart';



  class SignUp extends StatefulWidget {
    @override
    _SignUpState createState() => _SignUpState();
  }

  class _SignUpState extends State<SignUp> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    bool _autoValidate = false;

    String _email;
    String _firstname;
    String _phone;
    String _lastname;

    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    bool _isLoading = false;

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
                new Container(
                  padding: EdgeInsets.fromLTRB(20,30,20,20),
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
                        padding: const EdgeInsets.only(left: 40.0,top: 5),
                        child: new Text(
                          "FIRSTNAME",
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
                Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 1.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.redAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    controller: firstNameController,
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.deepOrange,
                      ),
                      hintText: "John",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    validator: (String value) {
                      if (value.length < 3)
                        return 'Name must be more than 2 charater';
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      _firstname = val;
                    },
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0,top: 5),
                        child: new Text(
                          "LASTNAME",
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
                Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 1.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.redAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    controller: lastNameController,
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.deepOrange,
                      ),
                      hintText: "Doe",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    validator: (String value) {
                      if (value.length < 3)
                        return 'Name must be more than 2 charater';
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      _lastname = val;
                    },
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0,top: 5),
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
                /////////////// Email ////////////

                Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 1.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.redAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    controller: mailController,
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Colors.deepOrange,
                      ),
                      hintText: "johndoe@gmail.com ",
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
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0,top: 5),
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
                /////////////// password ////////////

                Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 1.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.redAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.deepOrange,
                      ),
                      hintText: "************",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(left: 40.0,top: 5),
                        child: new Text(
                          "PHONE NUMBER",
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
                Container(
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 1.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.redAccent,
                          width: 0.5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    controller: phoneController,
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      prefixIcon: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.deepOrange,
                      ),
                      hintText: "0712345678",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    validator:(String value) {
// Indian Mobile number are of 10 digit only
                      if (value.length != 10)
                        return 'Mobile Number must be of 10 digit';
                      else
                        return null;
                    },
                    onSaved: (String val) {
                      _email = val;
                    },
                  ),
                ),

                /////////////// SignUp Button ////////////

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      child: Text(
                        _isLoading ? 'Creating...' : 'Create account',
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => LogIn()));
                      },
                      child: Text(
                        'Already have an Account',
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
    void _handleLogin() async {
      setState(() {
        _isLoading = true;
      });

      var data = {
        'firstName' : firstNameController.text,
        'lastName' : lastNameController.text,
        'email' : mailController.text,
        'password' : passwordController.text,
        'phone' : phoneController.text,
      };

      var res = await CallApi().postData(data, 'register');
      var body = json.decode(res.body);
      if(body['success']){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => GetLocationPage()));
      }

      setState(() {
        _isLoading = false;
      });



    }

    _validateInputs() {
      if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
        //_formKey.currentState.save();
      //  print("hello world");
        _handleLogin();
        //print("hello world");
      } else {
//    If all data are not valid then start auto validation.
        setState(() {
          _autoValidate = true;
        });
      }
    }
}
