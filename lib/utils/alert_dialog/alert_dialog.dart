import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlert {
  static showDialog(BuildContext context, String title, String desc, 
  String titleButtonPositive, String titleButtonNegative, VoidCallback callbackButtonPositive, VoidCallback callbackButtonNegative) {
    Alert(
        context: context,
        type: AlertType.info,
        title: title,
        desc: desc,
        buttons: [
          DialogButton(
            child: Text(
              titleButtonPositive,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: callbackButtonPositive,
            color: Colors.green,
          ),
          DialogButton(
            child: Text(
              titleButtonNegative,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: callbackButtonNegative,
            color: Colors.grey,
          ),
        ]).show();
  }
}
