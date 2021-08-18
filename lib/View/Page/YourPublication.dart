import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safetysecurity/Model/Articles.dart';
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
  List<Articles> art;

  @override
  void initState() {
    art = articles
        .where((donnees) => donnees.id.contains(currentFirebaseUser.uid))
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
            padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              backButton(context),
            ],
          ),
        ),
        title: Text(
          'SAFETY SECURITY',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Text(
                  'VOS PUBLICATIONS',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: width(context) / 15,
                    letterSpacing: 2,
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),

              SizedBox(height: 10.0),

              Column(
                  children: art.map((e){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          itemArticle(context, _scaffoldKey, e),

                          SizedBox(height: 2.0),

                          TextButton(
                            onPressed: (){
                              showInSnackBar("ok", _scaffoldKey, context);
                              setState(() {
                                FirebaseFirestore.instance
                                    .collection("Articles").doc(e.uid)
                                    .delete();
                                showInSnackBar('delete pressed', _scaffoldKey, context);
                              });
                            },
                            child: Container(
                              height: width(context) / 10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Center(
                                child: Text(
                                  'SUPPRIMER',
                                  style: TextStyle(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }
}