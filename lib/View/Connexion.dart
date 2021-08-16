import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';

import '../globalsVariables.dart';
import 'Inscription.dart';
import 'ResetPWD.dart';

class Authentification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Authentification();
  }
}

class _Authentification extends State<Authentification>{

  Authentifications authentifications = Authentifications();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myEmailFocus = FocusNode();
  final FocusNode myPasswordFocus = FocusNode();

  TextEditingController EmailController = new TextEditingController();
  TextEditingController PassWordController = new TextEditingController();

  bool _obscureTextLogin = true;

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
              'Authentification',
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
                        focusNode: myEmailFocus,
                        controller: EmailController,
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
                          focusNode: myPasswordFocus,
                          controller: PassWordController,
                          obscureText: _obscureTextLogin,
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
                                _obscureTextLogin
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
                      padding: const EdgeInsets.only(right:15.0, bottom: 15.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return ResetPassword();
                              })
                          );
                        },
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xff2a0202),
                            height: 1.2142857142857142,
                          ),
                          textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: button("Connexion", context, (){
                        if(EmailController.text.isEmpty){
                          showInSnackBar('Entrez une adresse mail', _scaffoldKey, context);
                          return;
                        }

                        if(PassWordController.text.isEmpty) {
                          showInSnackBar("Entrez un mot de passe", _scaffoldKey, context);
                          return;
                        }

                        authentifications.SignIn(
                            EmailController.text,
                            PassWordController.text, context, _scaffoldKey);

                      }),
                    ),

                    SizedBox(height:10.0),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return Inscription();
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
                              text: 'Vous n\'avez pas compte?',
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color: const Color(0xff0019b9),
                              ),
                            ),
                            TextSpan(
                              text: 'Inscrivez-vous.',
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
                    )
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
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}