import 'dart:async';

import 'package:digiwaste_dev/Transporter/transporterSchedules.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'dart:convert';

class TransporterNavigator extends StatefulWidget {
  @override
  TransporterNavigatorState createState() => TransporterNavigatorState();
}

class TransporterNavigatorState extends State<TransporterNavigator> {
  Completer<GoogleMapController> _controller = Completer();
  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    print("here");
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 17,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }


  var userData;
  var scheduleId;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);

    var sheduleIdJson = localStorage.getString('scheduleId');
    var schedule = json.decode(sheduleIdJson);

    setState(() {
      userData = user;
      scheduleId = schedule;
    });
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => TransporterSchedule()));
            }),
        title: Text("Moi University"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new ItemList(
                            list: snapshot.data,
                          )
                        : new Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ))
//          _zoomminusfunction(),
//          _zoomplusfunction(),
//          _buildContainer1()
          //  _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(0.2835124, 35.292363), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(0.2835124, 35.292363), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 150,
          child: FutureBuilder<List>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ItemList(
                      list: snapshot.data,
                    )
                  : new Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            restaurantName,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                child: Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
              child: Icon(
                FontAwesomeIcons.solidStarHalf,
                color: Colors.amber,
                size: 15.0,
              ),
            ),
            Container(
                child: Text(
              "(946)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
          ],
        )),
        SizedBox(height: 5.0),
        /*Container(
            child: Text(
              "American \u00B7 \u0024\u0024 \u00B7 1.6 mi",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Closed \u00B7 Opens 17:00 Thu",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),*/
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(0.2835124, 35.292363), zoom: 17),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          newyork1Marker,
          newyork2Marker,
          newyork3Marker,
          //gramercyMarker,
          bernardinMarker,
          blueMarker
        },
      ),
    );
  }
//
//  Future<void> _gotoLocation(double lat, double long) async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//      target: LatLng(lat, long),
//      zoom: 17,
//      tilt: 50.0,
//      bearing: 45.0,
//    )));
//  }

//  Future<List> fetchData() async {
//    var postdata = {
//      'transporter_id': scheduleId.toString(),
//    };
//
//    final response = await CallApi().postData(postdata, 'showCollections');
//    final dynamic data = json.decode(response.body);
//    print("schedule id " + scheduleId.toString());
//    //print("the data is"+data['collections']['id']);
//    return data['collections'];
//  }

  Future<List> fetchData() async {
    var postData = {'schedule_id': scheduleId};
    final response = await CallApi().postData(postData, 'showCollections');

    final dynamic data = json.decode(response.body);
    //print(data['collections']);
    return data['collections'];
  }
}

getMarker (String markerID,double lat,double long,String name){
Marker(
  markerId: MarkerId(markerID),
  position: LatLng(lat,long),
  infoWindow: InfoWindow(title: name),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);}

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

class ItemList extends StatelessWidget {
  //Completer<GoogleMapController> _controller = Completer();



  List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //scrollDirection: Axis.horizontal,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    //print("hello");
                    TransporterNavigatorState()._gotoLocation(list[i]['latitude'], list[i]['longitude']);
                    getMarker(list[i]['region'], list[i]['latitude'], list[i]['longitude'],list[i]['firstName']);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(list[i]['firstName']),
                      SizedBox(
                        width: 5,
                      ),
                      Text(list[i]['lastName']),
                    ],
                  ),
                  leading: Icon(Icons.widgets),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Phone Number : '),
                            Text(list[i]['phone'])
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('Region : '),
                            Text(list[i]['region'])
                          ],
                        ),
//                    SizedBox(height: 2,),
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
              ));
        });
  }
}
