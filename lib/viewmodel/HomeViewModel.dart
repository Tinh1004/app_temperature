import 'dart:convert';
import 'package:app_temperature/model/Temperature.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier{
  List<Temperature> newsTem = [];
  var _newTemperature= "";
  var _newHumidity= "";

  var url1 = "https://thingspeak.com/channels/1661309/field/1.json?&amp;offset=0&amp;results=60;";
  var url2 = "https://thingspeak.com/channels/1661309/field/2.json?&amp;offset=0&amp;results=60;";

  getNewsData() async  {
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));

    if(response1.statusCode == 200){
      List m = jsonDecode(response1.body)['feeds'];
      _newTemperature = m[m.length - 1]["field1"];
    }else{
      _newTemperature = "";
    }

    if(response2.statusCode == 200){
      List m = jsonDecode(response2.body)['feeds'];
      _newHumidity = m[m.length - 1]["field2"];
    }else{
      _newHumidity = "";
    }
    Temperature newT = new Temperature(_newTemperature,_newHumidity);
    newsTem.add(newT);
    notifyListeners();
  }

}