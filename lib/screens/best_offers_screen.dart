import 'package:flutter/material.dart';

class BestOffersScreen extends StatefulWidget {
  static final String id = 'best_offers_screen';
  @override
  _BestOffersScreenState createState() => _BestOffersScreenState();
}

class _BestOffersScreenState extends State<BestOffersScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Offers',
            style: TextStyle(
              fontFamily: 'Proxima Nova',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
