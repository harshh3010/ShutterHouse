
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/utilities/constants.dart';

import 'details_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String _email,_password,_cnfpassword;
  bool e = false,p = false,cp = false,_loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(kColorBlue),
        ),
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClippedHeader(
                  color: kColorBlue,
                  text: 'Shutter House',
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
                            'Register',
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900,
                              color: kColorBlue,
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
                            decoration: textInputDecoration(color: kColorBlue, hint: 'Enter email address',icon : Icons.mail,showError: e),
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
                            decoration: textInputDecoration(color: kColorBlue, hint: 'Create a password',icon : Icons.vpn_key,showError: p),
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
                              setState(() {
                                cp = false;
                              });
                              _cnfpassword = value;
                            },
                            decoration: textInputDecoration(color: kColorBlue, hint: 'Confirm password',icon : Icons.vpn_key,showError: cp),
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
                            color: kColorBlue,
                            text: 'Register',
                            onPressed: () async {
                              if(_email != null && _password != null && _cnfpassword == _password){
                                setState(() {
                                  _loading = true;
                                });
                                try{
                                  final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                                  if(newUser != null){
                                    Navigator.pushReplacementNamed(context, DetailsScreen.id);
                                  }
                                }catch(e){
                                  switch(e.code){
                                    case 'ERROR_WEAK_PASSWORD' :  AlertBox.showErrorBox(context,'Your password must be at least 6 characters long.');
                                    break;
                                    case 'ERROR_INVALID_EMAIL' : AlertBox.showErrorBox(context,'Please check the email address you entered.');
                                    break;
                                    case 'ERROR_EMAIL_ALREADY_IN_USE' : AlertBox.showErrorBox(context,'The email address you entered is already in use.');
                                    break;
                                    default : AlertBox.showErrorBox(context,'An error occurred while registering user. Please try again later.');
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
                                if(_cnfpassword == null)
                                  setState(() {
                                    cp = true;
                                  });
                                if(_cnfpassword != null && _cnfpassword != _password)
                                  AlertBox.showErrorBox(context,'The confirmation password did not match with chosen password');
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

