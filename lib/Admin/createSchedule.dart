import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:digiwaste_dev/Api/api.dart';


class CreateSchedule extends StatefulWidget {

  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}
/*class Item {
  const Item(this.name);
  final String name;

}
class Region {
  const Region(this.name);
  final String name;
}*/
class _CreateScheduleState extends State<CreateSchedule> {



  List<String> _intervals = ['daily', 'weekly'];
  String _selectedFrequency;

  List<String> _regions = ['Moi University', 'Eldoret'];
  String _selectedRegion;

  String _date = "Start Date";
  String _time = "Start Time";
  String _time1 = "Start Time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.calendar),
            onPressed: () {
              //

            }),
        title: Text("Create Schedule"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: DropdownButton(

                    hint:  Text("Set Frequency"),
                    value: _selectedFrequency,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFrequency = newValue;
                      });
                    },
                    items: _intervals.map((interval) {
                      return  DropdownMenuItem(
                        value: interval,
                          child: Row(
                            children: <Widget>[

                              Text(
                                interval,
                                style:  TextStyle(color: Colors.black),
                              ),
                              SizedBox(width: 150,)
                            ],
                          ),
                      );
                    }).toList(),
                  ),

                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  //
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: DropdownButton(
                    hint:  Text("Select Region"),
                    value: _selectedRegion,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRegion = newValue;
                      });
                    },
                    items: _regions.map((region) {
                      return  DropdownMenuItem(
                        value: region,
                        child: Row(
                          children: <Widget>[

                            Text(
                              region,
                              style:  TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 150,)
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                ),

                color: Colors.white,
              ),

              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.deepOrange,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.deepOrange,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.deepOrange,
                                ),
                                Text(
                                  " $_time1",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  height: 50.0,
                  width:340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFFB415B),
                          Color(0xFFEE5623)
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft
                    ),
                  ),
                  child: Center(
                    child: FlatButton(
                      onPressed: (){
                        _createSchedule();
                    },
                      child: Text(
                        "CREATE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),     ),
                    ),
                  )
              ) ],
          ),

        ),
      ),
    );
  }

  void _createSchedule() async {


    var data = {
      'region' : _selectedRegion,
      'frequency' : _selectedFrequency,
      'collection_day' : _date,
      'start_time' : _time,
      'end_time' : _time1,
    };

    await CallApi().postData(data, 'addSchedule');

  }
}

/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:digiwaste_dev/Api/api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CreateSchedule extends StatefulWidget {
  @override
  _CreateScheduleState createState() => _CreateScheduleState();
}


class _CreateScheduleState extends State<CreateSchedule> {
  String _date = "Start Date";
  String _time = "Start Time";
  String _time1 = "End Time";
  String _region = "Moi University";
  String _frequency = "Daily";




  @override
  void initState() {
    super.initState();
  }

  DropdownButton _regionButton() => DropdownButton<String>(
    isExpanded: true,
    items: [
      DropdownMenuItem<String>(
        value: "Moi University",
        child: Text(
          "Moi University",
        ),
      ),
      DropdownMenuItem<String>(
        value: "Eldoret",
        child: Text(
          "Eldoret",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        _region = value;
      });
    },
    value: _region,
    elevation: 2,
    isDense: true,
    iconSize: 40.0,
  );

  DropdownButton _frequencyButton() => DropdownButton<String>(
    isExpanded: true,
    items: [
      DropdownMenuItem<String>(
        value: "Daily",
        child: Text(
          "Daily",
        ),
      ),
      DropdownMenuItem<String>(
        value: "Weekly",
        child: Text(
          "Weekly",
        ),
      ),
    ],
    onChanged: (value) {
      setState(() {
        _frequency = value;
      });
    },
    value: _frequency,
    elevation: 2,
    isDense: true,
    iconSize: 40.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              _regionButton(),
              SizedBox(
                height: 20.0,
              ),
              _frequencyButton(),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time1 = '${time.hour} : ${time.minute} : ${time.second}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time1",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),

            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createSchedule,
        child: Icon(FontAwesomeIcons.plus),
      ),

    );
  }

  void _createSchedule() async {


    var data = {
      'collection_day': _date,
      'start_time' : _time,
      'end_time' : _time1,
      'frequency' : _frequency,
      'region' : _region,
    };

    var res = await CallApi().postData(data, 'addSchedule');
    var body = json.decode(res.body);
    if(body['success']){
      //
    }

  }
}*/
