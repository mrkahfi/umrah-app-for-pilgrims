import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:app_jamaah_boilerplate/utils/alert_dialog/alert_dialog.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserStore _userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _userStore.getUser();
    print(_userStore.user);
  }

  @override
  void dispose() {
    super.dispose();
    _userStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(children: <Widget>[
      Observer(
        builder: (context) {
          return Visibility(
            visible: _userStore.loadUser,
            child: CustomProgressBar(),
          );
        },
      ),
      ClipPath(
        child: Container(color: Colors.blue),
        clipper: GetClipper(),
      ),
      Observer(
        builder: (context) {
          return _userStore.success
              ? Positioned(
                  width: MediaQuery.of(context).size.width / 1,
                  top: MediaQuery.of(context).size.height / 8.5,
                  child: Column(children: <Widget>[
                    Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            image: DecorationImage(
                                image: NetworkImage(ConvertVar.convertUrlPhoto(
                                    _userStore.user.photo.url)),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7.2,
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0.2)
                            ])),
                    SizedBox(height: 15.0),
                    Text('${_userStore.user.name}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        )),
                    SizedBox(height: 15.0),
                    ListTile(
                        leading: Icon(Icons.mail),
                        title: Text('Email',
                            style: TextStyle(color: Colors.black)),
                        subtitle: Text('${_userStore.user.email}')),
                    ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone',
                            style: TextStyle(color: Colors.black)),
                        subtitle: Text('${_userStore.user.phone}')),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.blue),
                      title:
                          Text('Logout', style: TextStyle(color: Colors.blue)),
                      subtitle: Text(''),
                      onTap: () {
                        CustomAlert.showDialog(
                            context,
                            Strings.infoLogoutTitle,
                            Strings.infoLogoutDesc,
                            Strings.btnYes,
                            Strings.btnNo,
                            _callbackButtonPositiveDialog,
                            _callbackButtonNegativeDialog);
                      },
                    ),
                  ]))
              : _showErrorMessage(_userStore.errorStore.errorMessage);
        },
      ),
    ]));
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

  void _callbackButtonPositiveDialog() {
    _userStore.logout(_userStore.user);
    navigate(context);
  }

  void _callbackButtonNegativeDialog() {
    Navigator.pop(context);
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Konfirmasi'),
            content: Text('Apakah Anda yakin akan logout?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _userStore.logout(_userStore.user);
                    navigate(context);
                  },
                  child: Text('Logout')),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Batal'),
              )
            ],
          );
        });
  }

  void navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.home,
        (Route<dynamic> route) => false,
      );
    });
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 3.2);
    path.lineTo(size.width + 300, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
