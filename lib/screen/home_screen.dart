import 'package:flutter/material.dart';
import 'package:putracar/screen/user/user_homepage.dart';
import 'package:putracar/screen/login_screen.dart';
import 'package:putracar/screen/registration_screen.dart';
import 'package:putracar/screen/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeScreen(),
    );
  }
}
