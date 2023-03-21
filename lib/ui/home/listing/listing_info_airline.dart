import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/listing/flight.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/ticket_clipper.dart';
import 'package:flutter/material.dart';

class ListingInfoAirlinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ListAppTheme.buildLightTheme(),
      child: Container(child: _buildInfoAirline(context)),
    );
  }

  Widget _buildInfoAirline(BuildContext context) {
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
                      padding: EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: _buildListAirlines(context)
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

  Widget _buildListAirlines(BuildContext context) {
    final List<Flights> flight = ModalRoute.of(context).settings.arguments;
    return flight.length > 0
        ? rowFlights(context)
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
                "Belum ada data penerbangan",
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
                  "Penerbangan",
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

  Widget rowFlights(BuildContext context) {
    final List<Flights> flight = ModalRoute.of(context).settings.arguments;
    List<Widget> list = new List<Widget>();

    // if (flight.length == 0) {
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
    //   //         new Text("Belum Ada Penerbangan"),
    //   //         Padding(
    //   //           padding: EdgeInsets.only(bottom: 20.0),
    //   //         ),
    //   //       ],
    //   //     ));
    // }

    for (int i = 0; i < flight.length; i++) {
      list.add(Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
          ),
          ClipPath(
            clipper: TicketClipper(10.0),
            child: Material(
              elevation: 4.0,
              shadowColor: Color(0x30E5E5E5),
              color: Colors.transparent,
              child: ClipPath(
                clipper: TicketClipper(12.0),
                child: Card(
                  elevation: 0.0,
                  margin: const EdgeInsets.all(2.0),
                  child: _buildCardContent(flight[i]),
                ),
              ),
            ),
          )
        ],
      ));
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

  Container _buildCardContent(Flights flight) {
    TextStyle airportShortNameStyle =
        new TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600);
    TextStyle flightNumberStyle =
        new TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/${flight.airline.code.toLowerCase()}.jpg",
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${flight.airline.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${flight.klass}".replaceFirst("e", "E"),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Keberangkatan",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ConvertVar.dateToConvert(flight.etdAt, 'dd MMM yy'),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Text(ConvertVar.dateToConvert(flight.etdAt, 'h:m'),
                            style: airportShortNameStyle),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Text(
                          "${flight.from.code}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    Icons.airplanemode_active,
                    color: Colors.red,
                  ),
                ),
                Text("${flight.code}", style: flightNumberStyle),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Kedatangan",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ConvertVar.dateToConvert(flight.etaAt, 'dd MMM yy'),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Text(ConvertVar.dateToConvert(flight.etaAt, 'h:m'),
                            style: airportShortNameStyle),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                        ),
                        Text(
                          "${flight.to.code}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
