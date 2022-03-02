import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:putracar/screen/user/user_bottom_bar.dart';
import 'package:putracar/screen/user/user_homepage.dart';
import 'package:putracar/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance.collection('Users');

  Future getUsersType(String uid) async {
    int _userType;
    DocumentSnapshot variable1 = await usersRef.doc(uid).get();
    _userType = await variable1['userType'];
    print(variable1['userType']);
    return _userType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC52F45),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              height: 40.0,
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
              height: 8.0,
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
            InkWell(
              onTap: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  String uid = _auth.currentUser.uid.toString();
                  print(uid);
                  print(email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Login Success'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return BottomBarUser();
                      /*if (type == 0) {
                        return BottomBarUser();
                      } else {
                        return AdminHomeBody();
                      }*/
                    }),
                  );
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                          'Login Failed. Invalid Email or Password!'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              /*onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeBody();
                }));
              },*/
              child: Container(
                height: 42.0,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Center(
                  child: Text(
                    'Login',
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
