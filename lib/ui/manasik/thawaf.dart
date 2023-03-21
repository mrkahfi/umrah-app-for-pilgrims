import 'dart:math';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:async';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ThawafPage extends StatefulWidget {
  @override
  _ThawafPageState createState() => _ThawafPageState();
}

class _ThawafPageState extends State<ThawafPage> {
  Completer<GoogleMapController> _completer = Completer();
  GoogleMapController _controller;
  final Set<Polyline> _polyline = {};
  final Set<Marker> _markers = {};
  static GlobalConfiguration cfg;
  final int ticks = 0;

  List<LatLng> latlngAllArea = List();
  List<LatLng> latlngAreaStart = List();
  List<LatLng> latlngAreaYamani = List();
  List<LatLng> latlngAreaIraqi = List();
  List<LatLng> latlngAreaSyami = List();
  String btnStart;
  String bacaan =
      "<p>Fitur ini hanya bisa berjalan di area Tawaf <i>(Mathaaf)</i></p>";
  String areaName = "Di Luar Area";

  int tawafCount = 0;

  bool inStart = true;
  bool inSyami = false;
  bool inIraqi = false;
  bool inYamani = false;
  bool isTawafStarted = false;

  static const LatLng _center = const LatLng(21.422448, 39.826151);
  LatLng _lastMapPosition = _center;

  final int iconSize = 30;

  void _onMapCreated(GoogleMapController controller) {
    _completer.complete(controller);
    _controller = controller;
  }

  @override
  void initState() {
    super.initState();
    cfg = new GlobalConfiguration();

    btnStart = "Start";

    WidgetsBinding.instance.addPostFrameCallback((_) => loadMaps());
  }

  loadMaps() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/kaaba.png', 200);
    latlngAllArea.add(new LatLng(21.424388, 39.827784));
    latlngAllArea.add(new LatLng(21.422511, 39.826233));
    latlngAllArea.add(new LatLng(21.421023, 39.826856));
    latlngAllArea.add(new LatLng(21.424388, 39.827784));

    latlngAreaStart.add(new LatLng(21.424388, 39.827784));
    latlngAreaStart.add(new LatLng(21.422511, 39.826233));
    latlngAreaStart.add(new LatLng(21.421023, 39.826856));
    latlngAreaStart.add(new LatLng(21.424388, 39.827784));

    latlngAllArea.add(new LatLng(21.421023, 39.826856));
    latlngAllArea.add(new LatLng(21.42226006618295, 39.82514977455139));
    latlngAllArea.add(new LatLng(21.422511, 39.826233));

    latlngAreaYamani.add(new LatLng(21.421023, 39.826856));
    latlngAreaYamani.add(new LatLng(21.42226006618295, 39.82514977455139));
    latlngAreaYamani.add(new LatLng(21.422511, 39.826233));

    latlngAllArea.add(new LatLng(21.424388, 39.827784));
    latlngAllArea.add(new LatLng(21.42290926027067, 39.825337529182434));
    latlngAllArea.add(new LatLng(21.422511, 39.826233));

    latlngAreaIraqi.add(new LatLng(21.424388, 39.827784));
    latlngAreaIraqi.add(new LatLng(21.42290926027067, 39.825337529182434));
    latlngAreaIraqi.add(new LatLng(21.422511, 39.826233));

    latlngAllArea.add(new LatLng(21.42252, 39.826156));
    latlngAllArea.add(new LatLng(21.42290926027067, 39.825337529182434));
    latlngAllArea.add(new LatLng(21.42226006618295, 39.82514977455139));
    latlngAllArea.add(new LatLng(21.422457, 39.82615));

    latlngAreaSyami.add(new LatLng(21.42252, 39.826156));
    latlngAreaSyami.add(new LatLng(21.42290926027067, 39.825337529182434));
    latlngAreaSyami.add(new LatLng(21.42226006618295, 39.82514977455139));
    latlngAreaSyami.add(new LatLng(21.422457, 39.82615));

    var location = new Location();

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (!mounted) return;
      setState(() {
        if (_controller != null)
          _controller.moveCamera(CameraUpdate.newLatLng(
              LatLng(currentLocation.latitude, currentLocation.longitude)));
      });

      if (!isTawafStarted) {
        print("not started");
        return;
      }

      if (pointInPolygon(
          new LatLng(currentLocation.latitude, currentLocation.longitude),
          latlngAreaStart)) {
        print("area start");
        if (!inStart) {
          inStart = true;
          inYamani = false;
          inSyami = false;
          inIraqi = false;

          setState(() {
            tawafCount++;
            if (tawafCount > 1) {
              bacaan = cfg.getValue('bacaan_hajar_aswad');
              areaName = "Hajar Aswad";
            } else {
              bacaan = cfg.getValue('bacaan_start_tawaf');
              areaName = "Mulai Thawaf";
            }
            print(
                "if not in Start Area, then set in Start = true, tawafCount = $tawafCount");
          });
        }
      }

      if (pointInPolygon(
          new LatLng(currentLocation.latitude, currentLocation.longitude),
          latlngAreaSyami)) {
        print("area syami");
        if (!inSyami) {
          inStart = false;
          inYamani = false;
          inSyami = true;
          inIraqi = false;

          setState(() {
            bacaan = cfg.getValue('bacaan_tawaf_sudah_dimulai');
            areaName = "Rukun Syami";
          });
        }
      }

      if (pointInPolygon(
          new LatLng(currentLocation.latitude, currentLocation.longitude),
          latlngAreaIraqi)) {
        print("area iraqi");

        if (!inIraqi) {
          inStart = false;
          inYamani = false;
          inSyami = false;
          inIraqi = true;

          setState(() {
            bacaan = cfg.getValue('bacaan_tawaf_sudah_dimulai');
            areaName = "Rukun Iraqi";
          });
        }
      }

      if (pointInPolygon(
          new LatLng(currentLocation.latitude, currentLocation.longitude),
          latlngAreaYamani)) {
        print("area yamani");

        if (!inYamani) {
          inStart = false;
          inYamani = true;
          inSyami = false;
          inIraqi = false;

          setState(() {
            bacaan = cfg.getValue('bacaan_rukun_yamani');
            areaName = "Rukun Yamani";
          });
        }
      }
    });

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'KA\'BAH',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ));
//      _polyline.add(Polyline(
//        polylineId: PolylineId(_lastMapPosition.toString()),
//        visible: true,
//        //latlng is List<LatLng>
//        points: latlngAllArea,
//        color: Colors.red,
//
//      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 19.5,
                ),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                polylines: _polyline,
                markers: _markers,
                indoorViewEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(
                      areaName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Html(
                        data: bacaan,
                        // defaultTextStyle:
                        //     TextStyle(fontSize: 18, color: Colors.black87),
                        // padding: EdgeInsets.only(
                        //     left: 15, right: 15, top: 5, bottom: 15),
                      )),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      tick1(),
                      line(),
                      tick2(),
                      line(),
                      tick3(),
                      line(),
                      tick4(),
                      line(),
                      tick5(),
                      line(),
                      tick6(),
                      line(),
                      tick7(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: 20.0, bottom: 20.0, right: 20.0, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      gradient: new LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blueAccent,
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "$btnStart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () => start()),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget tick(bool isChecked) {
    return isChecked
        ? Icon(
            Icons.check_circle,
            color: Colors.blue,
            size: 30,
          )
        : Icon(
            Icons.radio_button_unchecked,
            color: Colors.blue,
            size: 30,
          );
  }

  Widget tick1() {
    return this.tawafCount > 0 ? tick(true) : tick(false);
  }

  Widget tick2() {
    return this.tawafCount > 1 ? tick(true) : tick(false);
  }

  Widget tick3() {
    return this.tawafCount > 2 ? tick(true) : tick(false);
  }

  Widget tick4() {
    return this.tawafCount > 3 ? tick(true) : tick(false);
  }

  Widget tick5() {
    return this.tawafCount > 4 ? tick(true) : tick(false);
  }

  Widget tick6() {
    return this.tawafCount > 5 ? tick(true) : tick(false);
  }

  Widget tick7() {
    return this.tawafCount > 6 ? tick(true) : tick(false);
  }

  Widget line() {
    return Container(
      color: Colors.blue,
      height: 5.0,
      width: ((MediaQuery.of(context).size.width - 40) - (iconSize * 7)) / 6,
    );
  }

  void start() async {
    if (btnStart.toLowerCase().contains("start")) {
      var location = new Location();

      print("start clicked");

      try {
        print("getting current location");

        LocationData currentLocation = await location.getLocation();
        if (pointInPolygon(
            new LatLng(currentLocation.latitude, currentLocation.longitude),
            latlngAreaStart)) {
          _onMessage(
              "Anda berada di area mulai Tawaf. Sedang akan memulai Tawaf");
          print("Anda berada sedang akan memulai Tawa");
          setState(() {
            isTawafStarted = true;
            btnStart = "Selesai";
          });
        } else {
          _onMessage(
              "Anda berada di luar area mulai Tawaf (lampu hijau). Silakan masuk ke area mulai Tawaf terlebih dahulu");
          print(
              "Anda berada di luar area mulai Tawaf (lampu hijau). Silakan masuk ke area mulai Tawaf terlebih dahulu");
        }
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {}
        var _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }
        print("permission error");
      }
    } else {
      setState(() {
        btnStart = "Start";
        tawafCount = 0;
      });
    }
  }

  void _onMessage(String msg) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: new Text("$msg"),
              ),
            ],
          ),
        );
      },
    );
  }

  bool pointInPolygon(LatLng point, List<LatLng> target) {
    // ray casting alogrithm http://rosettacode.org/wiki/Ray-casting_algorithm
    int crossings = 0;
    if (target == null) {
      return false;
    }
//        List<LatLng> path = polygon.getPoints();
//        path.remove(path.size()-1); //remove the last point that is added automatically by getPoints()

    // for each edge
    for (int i = 0; i < target.length; i++) {
      LatLng a = target[i];
      int j = i + 1;
      //to close the last edge, you have to take the first point of your polygon
      if (j >= target.length) {
        j = 0;
      }
      LatLng b = target[j];
      if (rayCrossesSegment(point, a, b)) {
        crossings++;
      }
    }

    // odd number of crossings?
    return (crossings % 2 == 1);
  }

  bool rayCrossesSegment(LatLng point, LatLng a, LatLng b) {
    // Ray Casting algorithm checks, for each segment, if the point is 1) to the left of the segment and 2) not above nor below the segment. If these two conditions are met, it returns true
    double px = point.longitude,
        py = point.latitude,
        ax = a.longitude,
        ay = a.latitude,
        bx = b.longitude,
        by = b.latitude;
    if (ay > by) {
      ax = b.longitude;
      ay = b.latitude;
      bx = a.longitude;
      by = a.latitude;
    }
    // alter longitude to cater for 180 degree crossings
    if (px < 0 || ax < 0 || bx < 0) {
      px += 360;
      ax += 360;
      bx += 360;
    }
    // if the point has the same latitude as a or b, increase slightly py
    if (py == ay || py == by) py += 0.00000001;

    // if the point is above, below or to the right of the segment, it returns false
    if ((py > by || py < ay) || (px > max(ax, bx))) {
      return false;
    }
    // if the point is not above, below or to the right and is to the left, return true
    else if (px < min(ax, bx)) {
      return true;
    }
    // if the two above conditions are not met, you have to compare the slope of segment [a,b] (the red one here) and segment [a,p] (the blue one here) to see if your point is to the left of segment [a,b] or not
    else {
      double red = (ax != bx) ? ((by - ay) / (bx - ax)) : pow(ax, bx);
      double blue = (ax != px) ? ((py - ay) / (px - ax)) : pow(ax, px);
//      return (blue >= red);
//      double red = ((by - ay) / (bx - ax));
//      double blue = ((py - ay) / (px - ax));
      return (blue >= red);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  // _dismissDialog() {
  //   Navigator.pop(context);
  // }
}
