import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/screens/details_screen.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';


class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  String _email,_password;
  bool e = false,p = false,_loading = false;
  UserApi userApi = UserApi.instance;

  AlertBox alertBox = AlertBox();

  void checkUserData() async{

    setState(() {
      _loading = true;
    });

    final snapShot = await Firestore.instance
        .collection('Users')
        .document(_email)
        .get();

    if (snapShot == null || !snapShot.exists) {
      Navigator.pushReplacementNamed(context, DetailsScreen.id);
    }else{
      userApi.name = snapShot.data['name'];
      userApi.address = snapShot.data['address'];
      userApi.email = snapShot.data['email'];
      userApi.phoneNo = snapShot.data['phoneNo'];
      userApi.latitude = snapShot.data['latitude'];
      userApi.longitude = snapShot.data['longitude'];
      userApi.dpURL = snapShot.data['dpUrl'];
      userApi.rents = snapShot.data['rents'];
      userApi.reviews = snapShot.data['reviews'];
      userApi.rating = snapShot.data['rating'];
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: .5,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(kColorRed),
        ),
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClippedHeader(
                  color: kColorRed,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 40.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                              color: kColorRed,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _email = value;
                              setState(() {
                                e = false;
                              });
                            },
                            decoration: textInputDecoration(color: kColorRed, hint: 'Enter email address',icon : Icons.mail,showError: e),
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
                          child: TextField(
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                              setState(() {
                                p = false;
                              });
                            },
                            decoration: textInputDecoration(color: kColorRed, hint: 'Enter your password',icon : Icons.vpn_key,showError: p),
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
                          child: RoundedButton(
                            color: kColorRed,
                            text: 'Login',
                            onPressed: () async {
                              if(_email != null && _password != null){
                                setState(() {
                                  _loading = true;
                                });
                                try{
                                  final user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                                  if(user != null){
                                    checkUserData();
                                  }
                                }catch(e){
                                  switch(e.code){
                                    case 'ERROR_WRONG_PASSWORD' :  alertBox.showErrorBox(context,'Incorrect password');
                                    break;
                                    case 'ERROR_INVALID_EMAIL' : alertBox.showErrorBox(context,'Please check the email address you entered.');
                                    break;
                                    case 'ERROR_USER_NOT_FOUND' : alertBox.showErrorBox(context,'The entered email address is not registered.');
                                    break;
                                    case 'ERROR_USER_DISABLED' : alertBox.showErrorBox(context,'Your account has been blocked.');
                                    break;
                                    case 'ERROR_TOO_MANY_REQUESTS' : alertBox.showErrorBox(context,'There were too many login requests from this email, please try again later.');
                                    break;
                                    case 'ERROR_OPERATION_NOT_ALLOWED' : alertBox.showErrorBox(context,'Your account is currently disabled.');
                                    break;
                                    default : alertBox.showErrorBox(context,'An error occurred while registering user. Please try again later.');
                                  }
                                }
                                setState(() {
                                  _loading = false;
                                });
                              }else{
                                if(_email == null)
                                  setState(() {
                                    e = true;
                                  });
                                if(_password == null)
                                  setState(() {
                                    p = true;
                                  });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
