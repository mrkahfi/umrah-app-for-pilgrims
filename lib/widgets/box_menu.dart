import 'package:flutter/material.dart';

class BoxMenu extends StatelessWidget {

  final VoidCallback callback;
  final Color colorBox;
  final String menuName;
  final Icon icon;

  const BoxMenu({Key key, this.callback, this.colorBox, this.menuName, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: callback,
      child: new Container(
        margin: const EdgeInsets.only(top:10),
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
          color: colorBox,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(5, 6),
                blurRadius: 5.0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: const Offset(5, 6),
                      blurRadius: 5.0),
                ],
              ),
              child: icon,
            ),
            Padding(padding: EdgeInsets.only(left: 10,bottom: 10),
              child: Text("$menuName",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),)

          ],
        ),
      )
    );
  }
}