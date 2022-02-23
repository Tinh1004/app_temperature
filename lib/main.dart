import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
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
  int? temperature;
  int? humidity;

  late Timer timer;
  @override
  void initState() {
    super.initState();
    //callApi();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => callApi());
  }

  void callApi() {
    setState((){
      temperature= random(0,40);
      humidity = random(0,100);
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
                  color: Colors.white

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
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: buildCountWidget(),
      ),
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
