import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/listing/hotel.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class ListingInfoHotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ListAppTheme.buildLightTheme(),
      child: Container(child: _buildInfoHotel(context)),
    );
  }

  Widget _buildInfoHotel(BuildContext context) {
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
                        child: _buildListHotels(context)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListHotels(BuildContext context) {
    List<Hotels> hotels = ModalRoute.of(context).settings.arguments;
    return hotels.length > 0
        ? rowHotels(context)
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
                      "Belum ada data hotel",
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
                  "Hotel",
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

  Widget rowHotels(BuildContext context) {
    List<Hotels> hotels = ModalRoute.of(context).settings.arguments;
    List<Widget> list = new List<Widget>();

    // if (hotels.length == 0) {
    //   return
    //   // Container(
    //   //     alignment: AlignmentDirectional(0.0, 0.0),
    //   //     padding: EdgeInsets.only(
    //   //       top: 20.0,
    //   //     ),
    //   //     child: Column(
    //   //       crossAxisAlignment: CrossAxisAlignment.center,
    //   //       mainAxisSize: MainAxisSize.max,
    //   //       mainAxisAlignment: MainAxisAlignment.end,
    //   //       children: <Widget>[
    //   //         new Text("Belum Ada Data Hotel"),
    //   //         Padding(
    //   //           padding: EdgeInsets.only(bottom: 20.0),
    //   //         ),
    //   //       ],
    //   //     ));
    // }

    for (int i = 0; i < hotels.length; i++) {
      list.add(
        _buildCardContentHotel(context, hotels[i]),
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

  Container _buildCardContentHotel(BuildContext context, Hotels hotel) {
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
                    image: new NetworkImage("${hotel.hotel.photo.medium.url}"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, top: 10, right: 10),
                    child: new Container(
                        width: 50,
                        padding: EdgeInsets.all(5),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                bottomLeft: const Radius.circular(20.0),
                                topLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              "${hotel.hotel.star}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22,
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "${hotel.hotel.name}",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          maxLines: 2,
                        ),
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      Text(
                        "${hotel.hotel.city.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 8.0, right: 5.0),
                          child: new Container(
                            padding: EdgeInsets.all(5),
                            decoration: new BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(20.0),
                                    topLeft: const Radius.circular(20.0),
                                    bottomRight: const Radius.circular(20.0),
                                    topRight: const Radius.circular(20.0))),
                            child: InkWell(
                              onTap: () async {
                                if (await MapLauncher.isMapAvailable(
                                    MapType.google)) {
                                  await MapLauncher.showMarker(
                                    mapType: MapType.google,
                                    coords: Coords(
                                        double.parse('${hotel.hotel.lat}'),
                                        double.parse('${hotel.hotel.lon}')),
                                    title: hotel.hotel.name,
                                    description: hotel.hotel.description,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5.0,
                                    top: 1.0,
                                    right: 4.0,
                                    left: 2.0),
                                child: Icon(
                                  FontAwesomeIcons.mapMarkedAlt,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Check - in",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ConvertVar.dateToConvert(
                                  "${hotel.checkinAt}", "dd MMM yyyy"),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Check - out",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ConvertVar.dateToConvert(
                                  "${hotel.checkoutAt}", "dd MMM yyyy"),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            )
          ],
        ));
  }
}
