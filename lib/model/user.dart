import 'package:geolocator/geolocator.dart';

class User{

  String name;
  String address;
  String phoneNo;
  double latitude;
  double longitude;
  String email;

  String dpURL;
  double rating;
  int rents;
  int reviews;


  User({this.name, this.address, this.phoneNo, this.latitude,
      this.longitude, this.email, this.dpURL, this.rating, this.rents,
      this.reviews});

  Map<String,Object> getUserData(){
    return {
      'name' : this.name,
      'address' : this.address,
      'phoneNo' : this.phoneNo,
      'latitude' : this.latitude,
      'longitude' : this.longitude,
      'email' : this.email,
      'dpUrl' : this.dpURL,
      'rating' : this.rating,
      'rents' : this.rents,
      'reviews' : this.reviews,
    };
  }

}