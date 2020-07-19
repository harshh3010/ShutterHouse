import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/model/user.dart';
import 'package:shutterhouse/screens/home_screen.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class DetailsScreen extends StatefulWidget {
  static final String id = 'details_screen';
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  FirebaseUser _currentUser;
  AuthCredential _credential;

  TextEditingController _codeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String _phoneNo,_name,smsCode,verificationId,_address = "";
  bool p = false,n = false,l = false,isEnabled = true,_loading = false;
  Position position;

  void addUserData() async {
    setState(() {
      _loading = true;
    });

    User user = User(
      name: _name,
      phoneNo: _phoneNo,
      address: _address,
      email: _currentUser.email,
      latitude: position.latitude,
      longitude: position.longitude,
    );

    await _firestore.collection('Users').document(user.email).setData(user.getUserData()).then((value){
      UserApi userApi = UserApi.instance;
      userApi.name = user.name;
      userApi.address = user.address;
      userApi.email = user.email;
      userApi.phoneNo = user.phoneNo;
      userApi.latitude = user.latitude;
      userApi.longitude = user.longitude;

      Navigator.pushNamed(context, HomeScreen.id);
    }).catchError((error){
      AlertBox().showErrorBox(context, error.message);
    });

    setState(() {
      _loading = false;
    });
  }

  void verifySuccess(){
    addUserData();
  }
  void verifyFailed(String msg){
    AlertBox().showErrorBox(context, 'Verification Failed\n$msg');
  }
  Future registerUser(String mobile, BuildContext context) async{
    _auth.verifyPhoneNumber(
        phoneNumber: '+91' + mobile,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential authCredential){
          verifySuccess();
        },
        verificationFailed: (AuthException authException){
          verifyFailed(authException.message);
          print(authException.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
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
                      setState(() {
                        _loading = true;
                      });
                      smsCode = _codeController.text.trim();

                      _credential = null;
                      _credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);

                      _currentUser.linkWithCredential(_credential).then((user) {
                        Navigator.pop(context);
                        verifySuccess();
                      }).catchError((error) {
                        print(error.toString());
                        verifyFailed(error.message);
                      });

                      setState(() {
                        _loading = false;
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

  void getCurrentLocation() async {
    setState(() {
      _loading = true;
    });

    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if(isLocationEnabled){
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);

      getPlace(position);

    }else{
      AlertBox().showErrorBox(context, 'Please turn on location services');
    }

    setState(() {
      _loading = false;
    });
  }
  void getPlace(Position position) async {
    List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    print(address);

    setState(() {
      _address = address;
      _addressController.text = address;
      isEnabled = false;
    });
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
  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
                    _name = value;
                  },
                  decoration: textInputDecoration(color: kColorRed, hint: 'Enter full name', showError: n,icon: Icons.person),
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
                  decoration: textInputDecoration(color: kColorRed, hint: 'Enter contact number', showError: p,icon: Icons.phone),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
                child: TextField(
                  enabled: isEnabled,
                  onTap: (){
                    getCurrentLocation();
                  },
                  controller: _addressController,
                  decoration: textInputDecoration(color: kColorRed, hint: 'Enter address', showError: l,icon: Icons.location_on),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RoundedButton(
                  color: kColorRed,
                  onPressed: (){
                    if(_phoneNo != null && _name != null && _address != ""){
                      registerUser(_phoneNo, context);
                    }else{
                      if(_phoneNo == null)
                        setState(() {
                          p = true;
                        });
                      if(_name == null)
                        setState(() {
                          n = true;
                        });
                      if(_address == "")
                        setState(() {
                          l = true;
                        });
                    }
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
