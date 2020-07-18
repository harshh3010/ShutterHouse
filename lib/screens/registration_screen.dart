
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email,password,cnfpassword;
  bool e = false,p = false,cp = false,_loading = false;

  void showErrorBox(context,String error){
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: error,
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: kColorRed,
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
        color: kColorBlue,
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
                              email = value;
                              setState(() {
                                e = false;
                              });
                            },
                            decoration: textInputDecoration(color: kColorBlue, hint: 'Enter email address',icon : Icons.person,showError: e),
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
                              password = value;
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
                              cnfpassword = value;
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
                              if(email != null && password != null && cnfpassword == password){
                                setState(() {
                                  _loading = true;
                                });
                                try{
                                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                                  if(newUser != null){
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                }catch(e){
                                  switch(e.code){
                                    case 'ERROR_WEAK_PASSWORD' :  showErrorBox(context,'Your password must be at least 6 characters long.');
                                    break;
                                    case 'ERROR_INVALID_EMAIL' : showErrorBox(context,'Please check the email address you entered.');
                                    break;
                                    case 'ERROR_EMAIL_ALREADY_IN_USE' : showErrorBox(context,'The email address you entered is already in use.');
                                    break;
                                    default : showErrorBox(context,'An error occurred while registering user. Please try again later.');
                                  }
                                }
                                setState(() {
                                  _loading = false;
                                });
                              }else{
                                if(email == null)
                                  setState(() {
                                    e = true;
                                  });
                                if(password == null)
                                 setState(() {
                                   p = true;
                                 });
                                if(cnfpassword == null)
                                  setState(() {
                                    cp = true;
                                  });
                                if(cnfpassword != null && cnfpassword != password)
                                  showErrorBox(context,'The confirmation password did not match with chosen password');
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

