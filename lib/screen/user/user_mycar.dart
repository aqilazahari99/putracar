import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bookinglist.dart';

class UserMycar extends StatefulWidget {
  @override
  State<UserMycar> createState() => _UserMycarState();
}

class _UserMycarState extends State<UserMycar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  var user, useremail;
  getCurrentUser() {
    setState(() {
      user = _auth.currentUser;
      useremail = user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFC52F45),
        child: SafeArea(
            child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PutraCar',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2.5,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await _auth.signOut();
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    },
                    child: Container(
                      child: Icon(
                        Icons.logout,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "My Car",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Cars')
                    .where("Owner", isEqualTo: useremail)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("Loading..");
                    default:
                      return ListView(
                        children: snapshot.data.docs.map((document) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BookingList(document.id);
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                margin: EdgeInsets.only(left: 5, right: 5),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (document.data() as Map<String, dynamic>)[
                                                "Imageurl"] !=
                                            null
                                        ? Image(
                                            image: NetworkImage(
                                              (document.data() as Map<String,
                                                  dynamic>)["Imageurl"],
                                            ),
                                            height: 150,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(),
                                    Text(
                                      (document.data()
                                          as Map<String, dynamic>)["Title"],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Price: ' +
                                          (document.data() as Map<String,
                                              dynamic>)["Price"] +
                                          ' per hour ',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Location: ' +
                                          (document.data() as Map<String,
                                              dynamic>)["Location"],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var collection = FirebaseFirestore
                                            .instance
                                            .collection('Cars');
                                        await collection
                                            .doc(document.id)
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text('Car removed!'),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text('Remove Car'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
