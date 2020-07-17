import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/utilities/constants.dart';

class WelcomeScreen extends StatelessWidget {
  static final String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), BlendMode.srcATop),
              image: AssetImage(
                'images/welcomebg.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                        color: kColorBlue,
                      ),
                    ),
                    Text(
                      'Shutter House',
                      style: TextStyle(
                        fontFamily: 'Proxima Nova',
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                        color: kColorRed,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RoundedButton(
                      color: kColorRed,
                      text: 'Login',
                      onPressed: (){
                        // TODO: code
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      color: kColorBlue,
                      text: 'Register',
                      onPressed: (){
                        // TODO: code
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
