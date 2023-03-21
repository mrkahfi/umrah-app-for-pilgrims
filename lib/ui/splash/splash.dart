import 'dart:async';

import 'package:app_jamaah_boilerplate/constants/assets.dart';
import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/endpoint/endpoint_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:app_jamaah_boilerplate/widgets/app_icon_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserStore _userStore;
  SiteStore _siteStore;
  EndpointStore _endpointStore;

  @override
  void initState() {
    super.initState();
    // SharedPreferences.getInstance().then((prefs) {
    //   if (prefs.getString(Preferences.phoneSite) != null) {
    //     startTimer();
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _siteStore = Provider.of<SiteStore>(context);
    _endpointStore = Provider.of<EndpointStore>(context);
    if (_userStore.userIsEmpty) _userStore.getUser();
    if (!_siteStore.isSiteEmpty) {
      _siteStore.getSites();
    }
    _endpointStore.checkCount();
    // SharedPreferences.getInstance().then((prefs) {
    //   // print('isPhoneSite Empty..........');
    //   if (prefs.getString(Preferences.phoneSite) == null) {
    //     _siteStore.getSites();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(child: AppIconWidget(image: Assets.appLogo)),
          Observer(
            builder: (context) {
              return _siteStore.success
                  ? navigate(context)
                  : _showErrorMessage(_siteStore.errorStore.errorMessage);
            },
          ),
        ],
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      navigatesToHome();
    });
    return Container();
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

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigatesToHome);
  }

  navigatesToHome() async {
    if (_siteStore.loading) {
      return startTimer();
    }
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_endpointStore.totalCount == 1) {
      print("_endpointStore........" + _endpointStore.totalCount.toString());
      if (_endpointStore.endpointIsEmpty) {
        _endpointStore.getEndpoints();
      }
      if (_endpointStore.loading) {
        return startTimer();
      }
      Endpoints.baseUrl = _endpointStore.endpointsApi.domain;
    } else {
      if (_siteStore.branch != null) {
        print("_siteStore........");
        await _endpointStore.changeUrl(_siteStore.branch);
        Endpoints.baseUrl = _siteStore.branch.domain;
        if (_endpointStore.endpointIsEmpty) {
          _endpointStore.getEndpoints();
        }
        if (_endpointStore.loading) {
          return startTimer();
        }
      } else {
        EndpointsAPI endpointsAPI = new EndpointsAPI(
            domain: Endpoints.baseUrl,
            name: GlobalConfiguration().getValue("app_name"));
        await _endpointStore.changeUrl(endpointsAPI);
      }
    }
    Navigator.of(context).pushReplacementNamed(Routes.home);
    // if (preferences.getBool(Preferences.isLoggedIn) ?? false) {
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.home);
    // }
  }
}
