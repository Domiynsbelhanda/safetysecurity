import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

Widget entete(context) {
  return Container(
    height: height(context) / 4,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(""
            "https://firebasestorage.googleapis.com/v0/b/car-rental-rdc.appspot.com/o/vector1.png?alt=media&token=e91b326c-87df-429d-b08b-fef5eef79a75"),
        fit: BoxFit.cover,
      )
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'SAFETY SECURITY',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: width(context) / 16,
          color: const Color(0xff4e392a),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    )
  );
}

Widget button(text, context, function){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Color(0xff77ACE3),
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        '${text}',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: const Color(0xff2a0202),
          fontWeight: FontWeight.w700,
          height: 1.0625,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

void showInSnackBar(String value, _scaffoldKey, context) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,),
    ),
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 3),
  ));
}

User currentFirebaseUser;