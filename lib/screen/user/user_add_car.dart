import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserAddCar extends StatefulWidget {
  @override
  _UserAddCarState createState() => _UserAddCarState();
}

class _UserAddCarState extends State<UserAddCar> {
  String title, location, price, imageurl;
  String carRegister, brand, transType, fuel;

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final picker = ImagePicker();

  File image;

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;
  var user, useremail, userphone, userDName;
  getCurrentUser() {
    setState(() {
      user = _auth.currentUser;
      useremail = user.email;
    });
    _firestore
        .collection('Users')
        .where('email', isEqualTo: useremail.toString())
        .snapshots()
        .listen((data) {
      setState(() {
        userphone = data.docs[0].data()["phoneNum"];
        userDName = data.docs[0].data()["name"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC52F45),
      appBar: AppBar(
        backgroundColor: Color(0xFFC52F45),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: image == null
                    ? InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 30,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "tap here",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ClipRRect(
                            // Image border
                            child: SizedBox.fromSize(
                              // Image radius
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 100,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Model',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      brand = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Brand',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      carRegister = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Registration Number',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      transType = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Transmission type',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      location = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Location',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Rental rate per hour',
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (image != null &&
                        title != null &&
                        location != null &&
                        price != null &&
                        transType != null &&
                        carRegister != null) {
                      String ntime = DateFormat('kk:mm:ss')
                          .format(DateTime.now().add(Duration(hours: 8)));
                      final p = _storage.ref().child(
                          "CarImages/" + useremail.toString() + "/" + ntime);
                      final pp = p.putFile(image);
                      final ppp = await pp;
                      String url = await ppp.ref.getDownloadURL();
                      setState(() {
                        imageurl = url;
                      });

                      await _firestore.collection('Cars').add({
                        'Imageurl': imageurl,
                        'Title': title,
                        'Registration Num': carRegister,
                        'Transmission': transType,
                        'Location': location,
                        'Price': price,
                        'Owner': useremail.toString(),
                        'OwnerPhone': userphone,
                        'OwnerName': userDName,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Car added!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      print("null detected");
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
