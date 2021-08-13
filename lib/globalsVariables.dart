import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Controller/ProgressDialog.dart';
import 'Model/Articles.dart';
import 'Model/Users.dart';

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

User currentFirebaseUser;

List<Articles> articles;
List<Users> users;
Users currentUsers;


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

showDialogs(String text, context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => ProgressDialog(status: text),
  );
}

Widget itemArticle(context, _scaffoldKey, Articles item){
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: width(context) / 2,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width(context) / 25),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                  '${item.image}'
                ),
            )
          ),
        ),

        SizedBox(height: 5.0),

        Text(
          '${item.titre}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 20,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),

        SizedBox(height: 3.0),

        Text(
          '${item.description}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 25,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),

        SizedBox(height: 7.0,),

        Container(
          height: width(context) / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    FirebaseFirestore.instance.collection('Articles').doc(item.uid)
                        .update({"like": FieldValue.increment(1)});
                    showInSnackBar("Vous avez liké", _scaffoldKey, context);
                  },
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff99c0e1),
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.heart,
                            color: const Color(0xff444d5e),
                            size: width(context) / 15,
                          ),
                          Text(
                            '   Like ${item.like}'
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 5.0),

              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showInSnackBar("Vous avez commenté", _scaffoldKey, context);
                  },
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff99c0e1),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.comment,
                            color: const Color(0xff444d5e),
                            size: width(context) / 15,
                          ),
                          Text(
                              '   Comment ${item.comment}'
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget utilisateurs(context, id, item){

  List<Users> utilisateurs = users
      .where(
          (doc) => doc.id.toLowerCase()
          .contains(id.toLowerCase()))
      .toList();
  return Container(
    height: width(context) / 8,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage:
            NetworkImage('${utilisateurs[0].image}'),
            backgroundColor: Colors.transparent,
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${utilisateurs[0].name}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 20,
              ),
              textAlign: TextAlign.left,
            ),

            Text(
              '${item.date}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 26,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
      ],
    ),
  );
}