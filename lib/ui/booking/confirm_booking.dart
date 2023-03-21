import 'package:app_jamaah_boilerplate/models/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/bank/bank_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ConfirmBookingPage extends StatefulWidget {
  @override
  _ConfirmBookingPageState createState() => _ConfirmBookingPageState();
}

class _ConfirmBookingPageState extends State<ConfirmBookingPage> {
  BankStore _bankStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bankStore = Provider.of<BankStore>(context);
    if (_bankStore.isBankEmpty) _bankStore.getBanks();
  }

  @override
  Widget build(BuildContext context) {
    Invoice invoice = ModalRoute.of(context).settings.arguments;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            body: new Stack(children: <Widget>[
          new ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 60,
                    left: 20,
                  ),
                  child: Text(
                    "Pembayaran",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                        color: const Color(0xFFF8FCFF),
                        border: new Border.all(
                            width: 1.0, color: const Color(0xFFF8FCFF)),
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.blue,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              "Silahkan melakukan pembayaran sesuai nomor rekening dibawah ini"),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  child: Text(
                    "Total Pembayaran",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0))),
                    child: Text(
                      "${ConvertVar.toSimbolCurrency(invoice.currency)} ${ConvertVar.toDecimal(invoice.total)}",
                      style: Theme.of(context).textTheme.headline6,
                    )),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      border: new Border.all(
                          width: 1.0, color: const Color(0xFFffffff)),
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0))),
                  child: Observer(
                    builder: (context) {
                      return Visibility(
                        visible: _bankStore.loading,
                        child: Center(
                            child: SpinKitWave(
                          color: Colors.blue[300],
                          type: SpinKitWaveType.center,
                          size: 30,
                        )),
                      );
                    },
                  ),
                ),
                Observer(
                  builder: (context) {
                    return _bankStore.success
                        ? listBanks(context)
                        : _showErrorMessage(_bankStore.errorStore.errorMessage);
                  },
                ),
              ]),
          new Positioned(
            child: new Container(
              width: 100.0,
              height: 80.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new GestureDetector(
                    onTap: () => _onWillPop(),
                    child: Padding(
                      padding: EdgeInsets.only(top: 35.0, left: 15.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }

  Widget listBanks(BuildContext context) {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < _bankStore.bankListData.length; i++) {
      list.add(
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.all(15),
            decoration: new BoxDecoration(
                color: const Color(0xFFffffff),
                border: new Border.all(width: 1.0, color: Colors.black26),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0))),
            child: Row(
              children: <Widget>[
                Image.network(
                  "${_bankStore.bankListData[i].logo.medium.url}",
                  width: 60,
                  height: 50,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("${_bankStore.bankListData[i].bank}",
                          style: Theme.of(context).textTheme.bodyText1),
                      Text("${_bankStore.bankListData[i].number}",
                          style: Theme.of(context).textTheme.bodyText1),
                      Text("${_bankStore.bankListData[i].name}",
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
              ],
            )),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda ingin kembali ke menu utama?',
                style: Theme.of(context).textTheme.headline6),
            content: new Text('Data yang sudah Anda isi tidak akan tersimpan'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.home, (Route<dynamic> route) => false);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ?? false;
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
