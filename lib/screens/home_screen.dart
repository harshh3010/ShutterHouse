import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/user_api.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  UserApi userApi = UserApi.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
          userApi.name,
        ),
      ),
    );
  }
}
