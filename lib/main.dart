import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'View/Authentification.dart';

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
        backgroundColor: Colors.white,
        primaryColor: Color(0xFF99C0E1),
        accentColor: Color(0xFF4E392A),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Authentification(),
    );
  }
}