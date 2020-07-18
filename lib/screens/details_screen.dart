import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/utilities/constants.dart';

class DetailsScreen extends StatefulWidget {
  static final String id = 'details_screen';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
                                                                                                                                                                                                                                                                                                                                                                                                                 mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 40.0),
              child: Text(
                  'Tell us about you',
                style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontSize: 24,
                  color: kColorRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
              child: TextField(
                onChanged: (value){
                  // TODO : code
                },
                decoration: textInputDecoration(color: kColorRed, hint: 'Enter full name', showError: false,icon: Icons.person),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  // TODO : code
                },
                decoration: textInputDecoration(color: kColorRed, hint: 'Enter contact number', showError: false,icon: Icons.phone),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
              child: TextField(
                onChanged: (value){
                  // TODO : code
                },
                decoration: textInputDecoration(color: kColorRed, hint: 'Enter address', showError: false,icon: Icons.location_on),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: RoundedButton(
                color: kColorRed,
                onPressed: (){
                  // TODO: code
                },
                text: 'Continue',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
