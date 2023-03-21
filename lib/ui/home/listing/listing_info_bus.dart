import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/listing/bus.dart';
import 'package:flutter/material.dart';

class ListingInfoBusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ListAppTheme.buildLightTheme(),
      child: Container(child: _buildInfoBus(context)),
    );
  }

  Widget _buildInfoBus(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(context),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.88,
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: _buildListBuses(context)
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListBuses(BuildContext context){
    List<Buses> bus = ModalRoute.of(context).settings.arguments;
    return bus.length > 0
        ? rowBus(context)
        : Container(
          padding: EdgeInsets.only(top: 15, left: 5, right: 5),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image.asset(
                "assets/images/blank_file.png",
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                "Belum ada data bus",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )
            ]),
          ));
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: ListAppTheme.buildLightTheme().backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 10),
                  child: Icon(Icons.close),
                ),
              ),
              Expanded(
                child: Text(
                  "Bus",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: AppBar().preferredSize.height + 20,
                height: AppBar().preferredSize.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              )
            ],
          ),
        ));
  }

  Widget rowBus(BuildContext context) {
    List<Widget> list = new List<Widget>();
    List<Buses> bus = ModalRoute.of(context).settings.arguments;

    // if (bus.length == 0) {
    //   return 
      // Container(
      //     alignment: AlignmentDirectional(0.0, 0.0),
      //     padding: EdgeInsets.only(
      //       top: 20.0,
      //     ),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: <Widget>[
      //         new Text("Belum Ada Data Bus"),
      //         Padding(
      //           padding: EdgeInsets.only(bottom: 20.0),
      //         ),
      //       ],
      //     ));
    // }

    for (int i = 0; i < bus.length; i++) {
      list.add(
        _buildCardContentBus(context, bus[i]),
      );
    }

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: list,
        )
      ],
    );
  }

  Container _buildCardContentBus(BuildContext context, Buses bus) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                bottomLeft: const Radius.circular(10.0),
                topLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage("${bus.logo.medium.url}"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${bus.bus}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "${bus.transport}",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            )
          ],
        ));
  }
}
