import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shutterhouse/screens/details_screen.dart';
import 'package:shutterhouse/screens/edit_profile_screen.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/screens/login_screen.dart';
import 'package:shutterhouse/screens/notification_screen.dart';
import 'package:shutterhouse/screens/registration_screen.dart';
import 'package:shutterhouse/screens/rent_screen.dart';
import 'package:shutterhouse/screens/splash_screen.dart';
import 'package:shutterhouse/screens/welcome_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

void main(){
  // Setting status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shutter House',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: kColorRed,
      ),
      // Defining routes for navigating to different screens
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        WelcomeScreen.id : (context) => WelcomeScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        HomeScreen.id : (context) => HomeScreen(),
        DetailsScreen.id : (context) => DetailsScreen(),
        EditProfileScreen.id : (context) => EditProfileScreen(),
        RentScreen.id : (context) => RentScreen(),
        NotificationScreen.id : (context) => NotificationScreen(),
      },
    );
  }
}

