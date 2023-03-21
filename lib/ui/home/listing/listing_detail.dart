import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/box_menu.dart';
import 'package:app_jamaah_boilerplate/widgets/button_radius.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/line_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';
import 'package:share/share.dart';

class ListingDetailPage extends StatefulWidget {
  @override
  _ListingDetailPageState createState() => _ListingDetailPageState();
}

class _ListingDetailPageState extends State<ListingDetailPage> {
  ListingStore _listingStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _listingStore = Provider.of<ListingStore>(context);

    int _listingId = ModalRoute.of(context).settings.arguments;
    // check to see if already called api
    if (_listingId != null) {
      _listingStore.getListingDetail(_listingId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {},
          child: _buildMainContent()),
      new Positioned(
        top: 15.0,
        left: 15.0,
        right: 0.0,
        height: 70,
        child: AppBar(
          title: Text(''), // You can add title here
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: new Container(
              padding: const EdgeInsets.all(
                  10.0), //I used some padding without fixed width and height
              decoration: new BoxDecoration(
                shape: BoxShape
                    .circle, // You can use like this way or like the below line
                color: Colors.lightBlueAccent,
              ),
              child:
                  new Icon(Icons.arrow_back, size: 24.0, color: Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent, //You can make this transparent
          elevation: 0.0, //No shadow
        ),
      ),
    ]));
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _listingStore.loadingDetail
            ? CustomProgressBar()
            : Material(child: _buildListingDetailView(context));
      },
    );
  }

  Widget _buildListingDetailView(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image(
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      image: NetworkImage('${_listingStore.listing.pict.url}'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Icon(Icons.category),
                            new Padding(padding: EdgeInsets.only(right: 10)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: new Text(
                                "${_listingStore.listing.category}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            ButtonRadius(
                              callback: () {
                                if (_listingStore.listing != null) {
                                  _showDialog(context);
                                }
                              },
                              height: 40,
                              icon: Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.lightBlueAccent,
                              colorBorder: Colors.lightBlueAccent,
                              radius: 20,
                              text: Text(
                                "Bagikan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Text("${_listingStore.listing.name}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        LineController(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 4,
                          colorLine: Colors.lightBlueAccent,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        Html(
                          data: _listingStore.listing.description,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text("Fasilitas",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        LineController(
                          width: MediaQuery.of(context).size.width * 0.30,
                          height: 4,
                          colorLine: Colors.lightBlueAccent,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BoxMenu(
                              icon: Icon(
                                Icons.format_line_spacing,
                                size: 36,
                              ),
                              menuName: "Itinerary",
                              callback: () {
                                Navigator.of(context).pushNamed(
                                    Routes.listingInfoItinerary,
                                    arguments:
                                        _listingStore.listing.itineraries);
                              },
                              colorBox: Colors.blue,
                            ),
                            BoxMenu(
                              icon: Icon(
                                Icons.hotel,
                                size: 36,
                              ),
                              menuName: "Hotel",
                              callback: () {
                                Navigator.of(context).pushNamed(
                                    Routes.listingInfoHotel,
                                    arguments: _listingStore.listing.hotels);
                              },
                              colorBox: Colors.orange,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BoxMenu(
                              icon: Icon(
                                Icons.flight,
                                size: 36,
                              ),
                              menuName: "Penerbangan",
                              callback: () {
                                Navigator.of(context).pushNamed(
                                    Routes.listingInfoAirline,
                                    arguments: _listingStore.listing.flights);
                              },
                              colorBox: Colors.redAccent,
                            ),
                            BoxMenu(
                              icon: Icon(
                                Icons.directions_bus,
                                size: 36,
                              ),
                              menuName: "Bus",
                              callback: () {
                                Navigator.of(context).pushNamed(
                                    Routes.listingInfoBus,
                                    arguments: _listingStore.listing.buses);
                              },
                              colorBox: Colors.blueAccent,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ))),
        ),
        (_listingStore.listing.status != "expired" ||
                _listingStore.listing.availableSeats > 0)
            ? Container(
                color: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //your elements here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Harga mulai",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                              Text(
                                  "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)}${ConvertVar.toDecimal(_listingStore.listing.priceStart)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Text(
                                  "Tersedia ${_listingStore.listing.availableSeats} kursi",
                                  style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        ButtonRadius(
                          colorBorder: Colors.orange,
                          backgroundColor: Colors.orange,
                          height: 40,
                          radius: 5,
                          icon: null,
                          text: Text(
                            'Daftar Harga Paket',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          callback: () => navigates(context, Routes.listingInfoPrice),
                              // {navigates(context, Routes.listingInfoPrice)},
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container(
                color: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //your elements here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Harga mulai",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                              Text(
                                  "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)}${ConvertVar.toDecimal(_listingStore.listing.priceStart)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Text("Habis",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.redAccent)),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
      ],
    );
  }

  navigates(BuildContext context, String routes) async {
    var result = await Navigator.of(context)
        .pushNamed(routes, arguments: _listingStore.listing.variants);
    if (result == null) {
      result = false;
    } else {
      Navigator.pop(context);
    }
  }

  void _showDialog(context) {
    var listing = _listingStore.listing;
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          title: new Text('Bagikan...'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    var textToShare = _parseHtmlString(listing.description);

                    textToShare = textToShare +
                        "\n\nSelengkapnya: " +
                        Endpoints.baseUrl +
                        "/listings/" +
                        listing.slug;
                    Share.share(textToShare);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.info),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('Deskripsi'),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      String textToShare = "*" +
                          listing.name +
                          "*\n" +
                          "Mulai ${ConvertVar.toSimbolCurrency(listing.currency)} ${ConvertVar.toDecimal(listing.priceStart)}\n\n";

                      for (var i = 0; i < listing.variants.length; i++) {
                        textToShare = textToShare +
                            "\n-${ConvertVar.toSimbolCurrency(listing.variants[i].currency)}${ConvertVar.toDecimal(listing.variants[i].price)}";
                      }
                      Share.share(textToShare);
                    },
                    child: new Row(
                      children: <Widget>[
                        new Icon(Icons.monetization_on),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Text('Varian'),
                        ),
                      ],
                    )),
                new SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);

                    var textToShare = "Itinerary *" + listing.name + "*\n\n";
                    for (var i = 0; i < listing.itineraries.length; i++) {
                      textToShare = textToShare +
                          "\n*Hari ke-${listing.itineraries[i].day}:* " +
                          _parseHtmlString(listing.itineraries[i].description);
                    }
                    Share.share(textToShare);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.calendar_today),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('Itinerary'),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    var textToShare = "Pesawat *" + listing.name + "*\n";
                    for (var i = 0; i < listing.flights.length; i++) {
                      textToShare = textToShare +
                          "\n\n${i + 1} - Berangkat: *" +
                          listing.flights[i].from.name +
                          "*\nWaktu: *" +
                          ConvertVar.dateToConvert(
                              listing.flights[i].etdAt, 'dd MMM yy') +
                          "*, pukul *" +
                          ConvertVar.dateToConvert(
                              listing.flights[i].etdAt, 'h:m') +
                          "*.\nTiba: *" +
                          listing.flights[i].to.name +
                          "*\nWaktu: *" +
                          ConvertVar.dateToConvert(
                              listing.flights[i].etaAt, 'dd MMM yy') +
                          "*, pukul *" +
                          ConvertVar.dateToConvert(
                              listing.flights[i].etaAt, 'h:m') +
                          "*.\nMaskapai: *" +
                          listing.flights[i].airline.name +
                          "* (" +
                          listing.flights[i].code +
                          ")";
                    }
                    Share.share(textToShare);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.flight),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('Pesawat'),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    var textToShare = "Hotel *" + listing.name + "*\n\n";
                    for (var i = 0; i < listing.hotels.length; i++) {
                      textToShare = textToShare +
                          "\n\n*" +
                          listing.hotels[i].hotel.city.name +
                          ":* " +
                          listing.hotels[i].hotel.name +
                          " (Bintang ${listing.hotels[i].hotel.star}) "
                              "\n" +
                          listing.hotels[i].hotel.description +
                          "\n" +
                          "https://www.google.com/maps/search/?api=1&query=" +
                          listing.hotels[i].hotel.name.replaceAll(" ", "%20");
                    }
                    Share.share(textToShare);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.hotel),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('Hotel'),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    var textToShare = "Bus *" + listing.name + "*\n";
                    for (var i = 0; i < listing.buses.length; i++) {
                      textToShare =
                          textToShare + "\n${i + 1} - " + listing.buses[i].bus;
                    }
                    Share.share(textToShare);
                  },
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.train),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text('Bus'),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _parseHtmlString(String htmlString) {
    String towa = htmlString
        .replaceAll("<br>", "\n")
        .replaceAll("<div>", "")
        .replaceAll("</div>", "")
        .replaceAll("<strong>", "*")
        .replaceAll("</strong>", "*")
        .replaceAll("&nbsp;", "");
    return parse(towa).documentElement.text;
  }
}
