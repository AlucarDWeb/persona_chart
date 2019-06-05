
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona_chart/Homepage.dart';
import 'package:persona_chart/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Persona5',
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 40.0, fontWeight: FontWeight.normal, color: Colors.white),
          subtitle: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.normal),
          body1: TextStyle(fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.normal)
        )
      ),
      home: HomePage(datasource: Persona.readJsonData()),
      debugShowCheckedModeBanner: false,
    );
  }
}