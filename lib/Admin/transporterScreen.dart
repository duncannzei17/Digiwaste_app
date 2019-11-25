import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:digiwaste_dev/Admin/searchUser.dart';


class Transporters extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new _TransportersState();
}

class _TransportersState  extends State<Transporters>{

  void _searchUser() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => SearchUser()));
  }

  Future<List> fetchData() async{

    var res = await CallApi().getData('transporters');
    var body = json.decode(res.body['tansporters']);

    return body;

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.truck),
            onPressed: () {
            //
            }),
        title: Text("Transporters"),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? new ItemList(list: snapshot.data,)
              : new Center(
                 child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _searchUser,
        child: Icon(FontAwesomeIcons.plus),
      ),

    );
  }}
class ItemList extends StatelessWidget{
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    Text(list[i]['email']),

                  ],
                ),

                leading: Icon(Icons.widgets),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 2,),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[
                        Text('Region : '),

                        Text(list[i]['region'])
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('ID : '),
                        Text(list[i]['id'])
                      ],
                    ),


                  ],
                ),

              ),

            ),
          );
        })
    ;
  }

}

/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Login/loginScreen.dart';
import 'package:digiwaste_dev/Admin/searchUser.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Transporter extends StatefulWidget {
  @override
  _TransporterState createState() => _TransporterState();
}

class _TransporterState extends State<Transporter> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();

            }),
        title: Text("Transporters"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Card(
                  elevation: 4.0,
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[


                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
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
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Transporter()));
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.calendar),
              title: Text('Schedules'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
      floatingActionButton: FloatingActionButton(
        onPressed: _searchUser,
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
  void logout() async{
    // logout from the server ...
    var res = await CallApi().getData('logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => LogIn()));
    }

  }

  void _searchUser() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => SearchUser()));
  }

}*/
