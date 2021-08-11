import 'package:flutter/material.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/globalsVariables.dart';

class HomeScreen extends StatefulWidget{
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
      body: Column(
        children: [
          Text(
            '${currentFirebaseUser.email}'
          ),

          TextButton(
            child: Text('Deconnexion'),
            onPressed: (){
              auth.signOut(context);
            },
          )
        ],
      ),
    );
  }
}