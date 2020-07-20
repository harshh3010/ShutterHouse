import 'package:flutter/material.dart';
import 'package:shutterhouse/utilities/constants.dart';

class RentsButton extends StatelessWidget {

  final String label;
  final bool isActive;
  final Function onPressed;
  RentsButton({@required this.label,@required this.isActive,@required this.onPressed});

  @override
  Widget build(BuildContext context) {

    BoxDecoration boxDecoration;
    TextStyle textStyle;

    if(isActive){
      boxDecoration = BoxDecoration(
        color: kColorRed,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      );
      textStyle = TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Proxima Nova',
        fontWeight: FontWeight.bold,
      );
    }else{
      boxDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      );
      textStyle = TextStyle(
        color: Colors.grey.shade500,
        fontSize: 20,
        fontFamily: 'Proxima Nova',
        fontWeight: FontWeight.bold,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: boxDecoration,
          child: Center(
            child: Text(
              label,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}