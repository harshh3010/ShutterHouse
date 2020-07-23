import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class MenuOption extends StatelessWidget {

  final String label;
  final IconData icon;
  MenuOption({@required this.label,@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: kColorRed,
            fontFamily: 'Proxima Nova',
          ),
        ),
        Icon(
          icon,
          color: kColorRed,
        ),
      ],
    );
  }
}