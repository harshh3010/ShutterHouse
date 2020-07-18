import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';

class DetailsScreen extends StatefulWidget {
  static final String id = 'details_screen';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  TextEditingController _codeController = TextEditingController();
  String smsCode;
  String verificationId;
  String _phoneNo;
  bool _loading = false;
  AuthCredential _credential;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final user = await _auth.currentUser();
      if(user != null){
        _currentUser = user;
      }
    }catch(e){
      print(e);
    }
  }

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

  void verifySuccess(){
    Navigator.pushNamed(context,HomeScreen.id);
  }

  void verifyFailed(){
    showErrorBox(context, 'Verification Failed');
  }

  Future registerUser(String mobile, BuildContext context) async{
    _auth.verifyPhoneNumber(
        phoneNumber: '+91' + mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential){
          verifySuccess();
        },
        verificationFailed: (AuthException authException){
          verifyFailed();
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter OTP"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('We have sent you an OTP(expires in 2 minutes) on entered phone number, please verify to continue.'),
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Done"),
                    textColor: Colors.white,
                    color: kColorRed,
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      smsCode = _codeController.text.trim();

                      _credential = null;
                      _credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);

                      _currentUser.linkWithCredential(_credential).then((user) {
                        verifySuccess();
                      }).catchError((error) {
                        print(error.toString());
                        verifyFailed();
                      });
                    },
                  )
                ],
              )
          );
        },
        codeAutoRetrievalTimeout: (String verificationId){
          this.verificationId = verificationId;
          print(verificationId);
          print("Timeout");
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ModalProgressHUD(
        inAsyncCall: _loading,
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
                    _phoneNo = value;
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
                    registerUser(_phoneNo, context);
                  },
                  text: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
