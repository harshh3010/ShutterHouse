import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shutterhouse/utilities/constants.dart';

class AlertBox {

  void showErrorBox(context,String error){
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: error,
      buttons: [
        DialogButton(
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: kColorRed,
          width: 120,
        )
      ],
    ).show();
  }
}