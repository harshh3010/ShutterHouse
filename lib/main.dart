import 'package:flutter/material.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/screens/login_screen.dart';
import 'package:shutterhouse/screens/registration_screen.dart';
import 'package:shutterhouse/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
       RegistrationScreen.id : (context) => RegistrationScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        HomeScreen.id : (context) => HomeScreen(),
      },
    );
  }
}

