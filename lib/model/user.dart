import 'package:geolocator/geolocator.dart';

class User{

  String name;
  String address;
  String phoneNo;
  double latitude;
  double longitude;
  String email;

  User({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phoneNo,
    this.email,
  });

  Map<String,Object> getUserData(){
    return {
      'name' : this.name,
      'address' : this.address,
      'phoneNo' : this.phoneNo,
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'email' : this.email,
    };
  }

}