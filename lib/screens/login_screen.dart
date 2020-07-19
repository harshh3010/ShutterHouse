import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';


class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  String _email,_password;
  bool e = false,p = false,_loading = false;

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
                                    Navigator.pushNamed(context,HomeScreen.id);
                                  }
                                }catch(e){
                                  switch(e.code){
                                    case 'ERROR_WRONG_PASSWORD' :  showErrorBox(context,'Incorrect password');
                                    break;
                                    case 'ERROR_INVALID_EMAIL' : showErrorBox(context,'Please check the email address you entered.');
                                    break;
                                    case 'ERROR_USER_NOT_FOUND' : showErrorBox(context,'The entered email address is not registered.');
                                    break;
                                    case 'ERROR_USER_DISABLED' : showErrorBox(context,'Your account has been blocked.');
                                    break;
                                    case 'ERROR_TOO_MANY_REQUESTS' : showErrorBox(context,'There were too many login requests from this email, please try again later.');
                                    break;
                                    case 'ERROR_OPERATION_NOT_ALLOWED' : showErrorBox(context,'Your account is currently disabled.');
                                    break;
                                    default : showErrorBox(context,'An error occurred while registering user. Please try again later.');
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
