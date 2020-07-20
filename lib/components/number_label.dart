import 'package:flutter/material.dart';

class NumberLabel extends StatelessWidget {

  final String label,value;
  NumberLabel({@required this.label,@required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'Proxima Nova',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Proxima Nova',
            color: Colors.blueGrey.shade400,
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}