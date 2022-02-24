import 'dart:async';
import 'dart:math';
import 'package:app_temperature/viewmodel/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'dart:convert';
import 'package:app_temperature/model/Temperature.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Humidity & Tempreture '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int random(min, max){
    return min + Random().nextInt(max - min);
  }
  var temperature = "";
  var humidity = "";

  late Timer timer;
  @override
  void initState() {
    super.initState();
    //callApi();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => callApi());
  }

  void callApi() {
    getNewsData();
  }
  var url1 = "https://thingspeak.com/channels/1661309/field/1.json?&amp;offset=0&amp;results=60;";
  var url2 = "https://thingspeak.com/channels/1661309/field/2.json?&amp;offset=0&amp;results=60;";

  getNewsData() async  {
    var response1 = await http.get(Uri.parse(url1));
    var response2 = await http.get(Uri.parse(url2));
    var _newTemperature= "";
    var _newHumidity= "";

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
    setState((){
      temperature= _newTemperature;
      humidity = _newHumidity;
    });
  }

  Widget buildCountWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 250,
          decoration: new BoxDecoration(
            color: Colors.orange,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Text("Tempreture",
                style: TextStyle(
                  fontSize: 43,
                  fontWeight: FontWeight.bold,

                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.settings_system_daydream),
                      color: Colors.white,
                      iconSize: 80,
                      onPressed: () {  }
                  ),
                  Text(
                    temperature.toString()+"\u2103",
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 250,
          decoration: new BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Text("Humidity",
                style: TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(Icons.water_damage),
                      color: Colors.white,
                      iconSize: 80,
                      onPressed: () {  }
                  ),

                  Text(
                    humidity.toString()+" %",
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: buildCountWidget(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callApi();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
