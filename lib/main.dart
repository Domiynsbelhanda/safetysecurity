import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safetysecurity/View/Accueil.dart';

import 'View/Connexion.dart';
import 'globalsVariables.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIOverlays([]);

  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
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
      home: (currentFirebaseUser == null) ? Authentification() : HomeScreen()
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}