import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safetysecurity/Model/Alerte.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/View/Page/ArticleItemDetails.dart';

import 'Controller/ProgressDialog.dart';
import 'Model/Articles.dart';
import 'Model/Commentaires.dart';
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
List<Invitation> invitations;
List<Amis> amis;
List<Alerte> alertes;

String apiKey = 'AIzaSyCXD9g7N4ntnTdM81_h9JpphvaMXtdFTmw';

Position position;

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
      color: Colors.blue,
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        '${text}',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Colors.white,
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
    height: width(context) / 1.4,
    child: Column(
      children: [

        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item.titre.toUpperCase()}',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${item.description}',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xFF343434),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),

        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: width(context) / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${item.image}'
                      ),
                    )
                ),
              ),
            ]
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                FirebaseFirestore.instance.collection('Articles').doc(item.uid)
                    .update({"like": FieldValue.increment(1)});
                showInSnackBar("Vous avez liké", _scaffoldKey, context);
              },
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                    ),

                    Text(
                        '   ${item.like}',
                        style: TextStyle(
                            color: Colors.black
                        )
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return ItemDetails(comment: true, item: item,);
                    })
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                          color: Colors.black,
                          size: width(context) / 15,
                        ),
                        Text(
                            '   Commenter',
                            style: TextStyle(
                                color: Colors.black
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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

Widget backButton(context){
  return GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(15)
          ),
          border: Border.all(
            color: Colors.grey[300],
            width: 1,
          )
      ),
      child: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.black,
        size: 28,
      ),
    ),
  );
}


Widget item(String text, IconData icon, VoidCallback press){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xff0040ff),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(
                text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            )
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }