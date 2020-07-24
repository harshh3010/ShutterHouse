import 'package:flutter/material.dart';

class NumberLabel extends StatelessWidget {

  final String label,value;
  final Color labelColor,valueColor;
  NumberLabel({@required this.label,@required this.value,@required this.labelColor,@required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            color: valueColor,
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
            color: labelColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}