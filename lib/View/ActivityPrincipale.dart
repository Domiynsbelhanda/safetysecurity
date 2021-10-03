import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/View/Page/Parametres.dart';
import 'package:safetysecurity/View/Page/UserProfil.dart';
import 'package:safetysecurity/globalsVariables.dart';

import 'Page/Alerter.dart';
import 'Page/HomePage.dart';
import '../Model/Articles.dart';
import '../Model/Users.dart';

class HomeScreen extends StatefulWidget{
  int index;
  HomeScreen({this.index});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>{

  Authentifications auth = Authentifications();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: HomePage()
    );
  }

  @override
  void initState() {
    super.initState();
  }
}