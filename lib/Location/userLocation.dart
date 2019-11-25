import 'package:digiwaste_dev/Admin/adminHomeScreen.dart';
import 'package:digiwaste_dev/Home/userHomeScreen.dart';
import 'package:digiwaste_dev/Transporter/transporterHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetLocationPage extends StatefulWidget {
  @override
  _GetLocationPageState createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {

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

  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.infoCircle),
              onPressed: () {
            //
              }),
        title: Text("Your location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(0.2835124,35.292363),
          zoom: 17,
        ),
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        tooltip: 'Get Location',
        child: Icon(FontAwesomeIcons.locationArrow),
      ),
    );
  }

  void _getLocation() async {

    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });

    var address = {
      'longitude': currentLocation.longitude,
      'latitude': currentLocation.latitude
    };

    var data = {
      'user_id' : userData['id'],
      'address' : address,
      'region' : "Moi University"
    };

    var res = await CallApi().postData(data, 'userLocation');
    var body = json.decode(res.body);
    if(body['success']) {
      if (userData['user_type'] == 2){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => AdminHome()));
      }else if (userData['user_type'] == 1){
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
    }

  }


}
