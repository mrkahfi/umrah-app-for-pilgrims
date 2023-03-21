
import 'package:flutter/material.dart';

class LineController extends StatelessWidget {

  final Color colorLine;
  final double width;
  final double height;

  const LineController({Key key, this.colorLine, this.width, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10),
      child: new Container(
        margin: const EdgeInsets.only(top:10),
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: colorLine,
            borderRadius: BorderRadius.all(Radius.circular(3))
        ),
      ),
    );
  }

}