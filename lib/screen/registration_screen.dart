import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:putracar/services/services.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  String name;
  String phoneNum;
  int _groupValue = 0;
  final _auth = FirebaseAuth.instance;
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  String imageUrl;
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

  /*Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      activeColor: Colors.black,
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC52F45),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Image.asset('assets/images/icons8-car-64.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'PutraCar',
                    style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              height: 75,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: image == null
                          ? Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Add photo',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: FileImage(
                                        image,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your full name',
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
            SizedBox(
              height: 24.0,
            ),
            TextField(
              onChanged: (value) {
                phoneNum = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
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
            SizedBox(
              height: 24.0,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
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
            SizedBox(
              height: 24.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
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
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 24.0,
            ),
            /*_myRadioButton(
              title: 'User',
              value: 0,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: 'Admin',
              value: 1,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),*/
            InkWell(
              onTap: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null &&
                      email != null &&
                      name != null &&
                      phoneNum != null &&
                      password != null) {
                    String ntime =
                        DateFormat('kk:mm:ss').format(DateTime.now());
                    final p = _storage
                        .ref()
                        .child("ProfileImages/" + email + "/" + ntime);
                    final pp = p.putFile(image);
                    final ppp = await pp;
                    String url = await ppp.ref.getDownloadURL();
                    setState(() {
                      imageUrl = url;
                    });

                    await FirebaseFirestore.instance.collection('Users').add({
                      'email': email,
                      'name': name,
                      'phoneNum': phoneNum,
                      'image': imageUrl,
                    });
                    print('Success');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Register Success'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Register Failed! Please check all details!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: Container(
                height: 42.0,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 42.0,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
