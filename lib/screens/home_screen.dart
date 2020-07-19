import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();

  final String name,address,phoneNo;
  HomeScreen({this.name,this.address,this.phoneNo});

}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Text(
          '${widget.address} ${widget.name} ${widget.phoneNo}',
        ),
      ),
    );
  }
}
