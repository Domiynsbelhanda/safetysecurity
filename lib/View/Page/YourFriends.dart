import 'package:flutter/material.dart';
import 'package:safetysecurity/globalsVariables.dart';

class YourFriends extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YourFriends();
  }
}

class _YourFriends extends State<YourFriends>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              backButton(context),
            ],
          ),
        ),
        title: Text(
          'SAFETY SECURITY',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}