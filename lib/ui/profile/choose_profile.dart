import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class ChooseProfilePage extends StatefulWidget {
  @override
  _ChooseProfilePageState createState() => _ChooseProfilePageState();
}

class _ChooseProfilePageState extends State<ChooseProfilePage> {
  ProfileStore _profileStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profileStore = Provider.of<ProfileStore>(context);

    if (!_profileStore.profileLoaded) {
      _profileStore.getProfiles();
      _profileStore.getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              "Masuk sebagai siapa?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Futura',
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Menentukan pilihan profil hanya dapat dilakukan di awal. "
                  "Sekali Anda telah menentukan profil, Anda tidak dapat mengganti profil Anda.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Futura',
                    color: Colors.black,
                  ),
                ),
              )),
          SizedBox(
            height: 50,
          ),
          Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: _buildMainContent())),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: new FlatButton(
                      child: new Text(
                        "Masuk",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                      textColor: Colors.white,
                      hoverColor: Colors.blue,
                      splashColor: Colors.blue,
                      disabledTextColor: Colors.grey,
                      highlightColor: Colors.blue,
                      focusColor: Colors.blue,
                      color: Colors.blue,
                      onPressed: () {
                        Profile profile = _profileStore
                            .profileListData[_profileStore.selectedProfile];
                        print("profile..........");
                        print(profile.name);
                        print(profile.slug);
                        setProfileAndBack(
                            profile.name, profile.slug, profile.id);
                        // Alert(
                        //     context: context,
                        //     type: AlertType.warning,
                        //     title: "PERHATIAN",
                        //     desc:
                        //         "Profil hanya dapat dipilih sekali dan tidak dapat diubah. Yakin masuk dengan profil ini?",
                        //     buttons: [
                        //       DialogButton(
                        //         child: Text(
                        //           "TIDAK",
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 20),
                        //         ),
                        //         onPressed: () => Navigator.pop(context),
                        //         color: Colors.grey,
                        //       ),
                        //       DialogButton(
                        //         color: Colors.green,
                        //         child: Text(
                        //           "MASUK",
                        //           style: TextStyle(
                        //               color: Colors.white, fontSize: 20),
                        //         ),
                        //         onPressed: () {
                        //           Profile profile =
                        //               _profileStore.profileListData[
                        //                   _profileStore.selectedProfile];
                        //           print("profile..........");
                        //           print(profile.name);
                        //           print(profile.slug);
                        //           Navigator.pop(context);
                        //           setProfileAndBack(
                        //               profile.name, profile.slug, profile.id);
                        //         },
                        //       )
                        //     ]).show(); //
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0))))),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _profileStore.loading
            ? Center(
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : RefreshIndicator(
                onRefresh: refreshData, child: _buildProfileList());
      },
    );
  }

  Future refreshData() async {
    _profileStore.getProfiles();
  }

  Widget _buildProfileList() {
    return _profileStore.profileListData.length == 0
        ? _navigateProfileListNull()
        : GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: _profileStore.profileListData.length,
            itemBuilder: (BuildContext context, int index) {
              Profile profile = _profileStore.profileListData[index];
              return Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 20),
                child: Observer(builder: (_) {
                  return InkWell(
                    child: new Container(
                      height: 80.0,
                      color: Colors.transparent,
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(20.0))),
                        child: Stack(children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: _profileStore.selectedProfile == index
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(right: 20, bottom: 20),
                                    child: Image.asset(
                                      "assets/images/success.png",
                                      width: 25,
                                      height: 25,
                                    ))
                                : null,
                          ),
                          Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40.0),
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    width: 80,
                                    height: 80,
                                    image: ConvertVar.convertUrlPhoto(
                                        profile.photo.medium.url)),
                              ),
                              SizedBox(width: 30),
                              Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${profile.name}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                ],
                              )),
                            ],
                          )
                        ]),
                      ),
                    ),
                    onTap: () {
                      _profileStore.setSelectedProfile(index);
                    },
                  );
                }),
              );
            },
          );
  }

  Widget _navigateProfileListNull() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(Preferences.profileName, _profileStore.user.name);
      prefs.setString(Preferences.profileSlug, _profileStore.user.slug);
      prefs.setInt(Preferences.profileId, 0);
    });
    Future.delayed(new Duration(milliseconds: 0), () {
      Navigator.pop(context);
    });
    return Container();
  }

  void setProfileAndBack(
      String profileName, String profileSlug, int profileId) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(Preferences.profileName, profileName);
      prefs.setString(Preferences.profileSlug, profileName);
      prefs.setInt(Preferences.profileId, profileId);
    });
    Future.delayed(new Duration(milliseconds: 0), () {
      Navigator.pop(context, true);
    });
  }
}
