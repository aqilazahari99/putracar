import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:putracar/screen/bookinglist.dart';

class UserBooking extends StatefulWidget {
  @override
  State<UserBooking> createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  var user, useremail;
  getCurrentUser() {
    setState(() {
      user = _auth.currentUser;
      useremail = user.email;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC52F45),
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
              "My Bookings",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Bookings')
                    .where("RecipientEmail", isEqualTo: useremail.toString())
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
                              onTap: () {},
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
                                      (document.data() as Map<String, dynamic>)[
                                              "Price"] +
                                          ' per hour ',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Renting period",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      "Date from :" +
                                          (document.data() as Map<String,
                                              dynamic>)["DateFrom"] +
                                          ' at ' +
                                          (document.data() as Map<String,
                                              dynamic>)["TimeFrom"],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Date until :" +
                                          (document.data() as Map<String,
                                              dynamic>)["DateTo"] +
                                          ' at ' +
                                          (document.data() as Map<String,
                                              dynamic>)["TimeTo"],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Please contact :" +
                                          (document.data() as Map<String,
                                              dynamic>)["OwnerPhone"],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Owner :" +
                                          (document.data() as Map<String,
                                              dynamic>)["OwnerName"],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var collection = FirebaseFirestore
                                            .instance
                                            .collection('Bookings');
                                        await collection
                                            .doc(document.id)
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text('Deleted!'),
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
                                          child: Text('Delete'),
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
