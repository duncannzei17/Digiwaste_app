import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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


var userData;
var scheduleId;
class _PickUpState extends State<PickUp>  {


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
  bool status=false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(

              padding: const EdgeInsets.all(9),
              child: Card(

               margin: EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5,15,2,1),
                  child: Column(
                    children: <Widget>[
                      ListTile(

                        isThreeLine: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.0),

                        //contentPadding: EdgeInsets.all(3),
                        title: Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            Text(list[i]['region']),
                          ],
                        ),
                        trailing:  Container(
                        //  height: 150,
                          width: 80,
                          child: ListView(
                            //mainAxisSize: MainAxisSize.min,
                              //  crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Confirm ",style: TextStyle(
                                color: Color(0xff868686),
                                fontSize: 12
                              ),),
                              FlatButton(
                                color: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                                               ),
                                onPressed:(){
                                 scheduleId=list[i]['id'].toString();
                                 //print(scheduleId);

                                  Alert(
                                    context: context,
                                    type: AlertType.warning,
                                    title: "Confirm ",
                                    //desc: "Make Payment to digiWaste account?",
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Text("Select Collection?"),

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
                                        onPressed: () async {
                                          var data = {
                                            'user_id' : userData['id'] ,
                                            'schedule_id' : scheduleId,

                                          };

                                          await CallApi().postData(data, 'addCollection');
                                          var alertStyle = AlertStyle(
                                            animationType: AnimationType.fromTop,
                                            isCloseButton: false,
                                            isOverlayTapDismiss: false,
                                            descStyle: TextStyle(fontWeight: FontWeight.bold),
                                            animationDuration: Duration(milliseconds: 400),
                                            alertBorder: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(0.0),
                                              side: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            titleStyle: TextStyle(
                                              color: Colors.red,
                                            ),
                                          );
                                          Alert(
                                            context: context,
                                            style: alertStyle,
                                            type: AlertType.info,
                                            title: "SUCCESS",
                                            desc: "Collection requsted",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Cool",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                                color: Color.fromRGBO(0, 179, 134, 1.0),
                                                radius: BorderRadius.circular(0.0),
                                              ),
                                            ],
                                          ).show();

                                          // startCheckout(userPhone: "254719724004", amount: 1);
                                          //  Navigator.pop(context);

                                        },
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(19, 123, 71, 1.0),
                                          Color.fromRGBO(19, 123, 19, 1.0)
                                        ]),
                                      )
                                    ],
                                  ).show();
                                } ,
                                child:Icon(Icons.add,color: Colors.white,),

                              //color: Colors.deepOrange,)
                             // SizedBox(height:4),
                              ) ],

                          ),
                        ),

                        leading: Container(
                          height: 40,
                            width: 40,
                            child: Icon(Icons.access_time)),

                        subtitle: Container(
                          //margin: EdgeInsets.fromLTRB(4, 10, 0, 25),
                          child: Column(

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
                        ),
                        /*trailing:
                        Switch(
                          onChanged: _someFunction(),
                          value: list[i]['end_time'],
                      ),*/

                      ),
                    ],
                  ),
                ),
              )
          );
        })
    ;
  }
}











