import 'package:app_jamaah_boilerplate/models/prayer/prayer.dart';
import 'package:app_jamaah_boilerplate/stores/quran/quran_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/utils/remove_glow.dart';
import 'package:app_jamaah_boilerplate/widgets/base_app.dart';
import 'package:app_jamaah_boilerplate/widgets/base_asset.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ShalatPage extends StatefulWidget {
  @override
  _ShalatPageState createState() => _ShalatPageState();
}

class _ShalatPageState extends State<ShalatPage> {
  var _appBarHeight = 0.0, _statusBarHeight = 0.0;

  QuranStore _quranStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _quranStore = Provider.of<QuranStore>(context);

    if (!_quranStore.loadingPrayer) {
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      _quranStore.lat = position.latitude;
      _quranStore.lat = position.longitude;
      List<Placemark> listPlace =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = listPlace[0];
      _quranStore.curLocation = place.locality;
      _quranStore.curCity = place.subAdministrativeArea;
      _quranStore.getPrayerTime(position.longitude, position.latitude);
      print("Lat... ${position.latitude}");
      print("Lon... ${position.longitude}");
      print("Kota.... ${place.subAdministrativeArea}");
      print("Kec.... ${place.locality}");
    }
  }

  @override
  Widget build(BuildContext context) {
    _statusBarHeight = MediaQuery.of(context).padding.top;
    _appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            // _buildInboxError(),
            _handleErrorMessage(),
            _buildPrayerContent()
          ],
        ),
      );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_quranStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_quranStore.errorStore.errorMessage);
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
          title: "Error",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  Widget _buildPrayerContent() {
    return Observer(builder: (context) {
      return _quranStore.loadingPrayer ? CustomProgressBar() : _buildPrayer();
    });
  }

  Widget _buildPrayer() {
    return !_quranStore.successPrayerLoad
        ? CustomProgressBar()
        : NestedScrollView(
            headerSliverBuilder: (context, scrolling) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    pinned: true,
                    expandedHeight: 260,
                    forceElevated: scrolling,
                    leading: BackButton(color: Colors.white),
                    title: Observer(builder: (_) {
                      return _quranStore.loadingPrayer
                          ? CircularProgressIndicator()
                          : Text(
                              _quranStore.curLocation,
                              style: TextStyle(
                                  color: Colors.white, fontSize: Size.size18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                    }),
                    actions: [
                      // IconButton(
                      //   icon: Icon(
                      //     Icons.sync,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () async {
                      //
                      //     setState(() {
                      //       _pageLoading = true;
                      //       // _getCurrenyLocation();
                      //     });
                      //   },
                      // ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.black),
                          foregroundDecoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(BaseAsset.bgPicture),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: _appBarHeight +
                                  _statusBarHeight +
                                  Size.size24,
                              left: Size.size16,
                              right: Size.size16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Observer(builder: (_) {
                                return _quranStore.loadingPrayer
                                    ? CircularProgressIndicator()
                                    : Text(
                                        _quranStore.curTimePrayer,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 56,
                                            fontWeight: FontWeight.bold),
                                      );
                              }),
                              Observer(builder: (_) {
                                return Visibility(
                                  visible: _quranStore.successPrayerLoad,
                                  child: Text(
                                    'Menuju ${_quranStore.curPrayer}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: Size.size16,
                            left: Size.size16,
                            right: Size.size16,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Func.getTime(Format.time_2),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Size.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Observer(builder: (_) {
                                      return _quranStore.loadingPrayer
                                          ? CircularProgressIndicator()
                                          : Text(
                                              _quranStore.curCity,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Size.size12,
                                              ),
                                            );
                                    }),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    )),
                  ),
                ),
              ];
            },
            body: Stack(
              children: [
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: _appBarHeight),
                  child: ScrollConfiguration(
                      behavior: RemoveGlow(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 7, left: 5, right: 5),
                              child: Row(
                                children: <Widget>[
                                  // Observer(
                                  //   builder: (context) {
                                  //     return Flexible(
                                  //       flex: 1,
                                  //       fit: FlexFit.tight,
                                  //       child: Container(
                                  //           width: 200,
                                  //           height: 40,
                                  //           child: new FlatButton(
                                  //             child: new Text("Surat"),
                                  //             textColor:
                                  //                 _quranStore.selectedButton == 1
                                  //                     ? Colors.white
                                  //                     : Colors.black,
                                  //             color: _quranStore.selectedButton == 1
                                  //                 ? Colors.lightBlueAccent
                                  //                 : Colors.grey[100],
                                  //             onPressed: () =>
                                  //                 _quranStore.setSelectionTab(1),
                                  //             shape: new RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     new BorderRadius.circular(
                                  //                         30.0)),
                                  //           )),
                                  //     );
                                  //   },
                                  // ),
                                  // SizedBox(width: 5),
                                  // Observer(
                                  //   builder: (context) {
                                  //     return Flexible(
                                  //       flex: 1,
                                  //       fit: FlexFit.tight,
                                  //       child: Container(
                                  //           width: 200,
                                  //           height: 40,
                                  //           child: new FlatButton(
                                  //             child: new Text("Tersimpan"),
                                  //             textColor:
                                  //                 _quranStore.selectedButton == 2
                                  //                     ? Colors.white
                                  //                     : Colors.black,
                                  //             color: _quranStore.selectedButton == 2
                                  //                 ? Colors.lightBlueAccent
                                  //                 : Colors.grey[100],
                                  //             onPressed: () {
                                  //               _quranStore.getBookmarkList();
                                  //               _quranStore.setSelectionTab(2);
                                  //             },
                                  //             shape: new RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     new BorderRadius.circular(
                                  //                         30.0)),
                                  //           )),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              )),
                          Expanded(
                            child: Observer(builder: (_) {
                              return _quranStore.loadingPrayer
                                  ? Center(
                                      child: SpinKitWave(
                                        color: Colors.blue[300],
                                        type: SpinKitWaveType.center,
                                        size: 30,
                                      ),
                                    )
                                  : _prayerItemCard(
                                      _quranStore.prayer.results.datetime[0]);
                              // : ListView.builder(
                              //     physics: BouncingScrollPhysics(),
                              //     itemCount: _quranStore.prayer.results.datetime.length,
                              //     itemBuilder: (context, index) => _prayerItemCard(_quranStore.prayer.results.datetime[0]),
                              //   );
                            }),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
  }

  Widget _prayerItemCard(Datetime datetime) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(
          width: 380,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(BaseAsset.shubuh),
                title: Text("Shubuh"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${datetime.times.fajr}"),
                    IconButton(icon: Icon(Icons.notifications), onPressed: null)
                  ],
                ),
              ),
              ListTile(
                leading: Image.asset(BaseAsset.dhuhur),
                title: Text("Dhuhr"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${datetime.times.dhuhr}"),
                    IconButton(icon: Icon(Icons.notifications), onPressed: null)
                  ],
                ),
              ),
              ListTile(
                leading: Image.asset(BaseAsset.ashar),
                title: Text("Ashr"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${datetime.times.asr}"),
                    IconButton(icon: Icon(Icons.notifications), onPressed: null)
                  ],
                ),
              ),
              ListTile(
                leading: Image.asset(BaseAsset.magrib),
                title: Text("Maghrib"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${datetime.times.maghrib}"),
                    IconButton(icon: Icon(Icons.notifications), onPressed: null)
                  ],
                ),
              ),
              ListTile(
                leading: Image.asset(BaseAsset.isya),
                title: Text("Isha"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${datetime.times.isha}"),
                    IconButton(icon: Icon(Icons.notifications), onPressed: null)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
