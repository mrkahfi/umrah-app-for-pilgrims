import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/listing/variant.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/button_radius.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListingInfoPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ListAppTheme.buildLightTheme(),
      child: Container(child: _buildIsLoggedIn(context)),
    );
  }

  Widget _buildIsLoggedIn(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                listPrice(context),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonRadius(
                icon: null,
                height: 50,
                callback: () {
                  gotobooking(context);
                },
                backgroundColor: Colors.orange,
                text: Text(
                  "Booking Sekarang",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                radius: 10,
                colorBorder: Colors.orange,
              )
            ],
          ),
        ],
      ),
    );
  }

  navigates(BuildContext context, String routes) async {
    var result = await Navigator.of(context).pushNamed(routes);
    if (result == null) {
      result = false;
    } else {
      Navigator.pop(context, true);
    }
  }

  void gotobooking(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(Preferences.auth_token) != null
        ? navigates(context, Routes.booking)
        : _showIsLoggedInDialog(context);
  }

  void _showIsLoggedInDialog(BuildContext context) {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: Text('Dibutuhkan Login'),
    //         content: Text(
    //             'Untuk melakukan booking, silakan login dengan akun yang telah terdaftar.'),
    //         actions: <Widget>[
    //           FlatButton(
    //               onPressed: () {
    //                 Navigator.of(context).pushNamed(Routes.login);
    //               },
    //               child: Text('Login')),
    //           FlatButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text('Batal'),
    //           )
    //         ],
    //       );
    //     });
    Alert(
        context: context,
        type: AlertType.info,
        title: Strings.infoLoginTitle,
        desc: Strings.infoLoginDesc,
        buttons: [
          DialogButton(
            child: Text(
              Strings.btnLogin,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.login);
            },
            color: Colors.green,
          ),
          DialogButton(
            child: Text(
              Strings.btnSignup,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(Routes.signup);
            },
            color: Colors.grey,
          ),
        ]).show();
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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 8, right: 8),
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
                  "Daftar Harga",
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

  Widget listPrice(BuildContext context) {
    final List<Variants> variants = ModalRoute.of(context).settings.arguments;
    return variants != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: variants.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  color: ListAppTheme.buildLightTheme().backgroundColor,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${variants[index].name}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.account_balance_wallet),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "${ConvertVar.toSimbolCurrency(variants[index].currency)}${ConvertVar.toDecimal(variants[index].price)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Padding(
                padding: EdgeInsets.all(40), child: Text("Tidak Ada Variant")),
          );
  }
}
