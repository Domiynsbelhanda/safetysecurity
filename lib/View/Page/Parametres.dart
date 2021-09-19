import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/View/Page/Notifications.dart';

import '../../globalsVariables.dart';

class About extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _About();
  }
}

class _About extends State<About>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item('NOTIFICATIONS', FontAwesomeIcons.bell, (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return Notifications();
                })
              );
            }),

            Text('V. 1.0.0, Update Launch Alert')
          ],
        ),
      ),
    );
  }
}