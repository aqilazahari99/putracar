import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:putracar/screen/home_screen.dart';
import 'file:///C:/Users/ADMIN/AndroidStudioProjects/flutter-car-rental/lib/screens/home_screen/login_screen.dart';
import 'file:///C:/Users/ADMIN/AndroidStudioProjects/flutter-car-rental/lib/screens/home_screen/registration_screen.dart';
import 'file:///C:/Users/ADMIN/AndroidStudioProjects/flutter-car-rental/lib/screens/home_screen/welcome_screen.dart';
import 'package:putracar/screen/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PutraCar());
}

class PutraCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}
