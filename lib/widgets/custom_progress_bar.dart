import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ),
        decoration: BoxDecoration(color: Color.fromARGB(100, 105, 105, 105)),
      ),
    );
  }
}
