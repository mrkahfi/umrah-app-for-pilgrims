import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LinearPercentWidget extends StatelessWidget {
  const LinearPercentWidget({
    Key key,
    this.textTitle,
    this.textPercent,
    this.callback,
    this.percent
  });

  final String textTitle;
  final VoidCallback callback;
  final double percent;
  final String textPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          padding: EdgeInsets.all(15),
          decoration: new BoxDecoration(
              color: const Color(0xFFffffff),
              border: new Border.all(width: 1.0, color: Colors.black26),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 15, left: 5),
                  child: Row(
                    children: <Widget>[
                      Text(textTitle),
                      Expanded(
                          child: GestureDetector(
                        onTap: callback,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Edit",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      )),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.75,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2500,
                  percent: percent,
                  center: Text(
                    textPercent,
                    style: TextStyle(color: Colors.white),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Colors.blueAccent,
                ),
              ),
            ],
          ));
  }
}
