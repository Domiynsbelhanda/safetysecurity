import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';
import 'package:safetysecurity/View/Connexion.dart';
import 'package:safetysecurity/globalsVariables.dart';
import 'package:safetysecurity/main.dart';

class Authentifications {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> SignIn(String email, String password, context, _scaffoldKey) async{
    try{
      User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
      showInSnackBar("Connectée.", _scaffoldKey, context);

      currentFirebaseUser = user;

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return HomeScreen();
          })
      );
      return user.uid;
    } catch (exception) {
      if(exception.code =="wrong-password"){
        showInSnackBar("Mot de passe incorrect.", _scaffoldKey, context);
      }
      else if(exception.code =="user-not-found"){
        showInSnackBar("Vous n'avez pas de compte.", _scaffoldKey, context);
      }
      else if (exception.code =="user-disabled"){
        showInSnackBar("Compte desactivé par l'admin", _scaffoldKey, context);
      } else if (exception.code =="invalid-email"){
        showInSnackBar("Adresse mail invalide.", _scaffoldKey, context);
      } else if (exception.code =="too-many-requests"){
        showInSnackBar("Erreur, compte deja connecté", _scaffoldKey, context);
      }
      else {
        showInSnackBar(exception.code, _scaffoldKey, context);
      }
    }
  }

  Future<String> SignUp(String email, String password, String telephone, String name, context, _scaffoldKey) async{
    try{

      User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;

      var data={
        "key": user.uid.toString(),
        "email": email,
        "password": password,
        "telephone": telephone,
        "name": name,};

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await
      _firestore.collection('Users').doc(user.uid.toString()).set(data);
      showInSnackBar("Inscription effectuée.", _scaffoldKey, context);

      currentFirebaseUser = user;

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return HomeScreen();
          })
      );

      return user.uid;

    } catch (exception) {
      if (exception.code == "email-already-in-use") {
        showInSnackBar("Adresse mail déjà utilisée.", _scaffoldKey, context);
      } else {
        showInSnackBar(exception.code, _scaffoldKey, context);
      }
    }

  }

  Future<String> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    return user.uid;
  }

  Future<void> signOut(context) async{
    _firebaseAuth.signOut();

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context){
          return MyApp();
        })
    );
  }

  Future<void> resetmail(String email, context, _scaffoldKey) async{

    try{

      await _firebaseAuth.sendPasswordResetEmail(email: email);
      showInSnackBar("Email de restauration envoyé.", _scaffoldKey, context);

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return Authentification();
          })
      );


    } catch (exception) {
      if (exception.code == "invalid-email") {
        showInSnackBar("Erreur, votre adresse mail est invalide.", _scaffoldKey, context);
      } else if (exception.code == 'user-not-found') {
        showInSnackBar("Vous n'avez pas de compte", _scaffoldKey, context);
      }
      else {
        showInSnackBar(exception.code, _scaffoldKey, context);
      }
    }
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
}