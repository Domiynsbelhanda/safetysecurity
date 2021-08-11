import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Safety Security",
      color: Color(0x0099C0E1),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white
      ),
    );
  }
}