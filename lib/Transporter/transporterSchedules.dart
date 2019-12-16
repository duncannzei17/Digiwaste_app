import 'dart:convert';
import 'package:digiwaste_dev/Transporter/transporterNav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Login/loginScreen.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class TransporterSchedule extends StatefulWidget {
  @override
  _TransporterScheduleState createState() => _TransporterScheduleState();
}

class _TransporterScheduleState extends State<TransporterSchedule>  {

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

  Future<List> fetchData() async{

    var postdata = {
      'transporter_id' : userData['id'],

    };

    final response = await CallApi().postData(postdata, 'transporterSchedules');
    final dynamic data= json.decode(response.body);
    //print(data['schedules']);
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
        title: Text("Schedules"),
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
              title: Text('Collections'),
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

  void _showNavigation(id) async{

    id.toString();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('scheduleId',id );


  }

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

                      SizedBox(width: 5,),
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
                      ]),
                  trailing:  Container(
                    //  height: 150,
                    width: 40,
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),
                          onPressed:(){
                           _showNavigation(list[i]['id'].toString());
                           Navigator.push(
                               context,
                               new MaterialPageRoute(
                                   builder: (context) => TransporterNavigator()));

                          } ,
                          child:Icon(Icons.forward,color: Colors.deepOrange,),

                          //color: Colors.deepOrange,)
                          // SizedBox(height:4),
                        ) ],

                    ),
                  ),
                ),
              )
          );
        })
    ;
  }
}


