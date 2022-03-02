import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  String ImageUrl, email, phone, name;
  var user, useremail, userid;
  getUser() {
    user = _auth.currentUser;
    useremail = user.email;
    _firestore
        .collection('Users')
        .where('email', isEqualTo: useremail)
        .snapshots()
        .listen((data) {
      setState(() {
        userid = data.docs[0].id;
        ImageUrl = data.docs[0].data()['image'];
        email = data.docs[0].data()['email'];
        phone = data.docs[0].data()['phoneNum'];
        name = data.docs[0].data()['name'];
      });
    });
  }

  String imageUrl;
  File image;
  String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFC52F45),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
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
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "My Profile",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageUrl == null
                    ? Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: Color(0XFFBA2E43),
                        ),
                      )
                    : Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: Color(0XFFBA2E43),
                            image: DecorationImage(
                                image: NetworkImage(
                                  ImageUrl,
                                ),
                                fit: BoxFit.cover)),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: "NAME: ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: name != null ? name : "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: "E-MAIL: ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: email != null ? email : "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: "PHONE NUMBER: ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    TextSpan(
                      text: phone != null ? phone : "",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
