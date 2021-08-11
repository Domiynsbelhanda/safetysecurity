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
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'SAFETY SECURITY',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: width(context) / 17,
          color: const Color(0xff4e392a),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    )
  );
}