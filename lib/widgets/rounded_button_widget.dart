import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(side: BorderSide(
            color: Colors.blue,
            width: 1,
            style: BorderStyle.solid
          ), borderRadius: BorderRadius.circular(50)),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button.copyWith(color: textColor),
      ),
    );
  }
}
