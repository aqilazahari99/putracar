import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:putracar/model/car_models.dart';
import 'package:putracar/screen/user/details_screen.dart';
import 'package:putracar/screen/user/user_add_car.dart';
import 'package:putracar/screen/welcome_screen.dart';

class UserHomeBody extends StatefulWidget {
  @override
  _UserHomeBodyState createState() => _UserHomeBodyState();
}

class _UserHomeBodyState extends State<UserHomeBody> {
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
        height: double.infinity,
        width: double.infinity,
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
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: _firestore.collection('Cars').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        int i = 1;
                        String listCar = "No";
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Text("Loading..");
                          default:
                            return ListView(
                              children: snapshot.data.docs.map((document) {
                                if (i == snapshot.data.size) {
                                  listCar = "Yes";
                                }
                                i++;
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                      right: 10,
                                      bottom: listCar == "Yes" ? 100 : 10),
                                  child: InkWell(
                                    onTap: () {
                                      if ((document.data() as Map<String,
                                              dynamic>)["Owner"] ==
                                          useremail.toString()) {
                                        //owner sama
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                            return DetailScreen(
                                              (document.data() as Map<String,
                                                  dynamic>)["Title"],
                                              (document.data() as Map<String,
                                                  dynamic>)["Price"],
                                              (document.data() as Map<String,
                                                  dynamic>)["Owner"],
                                              (document.data() as Map<String,
                                                  dynamic>)["Imageurl"],
                                              (document.data() as Map<String,
                                                  dynamic>)["Location"],
                                              document.id,
                                              (document.data() as Map<String,
                                                  dynamic>)["OwnerPhone"],
                                              (document.data() as Map<String,
                                                  dynamic>)["OwnerName"],
                                            );
                                          }),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (document.data() as Map<String,
                                                      dynamic>)["Imageurl"] !=
                                                  null
                                              ? Image(
                                                  image: NetworkImage(
                                                    (document.data() as Map<
                                                        String,
                                                        dynamic>)["Imageurl"],
                                                  ),
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container(),
                                          Text(
                                            (document.data() as Map<String,
                                                dynamic>)["Title"],
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
                                          Text(
                                            'Transmission: ' +
                                                (document.data() as Map<String,
                                                    dynamic>)["Transmission"],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Owner: ' +
                                                (document.data() as Map<String,
                                                    dynamic>)["OwnerName"],
                                            style: TextStyle(
                                              fontSize: 16,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return UserAddCar();
                              }),
                            );
                            print('ADD');
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'Add Car',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      /* bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),*/
    );
  }
}
