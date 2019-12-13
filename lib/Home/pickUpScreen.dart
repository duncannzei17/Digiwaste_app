import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Login/loginScreen.dart';
import 'package:digiwaste_dev/Admin/createSchedule.dart';
import 'package:digiwaste_dev/Admin/transporterScreen.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class PickUp extends StatefulWidget {
  @override
  _PickUpState createState() => _PickUpState();
}

class _PickUpState extends State<PickUp>  {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List> fetchData() async{

    final response = await CallApi().getData('showSchedules');
    final dynamic data= json.decode(response.body);
    print(data);
    return data['schedules'];

  }

  void logout() async{

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.bars),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();

            }),
        title: Text("PickUps"),
        centerTitle: true,
      ),
      body: FutureBuilder<List>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData ? new ItemList(list: snapshot.data,)
              : new Center(
            child:  CircularProgressIndicator(),
          );
        },
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
              title: Text('Pickups'),
              onTap: () {
                //
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.calendar),
              title: Text('History'),
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

                      Text(list[i]['region']),

                    ],
                  ),

                  leading: Icon(Icons.access_time),

                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 2,),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.start,

                          children: <Widget>[
                            Text('Collection Day : '),

                            Text(list[i]['collection_day'])
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Start Time : '),
                            Text(list[i]['start_time'])
                          ],
                        ),
                        SizedBox(height: 2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('End Time : '),
                            Text(list[i]['end_time'])
                          ],
                        ),
                        SizedBox(height: 2,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Text('National ID : '),
//                        Text(list[i]['address'])
//                      ],
//                    ),
//                    SizedBox(height: 2,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      children: <Widget>[
//                        Text('Age : '),
//                        Text(list[i]['age'])
//                      ],
//                    ),
//
//                  ],
//                ),
                      ]),
                  /*trailing:
                  Switch(
                    onChanged: _someFunction(),
                    value: list[i]['end_time'],
                ),*/

                ),
              )
          );
        })
    ;
  }}











