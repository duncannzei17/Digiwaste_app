import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi{
<<<<<<< HEAD

  final String _url = 'http://aeb381fa.ngrok.io/api/';


=======
  final String _url = 'http://b20ed27b.ngrok.io/api/';
>>>>>>> e9ffc5b8adbc76fad136e8268beb073b36261621
 /* String get url {
    return _url;
  }*/
returnUrl(){
  return "http://aeb381fa.ngrok.io/api/";
}
  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }
  
  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  _getToken() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      return '?token=$token';
  }
}