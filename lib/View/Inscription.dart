import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/View/Authentification.dart';

import '../globalsVariables.dart';

class Inscription extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Inscription();
  }
}

class _Inscription extends State<Inscription>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myUserNameFocus = FocusNode();
  final FocusNode myEmailFocus = FocusNode();
  final FocusNode myTelephoneFocus = FocusNode();
  final FocusNode myPasswordFocus = FocusNode();

  TextEditingController myUserNameController = new TextEditingController();
  TextEditingController myEmailController = new TextEditingController();
  TextEditingController myTelephoneController = new TextEditingController();
  TextEditingController myPasswordController = new TextEditingController();

  bool _obscureText = true;

  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            entete(context),

            Text(
              'Inscription',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 10,
                color: const Color(0xff2a0202),
                height: 0.425,
              ),
              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.0),

            Container(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        focusNode: myUserNameFocus,
                        controller: myUserNameController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: width(context) / 25
                        ),
                        decoration: InputDecoration(
                            hintText: "Nom d'utilisateur |",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.brown)
                            )
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        focusNode: myEmailFocus,
                        controller: myEmailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: width(context) / 25
                        ),
                        decoration: InputDecoration(
                            hintText: "Adresse Mail |",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.brown)
                            )
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        focusNode: myTelephoneFocus,
                        controller: myTelephoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: width(context) / 25
                        ),
                        decoration: InputDecoration(
                            hintText: "N° Téléphone |",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.brown)
                            )
                        ),
                      ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          focusNode: myPasswordFocus,
                          controller: myPasswordController,
                          obscureText: _obscureText,
                          style: TextStyle(
                              fontSize: width(context) / 25
                          ),
                          decoration: InputDecoration(
                            hintText: "Mot de passe |",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.brown)
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureText
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: width(context) / 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: button("Inscription", context, (){}),
                    ),

                    SizedBox(height:10.0),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return Authentification();
                            })
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'PT Sans',
                            fontSize: 12,
                            color: const Color(0xff1a1a1a),
                            height: 1.4166666666666667,
                          ),
                          children: [
                            TextSpan(
                              text: 'Vous avez un compte?',
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: const Color(0xff0019b9),
                              ),
                            ),
                            TextSpan(
                              text: 'Connectez-vous.',
                              style: TextStyle(
                                color: const Color(0xff0019b9),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 10.0)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}