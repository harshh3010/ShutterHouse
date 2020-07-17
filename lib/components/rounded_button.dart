import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final String text;
  RoundedButton({
    @required this.color,
    @required this.onPressed,
    @required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: FlatButton(
        child: Text(
            text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Proxima Nova',
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
