import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Model/Articles.dart';
import 'package:safetysecurity/Model/Commentaires.dart';
import 'package:safetysecurity/Model/Users.dart';
import 'package:safetysecurity/globalsVariables.dart';

import '../ActivityPrincipale.dart';

class ItemDetails extends StatefulWidget{

  bool comment;
  Articles item;

  ItemDetails({this.comment, this.item});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemDetails();
  }
}

class _ItemDetails extends State<ItemDetails>{

  bool comment;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myCommentFocus = FocusNode();

  TextEditingController myCommentController = new TextEditingController();

  List<Commentaires> commentaires;


  @override
  void initState() {
    comment = widget.comment;
    commentaires = [];
    Query collectionReference = FirebaseFirestore.instance
        .collection("Articles").doc(widget.item.uid)
        .collection('comment')
        .orderBy('timestamp', descending: true);


    collectionReference
        .snapshots()
        .listen((data) { data.docs.forEach((doc) {

      setState(() {
        commentaires.add(
            new Commentaires(
              id: doc.get('id'),
              description: doc.get("description"),
              timestamp: doc.get('timestamp'),
            )
        );
      });
    });
        }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
      floatingActionButton: comment ? Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: width(context) / 1.5,
              height: width(context) / 12.5,
              child: TextField(
                focusNode: myCommentFocus,
                controller: myCommentController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: width(context) / 25,
                  color: Colors.black
                ),
                decoration: InputDecoration(
                    labelText: "Votre commentaire |",
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(
                          color: const Color(0xff444d5e),
                        )
                    )
                ),
              ),
            ),

            IconButton(
                icon: Icon(
                  FontAwesomeIcons.paperPlane,
                  size: width(context) / 12.5,
                ),
                onPressed: () async{

                  if(myCommentController.text.isEmpty){
                    showInSnackBar("Votre commentaire", _scaffoldKey, context);
                    setState(() {
                      comment = !comment;
                    });
                    return;
                  }

                  var data = {
                    'description': myCommentController.text,
                    'timestamp': FieldValue.serverTimestamp(),
                    'id': currentFirebaseUser.uid,
                  };

                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await
                  _firestore.collection('Articles')
                      .doc(widget.item.uid)
                      .collection('comment').add(data);
                  FirebaseFirestore.instance.collection('Articles').doc(widget.item.uid)
                      .update({"comment": FieldValue.increment(1)});
                  showInSnackBar("commentaire effectuée.", _scaffoldKey, context);

                  setState(() {
                    comment = !comment;
                    myCommentController.clear();
                  });
                })
          ],
        ),
      ) : SizedBox(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backButton(context),

                  SizedBox(width: 15.0),

                  Text(
                    'SAFETY SECURITY',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: width(context) / 15,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    utilisateurs(context, widget.item.id, widget.item),

                    SizedBox(height: 5.0),

                    Container(
                      height: width(context) / 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width(context) / 25),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: NetworkImage(
                                '${widget.item.image}'
                            ),
                          )
                      ),
                    ),

                    SizedBox(height: 5.0),

                    Text(
                      '${widget.item.titre}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: width(context) / 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),

                    SizedBox(height: 3.0),

                    Text(
                      '${widget.item.description}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: width(context) / 25,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    comment ? SizedBox() :
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
                                FirebaseFirestore.instance.collection('Articles').doc(widget.item.uid)
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
                                          '   Like ${widget.item.like}'
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
                                setState(() {
                                  comment = !comment;
                                });
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
                                          '   Comment ${widget.item.comment}'
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 10.0),

                    Divider(
                      height: 10.0
                    ),

                    SizedBox(height: 10.0),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Commentaires :"),
                    ),

                    SizedBox(height: 10.0),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: commentaires.length == 0 ?
                          Text("Aucun commentaires") :
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: commentaires.map((e){
                          List<Users> utilisateurs = users
                              .where(
                                  (doc) => doc.id.toLowerCase()
                                  .contains(e.id.toLowerCase()))
                              .toList();
                          return Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: width(context) / 10,
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
                                        fontSize: width(context) / 25,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),

                                    Container(
                                      width: width(context) / 2,
                                      child: Text(
                                        '${e.description}',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: width(context) / 30,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: width(context) / 3)
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}