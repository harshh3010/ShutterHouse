import 'package:flutter/material.dart';

InputDecoration textInputDecoration(
    {@required Color color, @required String hint,IconData icon}) {
  return InputDecoration(
    hintText: hint,
    contentPadding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(30.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2.0),
      borderRadius: BorderRadius.circular(30.0),
    ),
    prefixIcon: Icon(
      icon,
      color: color,
    ),
  );
}
