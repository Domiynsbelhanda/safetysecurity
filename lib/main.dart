import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View/Authentification.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
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
      color: Colors.lightBlue,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.brown,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Authentification(),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}