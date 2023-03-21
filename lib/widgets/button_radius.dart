import 'package:flutter/material.dart';

class ButtonRadius extends StatelessWidget{
  final Color colorBorder;
  final Color backgroundColor;
  final double height;
  final double radius;
  final Icon icon;
  final Text text;
  final VoidCallback callback;

  const ButtonRadius({Key key, this.colorBorder, this.backgroundColor, this.height, this.radius, this.icon, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: new Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(3.0),
          height: height,
          decoration: BoxDecoration(
              border: Border.all(color: colorBorder),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              color: backgroundColor
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (icon == null)? Container() :icon ,
                (icon == null)? Container() :Padding(padding: EdgeInsets.only(right: 10),),
                text
              ],),
          )
      ),
    );
  }

}