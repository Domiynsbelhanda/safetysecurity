import 'package:flutter/material.dart';
import 'package:safetysecurity/Controller/Authentification.dart';

import '../globalsVariables.dart';
import 'Connexion.dart';

class ResetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPassword>{

  Authentifications authentifications = new Authentifications();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myEmailFocus = FocusNode();

  TextEditingController EmailController = new TextEditingController();

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
              'Restaurer le MDP',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 10,
                color: const Color(0xff2a0202),
                height: 0.425,
              ),
              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.0,),

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
                      child: button("Envoyez l'email", context, (){
                        if(EmailController.text.isEmpty){
                          showInSnackBar("Entrez une adresse mail", _scaffoldKey, context);
                          return;
                        }

                        authentifications.resetmail(EmailController.text, context, _scaffoldKey);
                      }),
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
}