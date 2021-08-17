import 'package:flutter/material.dart';
import 'package:safetysecurity/globalsVariables.dart';

class YourPublication extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YourPublication();
  }
}

class _YourPublication extends State<YourPublication>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backButton(context),

                  SizedBox(width: 15.0,),

                  Text(
                    'SAFETY SECURITY',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: width(context) / 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.0),

              Text(
                'VOS PUBLICATIONS',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: width(context) / 15,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),

              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}