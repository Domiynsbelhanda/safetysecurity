import 'package:flutter/material.dart';

import '../../globalsVariables.dart';

class UserProfil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserProfil();
  }
}

class _UserProfil extends State<UserProfil>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                entete(context),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: height(context) / 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: width(context) / 3,
                          width: width(context) / 3,
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                            NetworkImage('${currentUsers.image}'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),

                        SizedBox(height: 10.0,),

                        Text(
                          '${currentUsers.name.toUpperCase()}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 15,
                            fontWeight: FontWeight.w700,
                            height: 1.0625,
                            letterSpacing: 2,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          '${currentUsers.email}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 20,
                            height: 1.0625,
                            letterSpacing: 0,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          '${currentUsers.telephone}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 20,
                            height: 1.0625,
                            letterSpacing: 3.0,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        Divider(
                          height: 5.0
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: width(context) / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.0),

                    Expanded(
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black12
                          ),
                        ),
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