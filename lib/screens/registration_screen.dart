import 'package:flutter/material.dart';
import 'package:shutterhouse/components/clipped_header.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/utilities/constants.dart';

class RegistrationScreen extends StatelessWidget {
  static final String id = 'registration_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
                            // TODO: code
                          },
                          decoration: textInputDecoration(color: kColorBlue, hint: 'Enter email address',icon : Icons.person),
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
                            // TODO: code
                          },
                          decoration: textInputDecoration(color: kColorBlue, hint: 'Create a password',icon : Icons.vpn_key),
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
                            // TODO: code
                          },
                          decoration: textInputDecoration(color: kColorBlue, hint: 'Confirm password',icon : Icons.vpn_key),
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
                          onPressed: (){
                            // Todo : code
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
    );
  }
}
