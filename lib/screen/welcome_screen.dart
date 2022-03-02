import 'package:flutter/material.dart';
import 'package:putracar/screen/login_screen.dart';
import 'package:putracar/screen/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xFFC52F45),
      child: SafeArea(
        child: Padding(
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text('Log In'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegistrationScreen();
                      }));
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text('Register'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
