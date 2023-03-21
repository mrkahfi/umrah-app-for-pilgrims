import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/addon/addon.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice_form.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InvoiceDetailPage extends StatefulWidget {
  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  InvoiceStore _invoiceStore;
  SiteStore _siteStore;
  // static const KEY_NATIVE_MIDTRANS = "showMidtrans";
  // static const platform =
  //     const MethodChannel("com.example.app_jamaah_boilerplate.channel");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _invoiceStore = Provider.of<InvoiceStore>(context);
    _siteStore = Provider.of<SiteStore>(context);
    // _bankStore = Provider.of<BankStore>(context);

    var slug = ModalRoute.of(context).settings.arguments;
    if (!_invoiceStore.loadingDetail) {
      _invoiceStore.getInvoicesDetail(slug);
    }
    if (_siteStore.isSiteEmpty) {
      _siteStore.getSites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Status Tagihan', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        color: ListAppTheme.buildLightTheme().backgroundColor,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_invoiceStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_invoiceStore.errorStore.errorMessage);
        }
        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: "Status Tagihan",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _invoiceStore.loadingDetail
            ? CustomProgressBar()
            : Material(child: _buildContentMainDetailView());
      },
    );
  }

  Widget _buildContentMainDetailView() {
    return _invoiceStore.invoice != null
        ? _buildListMainContent()
        : Center(
            child: Text(
              "Data Kosong",
            ),
          );
  }

  navigatesMidtransNull(String routes, String slug) async {
    var result = await Navigator.of(context).pushNamed(routes, arguments: slug);
    if (result == null) {
      result = false;
    } else {
      _showSuccessMessage();
    }
  }

  navigatesPaymentMidtrans(String routes, InvoiceArguments argument) async {
    var result =
        await Navigator.of(context).pushNamed(routes, arguments: argument);
    if (result == null) {
      result = false;
    } else {
      _showSuccessMessage();
    }
  }

  _showSuccessMessage() {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createSuccess(
        message: "Data Berhasil Disimpan",
        title: "Pembayaran Sukses",
        duration: Duration(seconds: 3),
      )..show(context);
    });
    return SizedBox.shrink();
  }

  Widget _buildListMainContent() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                    color: const Color(0xFFF8FCFF),
                    border:
                        Border.all(width: 1.0, color: const Color(0xFFF8FcFF)),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                        bottomLeft: const Radius.circular(10),
                        bottomRight: const Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Container(
                      decoration: BoxDecoration(
                          color: (_invoiceStore.invoice.status == "NEW")
                              ? const Color(0xFFf8fcff)
                              : (_invoiceStore.invoice.status == "PARTIAL")
                                  ? Colors.amber
                                  : Colors.greenAccent,
                          border: Border.all(
                              width: 1.0, color: const Color(0xFFF8FcFF)),
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10),
                              topRight: const Radius.circular(10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10))),
                      width: MediaQuery.of(context).size.width * 0.89,
                      height: MediaQuery.of(context).size.width * 0.1,
                      child: Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Icon(Icons.timer, color: Colors.black),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Text(_invoiceStore.invoice.getStatus(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF000000))),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(15),
                decoration: new BoxDecoration(
                    color: Colors.blueAccent,
                    border:
                        new Border.all(width: 1.0, color: Colors.blueAccent),
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
                    Text(
                      "No. Tagihan",
                      style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "${_invoiceStore.invoice.number}",
                      style: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Total Harga",
                          style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.totalPrice)}",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontFamily: "NeoSansStdMediumTR"),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white70,
                    ),
                    Column(
                      children: listAddons(),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Total Diskon",
                          style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.discount)}",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontFamily: "NeoSansStdMediumTR"),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.white70,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Sudah Dibayarkan",
                          style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.totalPayment)}",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontFamily: "NeoSansStdMediumTR"),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                    ),
                    Text(
                      "Total Sisa Tagihan",
                      style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(_invoiceStore.invoice.unpaid)}",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: "NeoSansStdMediumTR"),
                    ),
                    (_invoiceStore.invoice.status.toLowerCase() == "new" ||
                            _invoiceStore.invoice.status.toLowerCase() ==
                                "partial")
                        ? GestureDetector(
                            onTap: () {
                              if (_siteStore.site.midtrans) {
                                _settingModalBottomSheet(context,
                                    _invoiceStore.invoice.id.toString());
                              } else {
                                navigatesMidtransNull(Routes.invoiceForm,
                                    _invoiceStore.invoice.id.toString());
                              }
                            },
                            child: new Container(
                              margin: const EdgeInsets.only(top: 20.0),
                              padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  right: 20.0,
                                  left: 20.0),
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: new Border.all(
                                      width: 1.0,
                                      color: const Color(0xFFf1f1f1)),
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: const Radius.circular(15.0),
                                      topLeft: const Radius.circular(15.0),
                                      bottomRight: const Radius.circular(15.0),
                                      topRight: const Radius.circular(15.0))),
                              child: new Text(
                                "BAYAR",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "NeoSansStdMediumTR"),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.bookingDetail);
                },
                child: Container(
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
                    child: new Wrap(
                      children: <Widget>[
                        new Container(
                            padding: (MediaQuery.of(context).size.width >= 360)
                                ? EdgeInsets.only(left: 10)
                                : EdgeInsets.only(top: 15),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "Detail Pemesanan",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.blueAccent,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ))),
            Container(
                margin: EdgeInsets.only(bottom: 70, left: 20, right: 20),
                padding:
                    EdgeInsets.only(top: 20, bottom: 70, left: 20, right: 20),
                decoration: new BoxDecoration(
                    color: const Color(0xFFffffff),
                    border: new Border.all(width: 1.0, color: Colors.white),
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
                    Text(
                      "Riwayat Pembayaran",
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    listPayments(context),
                  ],
                )),
          ],
        )
      ],
    );
  }

  // Future<Null> _showMidtransNativeView() async {
  //   await platform.invokeMethod(KEY_NATIVE_MIDTRANS, {
  //     'name': _invoiceStore.invoice.listing.name,
  //     'price': _invoiceStore.invoice.total,
  //     'qty': 1
  //   });
  // }

  void _settingModalBottomSheet(context, String invoiceId) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(FontAwesomeIcons.moneyBillAlt),
                    title: new Text('Bayar Otomatis'),
                    onTap: () {
                      Navigator.pop(context);
                      navigatesPaymentMidtrans(
                          Routes.invoiceForm,
                          InvoiceArguments(
                              invoiceId: invoiceId, isMidtrans: true));
                    }),
                new ListTile(
                  leading: new Icon(FontAwesomeIcons.coins),
                  title: new Text('Bayar Manual'),
                  onTap: () {
                    Navigator.pop(context);
                    navigatesPaymentMidtrans(
                        Routes.invoiceForm,
                        InvoiceArguments(
                            invoiceId: invoiceId, isMidtrans: false));
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget listPayments(BuildContext context) {
    List<Widget> list = new List<Widget>();

    if (_invoiceStore.invoice.payments.length == 0) {
      list.add(new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60),
          ),
          Center(
            child: Image.asset(
              "assets/images/pembayaran.png",
              width: 120,
              height: 120,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Center(
            child: Text("Belum ada transaksi",
                style: Theme.of(context).textTheme.subtitle1),
          )
        ],
      ));
    } else {
      for (int i = 0; i < _invoiceStore.invoice.payments.length; i++) {
        list.add(new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: new BoxDecoration(
                        color: (_invoiceStore.invoice.payments[i].status
                                    .toLowerCase() ==
                                "new")
                            ? Colors.amberAccent
                            : (_invoiceStore.invoice.payments[i].status
                                        .toLowerCase() ==
                                    "valid")
                                ? Colors.blueAccent
                                : Colors.redAccent,
                        border: new Border.all(
                            width: 1.0,
                            color: (_invoiceStore.invoice.payments[i].status
                                        .toLowerCase() ==
                                    "new")
                                ? Colors.amberAccent
                                : (_invoiceStore.invoice.payments[i].status
                                            .toLowerCase() ==
                                        "valid")
                                    ? Colors.blueAccent
                                    : Colors.redAccent),
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(30.0),
                            topRight: const Radius.circular(30.0),
                            bottomLeft: const Radius.circular(30.0),
                            bottomRight: const Radius.circular(30.0))),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Text("26 Feb 2019"),
                    Text(
                      "${_invoiceStore.invoice.payments[i].getPayStatus()}",
                      style: TextStyle(
                          color: (_invoiceStore.invoice.payments[i].status
                                      .toLowerCase() ==
                                  "new")
                              ? Colors.amberAccent
                              : (_invoiceStore.invoice.payments[i].status
                                          .toLowerCase() ==
                                      "valid")
                                  ? Colors.blueAccent
                                  : Colors.redAccent),
                    ),
                    Text("Tipe : ${_invoiceStore.invoice.payments[i].tipe}"),
                  ],
                ),
                Expanded(
                  child: Text(
                    "${_invoiceStore.invoice.currency} ${ConvertVar.toDecimal(_invoiceStore.invoice.payments[i].amount)}",
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Divider(),
          ],
        ));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }

  List<Widget> listAddons() {
    List<Widget> widgetList = [];
    for (var i = 0; i < _invoiceStore.invoice.addons.length; i++) {
      Addon addon = _invoiceStore.invoice.addons[i];
      widgetList.add(new Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Addon " + addon.category,
                style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
              Expanded(
                child: Text(
                  "${ConvertVar.toSimbolCurrency(_invoiceStore.invoice.currency)} ${ConvertVar.toDecimal(addon.amount)}",
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      fontFamily: "NeoSansStdMediumTR"),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.white70,
          ),
        ],
      ));
    }
    return widgetList;
  }
}
