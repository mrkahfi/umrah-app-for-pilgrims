import 'package:flutter/material.dart';

class FlexibleCardWidget extends StatelessWidget {
  const FlexibleCardWidget({Key key, this.callback, this.column, this.isCard})
      : super(key: key);

  final VoidCallback callback;
  final Column column;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: new GestureDetector(
          onTap: callback,
          child: new Container(
            height: 107.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Container(
                decoration: isCard ? new BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFf1f1f1),
                        offset: Offset(6.0, 9.0),
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.white,
                    border: new Border.all(
                        width: 1.0, color: const Color(0xFFf1f1f1)),
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(10.0),
                        topLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))) : BoxDecoration(),
                child: new Center(
                  child: column
                )),
          ),
        ));
  }
}
