import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_store.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/dash_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class BookingDetailPage extends StatefulWidget {
  @override
  _BookingDetailPageState createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  InvoiceStore _invoiceStore;
  ListingStore _listingStore;
  UserStore _userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _invoiceStore = Provider.of<InvoiceStore>(context);
    _listingStore = Provider.of<ListingStore>(context);
    _userStore = Provider.of<UserStore>(context);

    _userStore.getUser();

    if (_invoiceStore.invoice.listing.id != null) {
      if (_listingStore.listing == null)
        _listingStore.getListingDetail(_invoiceStore.invoice.listing.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        title: Text("Detail Pemesan"),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
          ),
          Observer(builder: (_) {
            return Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(15),
              decoration: new BoxDecoration(
                  color: const Color(0xFFffffff),
                  border: new Border.all(
                      width: 1.0, color: const Color(0xFFffffff)),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0),
                      bottomLeft: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0))),
              child: _listingStore.loadingDetail
                  ? Center(child: CircularProgressIndicator())
                  : _buildListingBooking(),
            );
          }),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Text("Data Pemesan",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          _buildDataPemesan(),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              left: 20,
            ),
            child: Text("Data Jamaah",
                style: Theme.of(context).textTheme.subtitle1),
          ),
          _buildDataJamaah(),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 20, left: 20),
            padding: EdgeInsets.all(15),
            decoration: new BoxDecoration(
                color: const Color(0xFFffffff),
                border:
                    new Border.all(width: 1.0, color: const Color(0xFFffffff)),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Rincian Biaya",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  _buildListRincian(),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width * 0.82,
                    child: Text(
                        "* Harga yang tertera dalam rupiah sudah menyesuaikan kurs yang sekarang",
                        style: Theme.of(context).textTheme.caption),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  Widget _buildListRincian() {
    List<Widget> list = new List<Widget>();
    if (_invoiceStore.listPaket.isNotEmpty) {
      _invoiceStore.listPaket.forEach((f, k) {
        list.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("${k["count"]}x Paket ${k["paket"]}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(k["price"])}",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.82,
                child: DashedRect(
                  color: Colors.black26,
                  strokeWidth: 1.0,
                  gap: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
            ],
          ),
        );
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: list,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Row(
          children: <Widget>[
            Text("Diskon",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                      "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.discount)}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Row(
          children: <Widget>[
            Text("Total Biaya",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                      "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.total)}",
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDataPemesan() {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        decoration: new BoxDecoration(
            color: const Color(0xFFffffff),
            border: new Border.all(width: 1.0, color: const Color(0xFFffffff)),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0))),
        child: new Wrap(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(bottom: 15),
            ),
            new Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          placeholder: kTransparentImage,
                          image: ConvertVar.convertUrlPhoto(_userStore.user.photo.url)),
                    ),
                    SizedBox(width: 20),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          (_userStore.user != null
                              ? _userStore.user.name
                              : '-'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        new Padding(padding: EdgeInsets.only(top: 15)),
                        new Text(
                          (_userStore.user != null
                              ? _userStore.user.email
                              : '-'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 15),
                        ),
                        new Text(
                          (_userStore.user != null
                              ? _userStore.user.phone
                              : '-'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    )
                  ],
                )),
          ],
        ));
  }

  Widget _buildDataJamaah() {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _invoiceStore.invoice.bookings.length; i++) {
      list.add(Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          padding: EdgeInsets.all(15),
          decoration: new BoxDecoration(
              color: const Color(0xFFffffff),
              border:
                  new Border.all(width: 1.0, color: const Color(0xFFffffff)),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0))),
          child: new Wrap(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.profiles,
                      arguments: _invoiceStore.invoice.bookings[i].profile.slug);
                },
                child: new Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              width: MediaQuery.of(context).size.width * 0.58,
                              child: new Text(
                                "${_invoiceStore.invoice.bookings[i].profile.name}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                            ),
                            new Text(
                              "Paket ${_invoiceStore.invoice.bookings[i].variant.name}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 10),
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.blueAccent,
                              )),
                        )
                      ],
                    )),
              )
            ],
          )));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: list,
    );
  }

  Widget _buildListingBooking() {
    return Wrap(
      children: <Widget>[
        new Container(
          height: (MediaQuery.of(context).size.width >= 360)
              ? MediaQuery.of(context).size.height * 0.12
              : MediaQuery.of(context).size.width * 0.3,
          width: (MediaQuery.of(context).size.width >= 360)
              ? MediaQuery.of(context).size.width * 0.25
              : MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "${ConvertVar.convertUrlPhoto(_listingStore.listing.pict.medium.url)}"),
                  fit: BoxFit.cover,
                ),
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(5.0),
                    topLeft: const Radius.circular(5.0),
                    bottomRight: const Radius.circular(5.0),
                    topRight: const Radius.circular(5.0))),
          ),
        ),
        new Container(
            padding: (MediaQuery.of(context).size.width >= 360)
                ? EdgeInsets.only(left: 10)
                : EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.width * 0.5,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "${_listingStore.listing.name}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                new Text(
                  "Tersisa ${_listingStore.listing.availableSeats} kursi",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
              ],
            )),
      ],
    );
  }
}
