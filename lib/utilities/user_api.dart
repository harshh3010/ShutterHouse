// This class will be used to store all the user data, which will be available globally within the app

class UserApi {

  UserApi._privateConstructor();

  static final UserApi _instance = UserApi._privateConstructor();
  static UserApi get instance => _instance;

  String _name;
  String _address;
  String _phoneNo;
  double _latitude;
  double _longitude;
  String _email;
  String _dpURL;
  double _rating;
  int _rents;
  int _reviews;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get address => _address;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  String get phoneNo => _phoneNo;

  set phoneNo(String value) {
    _phoneNo = value;
  }

  set address(String value) {
    _address = value;
  }

  int get reviews => _reviews;

  set reviews(int value) {
    _reviews = value;
  }

  int get rents => _rents;

  set rents(int value) {
    _rents = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  String get dpURL => _dpURL;

  set dpURL(String value) {
    _dpURL = value;
  }


}