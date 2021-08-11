import 'package:flutter/material.dart';

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

Widget entete(context) {
  return Container(
    height: height(context) / 2.5,
    width: double.infinity,
    color: Color(0xFF99C0E1),
    decoration: BoxDecoration(
    ),
    child: Text(
      'SAFETY SECURITY'
    ),
  );
}