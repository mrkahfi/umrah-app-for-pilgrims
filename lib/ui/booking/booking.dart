import 'package:app_jamaah_boilerplate/models/jamaah/jamaah.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/booking/booking_store.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/dash_rect.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:transparent_image/transparent_image.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  MoneyMaskedTextController controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');
  BookingStore _bookingStore;
  ListingStore _listingStore;
  UserStore _userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookingStore = Provider.of<BookingStore>(context);
    _listingStore = Provider.of<ListingStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 60,
                  left: 20,
                ),
                child: Text(
                  "Booking",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
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
                child: _buildDataBooking(),
              ),
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
              _buildAddJamaah(),
              Container(
                width: 200,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                    onTap: () {
                      _bookingStore.setJamaah(null);
                      _bookingStore.setDropdownVariant(null);
                      Navigator.of(context).pushNamed(Routes.addJamaah);
                    },
                    child: DottedBorder(
                      padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
                      color: Colors.black26,
                      strokeWidth: 1,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.25),
                              child: new Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: const Radius.circular(20.0),
                                        topLeft: const Radius.circular(20.0),
                                        bottomRight:
                                            const Radius.circular(20.0),
                                        topRight: const Radius.circular(20.0))),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 10),
                            child: Text("Tambah Jama'ah",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        ],
                      ),
                    )),
              ),
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
                    border: new Border.all(
                        width: 1.0, color: const Color(0xFFffffff)),
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
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Text(
                      //       "* Diskon yang diberikan akan memotong Total Fee Anda",
                      //       style: Theme.of(context).textTheme.caption),
                      // ),
                    ]),
              ),
              _buildButtonSubmit()
            ],
          ),
          Positioned(
            child: new Container(
              width: 100.0,
              height: 80.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.only(top: 35.0, left: 15.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBookingSuccess(),
          _buildBookingError()
        ],
      ),
    );
  }

  void _showDialog(Jamaah jamaah) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Hapus Data Jamaah?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: new Text(
              "Anda akan menghapus salah satu data jamaah atas nama " +
                  jamaah.name),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Tidak"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Ya"),
              onPressed: () {
                _bookingStore.removeJamaah(jamaah);
                setState(() {
                  _buildAddJamaah();
                  _buildListRincian();
                  if (!_bookingStore.canBooking) _bookingStore.setSwitchJamaah(false);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogSubmit() {
    Alert(
        context: context,
        type: AlertType.info,
        title: "Booking Sekarang?",
        desc: "Data Jamaah akan dikirim ke server pusat",
        buttons: [
          DialogButton(
            child: Text(
              "Ya",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              _bookingStore.bookingNow(
                  _listingStore.listing.id.toString(),
                  _userStore.user.name,
                  _userStore.user.email,
                  _userStore.user.phone);
            },
            color: Colors.green,
          ),
          DialogButton(
            child: Text(
              "Tidak",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey,
          ),
        ]).show();
  }

  @override
  void dispose() {
    super.dispose();
    _bookingStore.dispose();
    if (_bookingStore.listJamaah.isNotEmpty) controller.dispose();
  }

  Widget _buildAddJamaah() {
    List<Widget> list = new List<Widget>();
    if (_bookingStore.canBooking) {
      for (var i = 0; i < _bookingStore.listJamaah.length; i++) {
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
                Observer(builder: (_) {
                  return Container(
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
                                  "${_bookingStore.listJamaah[i].name}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                              ),
                              new Text(
                                "Paket ${_bookingStore.listJamaah[i].paket}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _bookingStore
                                        .setJamaah(_bookingStore.listJamaah[i]);
                                    Navigator.pushNamed(
                                        context, Routes.addJamaah);
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.blueAccent),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                ),
                                GestureDetector(
                                    onTap: () => {
                                          _showDialog(
                                              _bookingStore.listJamaah[i])
                                        },
                                    child: Text("Hapus",
                                        style: TextStyle(
                                            color: Colors.redAccent))),
                              ],
                            ),
                          ),
                        ],
                      ));
                })
              ],
            )));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
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
            new Container(
                padding: (MediaQuery.of(context).size.width >= 360)
                    ? EdgeInsets.only(top: 20, left: 0)
                    : EdgeInsets.only(top: 20),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Saya sebagai jamaah",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Observer(builder: (_) {
                            return Switch(
                              value: _bookingStore.switchIsJamaah,
                              onChanged: (val) {
                                _bookingStore.setSwitchJamaah(val);
                                if (val)
                                  Navigator.of(context).pushNamed(
                                      Routes.addJamaah,
                                      arguments: _userStore.user);
                              },
                              activeColor: Colors.green,
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _buildDataBooking() {
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
                      "${_listingStore.listing.pict.medium.url}"),
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
                Text(
                  "${_listingStore.listing.name}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  "Tersisa ${_listingStore.listing.availableSeats} kursi",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildListRincian() {
    List<Widget> list = new List<Widget>();
    if (_bookingStore.listJamaah.isNotEmpty) {
      _bookingStore.listPaket.forEach((f, k) {
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
                            "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)} ${ConvertVar.toDecimal(k["price"])}",
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
                        "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)} ${ConvertVar.toDecimal(_bookingStore.totalAmount)}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Paket Kamar",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                            "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)} -",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * 0.82,
                child:
                    DashedRect(color: Colors.black26, strokeWidth: 1.0, gap: 3),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
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
                        "${ConvertVar.toSimbolCurrency(_listingStore.listing.currency)} -",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildButtonSubmit() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: RoundedButtonWidget(
          buttonText: 'Booking Sekarang',
          buttonColor: _bookingStore.canBooking ? Colors.blue : Colors.grey,
          textColor: Colors.white,
          onPressed: () async {
            if (_bookingStore.canBooking) {
              _showDialogSubmit();
            }
          },
        ),
      );
    });
  }

  navigates(BuildContext context, String routes) async {
    var result = await Navigator.of(context)
        .pushNamed(routes, arguments: _bookingStore.invoice);
    if (result == null) {
      result = false;
    } else {
      Navigator.pop(context, true);
    }
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      navigates(context, Routes.confirmBooking);
    });
    return Container();
  }

  Widget _buildBookingSuccess() {
    return Observer(
      builder: (context) {
        return _bookingStore.success
            ? navigate(context)
            : _showErrorMessage(_bookingStore.errorStore.errorMessage);
      },
    );
  }

  Widget _buildBookingError() {
    return Observer(
      builder: (context) {
        return Visibility(
          visible: _bookingStore.loading,
          child: CustomProgressBar(),
        );
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: "Error",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }
}
