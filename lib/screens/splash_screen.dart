import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/screens/welcome_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

import 'details_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {

  static final String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;
  UserApi userApi = UserApi.instance;

  void checkUserData() async{

    final snapShot = await Firestore.instance
        .collection('Users')
        .document(_currentUser.email)
        .get();

    if (snapShot == null || !snapShot.exists) {
      Navigator.pushNamed(context, DetailsScreen.id);
    }else{
      userApi.name = snapShot.data['name'];
      userApi.address = snapShot.data['address'];
      userApi.email = snapShot.data['email'];
      userApi.phoneNo = snapShot.data['phoneNo'];
      userApi.latitude = snapShot.data['latitude'];
      userApi.longitude = snapShot.data['longitude'];
      userApi.dpURL = snapShot.data['dpURL'];
      userApi.rents = snapShot.data['rents'];
      userApi.reviews = snapShot.data['reviews'];
      userApi.rating = snapShot.data['rating'];
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null){
        _currentUser = user;

        checkUserData();
      }else{
        Navigator.pushReplacementNamed(context,WelcomeScreen.id);
      }
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: true,
      color: Colors.white,
      opacity: 0,
      progressIndicator: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
      ),
      child: Material(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Shutter House',
                  style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontSize: 30,
                    color: kColorRed,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
