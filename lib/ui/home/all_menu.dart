import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/utils/alert_dialog/alert_dialog.dart';
import 'package:app_jamaah_boilerplate/widgets/flexible_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllMenuPage extends StatefulWidget {
  @override
  _AllMenuPageState createState() => _AllMenuPageState();
}

class _AllMenuPageState extends State<AllMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _buildMenuCardRowFirst(context),
                  SizedBox(
                    height: 10,
                  ),
                  _buildMenuCardRowSecond(context),
                  SizedBox(
                    height: 20,
                  ),
                  _buildMenuCardRowThird(context),
                  SizedBox(
                    height: 20,
                  ),
                  _buildMenuCardRowFour(context)
                ],
              )
            ],
          ),
        ));
  }

  void _navigate(String route) {
    Future.delayed(Duration(milliseconds: 0), () {
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getBool(Preferences.isLoggedIn) ?? false) {
          Navigator.of(context).pushNamed(route);
        } else {
          CustomAlert.showDialog(
              context,
              Strings.infoLoginTitle,
              Strings.infoLoginDesc,
              Strings.btnLogin,
              Strings.btnSignup,
              _callbackButtonPositiveDialog,
              _callbackButtonNegativeDialog);
        }
      });
    });
  }


  void _callbackButtonPositiveDialog() {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(Routes.login);
  }

  void _callbackButtonNegativeDialog() {
    Navigator.pop(context);
    Navigator.of(context).pushNamed(Routes.signup);
  }

  Widget _buildMenuCardRowFirst(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => Navigator.of(context).pushNamed(Routes.home),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              new Icon(Icons.home, size: 48, color: const Color(0xFF0b99ff)),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 70,
                child: Text(
                  'Home',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(fontFamily: "NeoSansStdMediumTR"),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => Navigator.of(context).pushNamed(Routes.listingIndex),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.assignment, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Paket',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => Navigator.of(context).pushNamed(Routes.galleryIndex),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.collections, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Gallery',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildMenuCardRowSecond(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => Navigator.of(context).pushNamed(Routes.articleIndex),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              new Icon(Icons.description, size: 48, color: const Color(0xFF0b99ff)),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 70,
                child: Text(
                  'Artikel',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(fontFamily: "NeoSansStdMediumTR"),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.invoice),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.receipt, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Pesanan',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.inbox),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.notifications, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Notifikasi',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildMenuCardRowThird(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.manasik),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.location_city, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'My Trip',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.manasik),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.directions_run,
                  size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Manasik',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.radio),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.headset, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Radio',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildMenuCardRowFour(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.family),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.video_call,
                  size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Family',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.shalat),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              new ImageIcon(AssetImage("assets/images/mosque.png"),
                  size: 48, color: const Color(0xFF0b99ff)),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 70,
                child: Text(
                  'Sholat',
                  textAlign: TextAlign.center,
                  softWrap: false,
                  style: TextStyle(fontFamily: "NeoSansStdMediumTR"),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: false,
          callback: () => _navigate(Routes.shalat),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new ImageIcon(AssetImage("assets/images/icon_do'a.png"),
                  size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Doa-doa',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
