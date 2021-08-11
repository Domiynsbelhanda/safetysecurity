import 'package:flutter/material.dart';

import '../globalsVariables.dart';

class Authentification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Authentification();
  }
}

class _Authentification extends State< Authentification>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            entete(context)
          ],
        ),
      ),
    );
  }
}