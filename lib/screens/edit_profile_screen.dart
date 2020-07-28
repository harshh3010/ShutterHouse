import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shutterhouse/components/alert_box.dart';
import 'package:shutterhouse/components/menu_option.dart';
import 'package:shutterhouse/components/rounded_button.dart';
import 'package:shutterhouse/components/text_input_decoration.dart';
import 'package:shutterhouse/model/user.dart';
import 'package:shutterhouse/utilities/constants.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

  static final String id = 'edit_profile_screen';
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  bool p = false,n = false,l = false,isEnabled = true,_loading = false;
  final UserApi userApi = UserApi.instance;
  Position position;
  String _address = "",_phoneNo,_name,smsCode,verificationId;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;
  AuthCredential _credential;

  bool imagePicked = false;
  File _image ;
  final picker = ImagePicker();
  String _uploadedFileURL;

  Future chooseFile() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('ProfilePictures/${userApi.email}/profilepic');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  void updateUserData() async {

    User user = User(
      name: _name,
      phoneNo: _phoneNo,
      address: _address,
      email: userApi.email,
      latitude: userApi.latitude,
      longitude: userApi.longitude,
      dpURL:  _uploadedFileURL,
      rents: userApi.rents,
      reviews: userApi.reviews,
      rating: userApi.rating,
    );

    await _firestore.collection('Users').document(user.email).setData(user.getUserData()).then((value){
      UserApi userApi = UserApi.instance;
      userApi.name = user.name;
      userApi.address = user.address;
      userApi.email = user.email;
      userApi.phoneNo = user.phoneNo;
      userApi.latitude = user.latitude;
      userApi.longitude = user.longitude;
      userApi.dpURL = user.dpURL;
      userApi.rents = user.rents;
      userApi.reviews = user.reviews;
      userApi.rating = user.rating;

      Navigator.pop(context);
    }).catchError((error){
      AlertBox.showErrorBox(context, error.message);
    });
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
      AlertBox.showErrorBox(context, 'Please turn on location services');
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

  void verifySuccess(){
    updateUserData();
  }
  void verifyFailed(String msg){
    AlertBox.showErrorBox(context, 'Verification Failed\n$msg');
  }
  Future<void> updatePhoneNumber(){
    _auth.verifyPhoneNumber(
      phoneNumber: '+91' + _phoneNo,
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
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    smsCode = _codeController.text.trim();
                    _credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);

                    await (await FirebaseAuth.instance.currentUser()).updatePhoneNumberCredential(_credential).then((value){
                      Navigator.pop(context);
                      verifySuccess();
                    }).catchError((error){
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

  @override
  Widget build(BuildContext context) {

    _addressController.text = _address =  userApi.address;
    _nameController.text = _name = userApi.name;
    _phoneController.text = _phoneNo = userApi.phoneNo;
    _uploadedFileURL = userApi.dpURL;

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
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 40.0),
                    child: Text(
                      'Edit Profile Information',
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
                  PopupMenuButton(
                    offset: Offset(-100,100),
                    itemBuilder: (BuildContext buildContext) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'item_change_photo',
                        child: MenuOption(
                          label: 'New Photo',
                          icon: Icons.add_photo_alternate,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'item_remove_photo',
                        child: MenuOption(
                          label: 'Remove Photo',
                          icon: Icons.delete,
                        ),
                      ),
                    ],
                    onSelected: (selectedOption){
                      setState(() {
                        imagePicked = true;
                      });
                      switch(selectedOption){
                        case 'item_change_photo':
                          chooseFile();
                          break;
                        case 'item_remove_photo':
                          setState(() {
                            _image = null;
                          });
                          break;
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imagePicked ? (_image == null ? AssetImage('images/avatar.png'):FileImage(_image)) : NetworkImage(userApi.dpURL),
                          fit: BoxFit.cover,
                        ),
                        border: new Border.all(
                          width: 5.0,
                          color: kColorRed,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30.0),
                    child: TextField(
                      controller: _nameController,
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
                      controller: _phoneController,
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
                    child: Container(
                      width: double.infinity,
                      child: RoundedButton(
                        color: kColorRed,
                        onPressed: () async {

                          setState(() {
                            _loading = true;
                          });

                          if(_phoneNo != null && _name != null && _address != ""){

                            if(_image != null){
                              await uploadFile();
                            }else{
                              _uploadedFileURL = kInitialDpUrl;
                            }

                            updatePhoneNumber();
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

                          setState(() {
                            _loading = false;
                          });
                        },
                        text: 'Save changes',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                    child: Container(
                      width: double.infinity,
                      child: RoundedButton(
                        color: kColorRed,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Cancel',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}