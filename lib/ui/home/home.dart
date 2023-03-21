import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/article/article.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/gallery/gallery.dart';
import 'package:app_jamaah_boilerplate/models/listing/listing.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/article/article_store.dart';
import 'package:app_jamaah_boilerplate/stores/endpoint/endpoint_store.dart';
import 'package:app_jamaah_boilerplate/stores/gallery/gallery_store.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:app_jamaah_boilerplate/ui/inbox/inbox.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/ui/profile/profile_home.dart';
import 'package:app_jamaah_boilerplate/utils/alert_dialog/alert_dialog.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/fab_bottom_app_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/flexible_card_widget.dart';
import 'package:app_jamaah_boilerplate/widgets/marquee_widget.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform =
      const MethodChannel("com.example.app_jamaah_boilerplate.channel");

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    var item = 0;
    (list.length > 5)
        ? item = 5
        : (list.length < 5)
            ? item = list.length
            : item = 0;
    for (var i = 0; i < item; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  //stores:---------------------------------------------------------------------
  ListingStore _listingStore;
  GalleryStore _galleryStore;
  ArticleStore _articleStore;
  EndpointStore _endpointStore;
  SiteStore _siteStore;
  UserStore _userStore;
  int _selectedIndex = 0;
  bool profileLoaded = false;
  PageController _tabController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = PageController();

    setState(() {
      print("getAuthToken from initState");
      SharedPreferences.getInstance().then((prefs) {
        print('isLoggedIn Home..........');
        print(prefs.getBool(Preferences.isLoggedIn));
        if (prefs.getBool(Preferences.isLoggedIn) ?? false) {
          getMyProfile();
        }
      });
    });
    platform.setMethodCallHandler(_handleMethod);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _listingStore = Provider.of<ListingStore>(context);
    _articleStore = Provider.of<ArticleStore>(context);
    _galleryStore = Provider.of<GalleryStore>(context);
    _endpointStore = Provider.of<EndpointStore>(context);
    _siteStore = Provider.of<SiteStore>(context);
    _userStore = Provider.of<UserStore>(context);

    // if (_inboxStore.isInboxEmpty) {
    //   _inboxStore.getInboxes();
    // }

    _userStore.isLoggedIn();

    // check to see if already called api
    if (_listingStore.isListingEmpty &&
        _articleStore.isArticleEmpty &&
        _galleryStore.isGalleryEmpty) {
      _listingStore.getListings();
      _galleryStore.getGalleries();
      _articleStore.getArticles();
    }

    if (_endpointStore.endpointsApi == null) {
      print("endpoint home........");
      _endpointStore.getEndpoints();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
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
                  _buildTitleAppBar(context),
                  Expanded(child: _buildBody(context))
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 0),
          child: SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                var phoneWa = prefs.getString(Preferences.phoneSite);
                FlutterOpenWhatsapp.sendSingleMessage(phoneWa,
                    "Assalamu\'alaikum, dapat nomernya dari ${Endpoints.protocol}${Endpoints.baseUrl} \n Mau tanya soal umroh");
              },
              child: Container(
                height: 75,
                width: 75,
                child: Image.asset("assets/images/wa.png"),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: FABBottomAppBar(
          color: Colors.grey,
          selectedColor: Colors.blue,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: (index) {
            SharedPreferences.getInstance().then((prefs) {
              if (prefs.getBool(Preferences.isLoggedIn) ?? false) {
                setState(() {
                  _selectedIndex = index;
                  _tabController.jumpToPage(index);
                });
              } else {
                if (index != 0)
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
          },
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Beranda'),
            FABBottomAppBarItem(
                iconData: Icons.notifications, text: 'Notifikasi'),
            FABBottomAppBarItem(iconData: Icons.receipt, text: 'Pesanan'),
            FABBottomAppBarItem(iconData: Icons.person, text: 'Profile'),
          ],
        ));
  }

  void getMyProfile() async {
    if (profileLoaded) return;

    _userStore.isLoggedIn();

    setState(() {
      _buildIfNotLogin();
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileName = prefs.getString(Preferences.profileName);
    String profileSlug = prefs.getString(Preferences.profileSlug);
    int profileId = prefs.getInt(Preferences.profileId);

    if (profileName != null && profileSlug != null && profileId != null) {
      print("getMyProfile $profileName $profileSlug $profileId");
      //     initPlatformState();

      //     Map<String, String> dataUser = HashMap<String, String>();
      //     dataUser["profile[firebase_token]"] = prefs.getString("firebase_token");

      //     print("updating firebaseTOken " + prefs.getString("firebase_token"));
      //     updateProfile(profileId, dataUser, _user.auth_token);

      profileLoaded = true;
    } else {
      Future.delayed(new Duration(milliseconds: 100), () {
        goToChooseProfilePage();
      });
    }
  }

  void goToChooseProfilePage() async {
    var results = await Navigator.of(context).pushNamed(Routes.chooseProfile);

    if (results != null && results) {
      print("back from goToChooseProfilePage ");
      getMyProfile();
    }
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 8, right: 8),
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: AppBar().preferredSize.height + 20,
                height: AppBar().preferredSize.height,
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  color: Colors.transparent,
                  child: Image.asset("assets/images/logo_mp.png"),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildIfNotLogin() {
    return _siteStore.branch != null
        ? _userStore.isLogin
            ? Container()
            : _buildDropdownBranchInfo()
        : Container();
  }

  Widget _buildDropdownBranchInfo() {
    return Container(
      margin: EdgeInsets.only(right: 3),
      child: Material(
        elevation: 0,
        child: InkWell(
          onTap: () {
            _buildBranchDialog();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(builder: (_) {
                return _endpointStore.endpointsApi == null
                    ? CircularProgressIndicator()
                    : Container(
                        margin: EdgeInsets.only(left: 10, right: 3),
                        width: MediaQuery.of(context).size.width * .20,
                        child:
                            Text("Cabang \n${_endpointStore.endpointsApi.name}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                      );
              }),
              Container(
                margin: EdgeInsets.only(right: 3),
                child: Icon(
                  FontAwesomeIcons.angleDoubleDown,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranchButtonInfo() {
    return Container(
        margin: EdgeInsets.only(right: 3),
        child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 3),
                      width: MediaQuery.of(context).size.width * .25,
                      child: Text(
                          "Anda berada di ${_endpointStore.endpointsApi.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12,
                          ))),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: _buildChangeBranchButton(),
                  )
                ])));
  }

  Widget _buildChangeBranchButton() {
    return RoundedButtonWidget(
        buttonText: "Ubah",
        buttonColor: Color(0xff03b4fd),
        textColor: Colors.white,
        onPressed: () async {
          _buildBranchDialog();
        });
  }

  _buildBranchDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          "Pilih Lokasi Cabang",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _siteStore.site.branchs
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.name,
                  style: TextStyle(
                    color: _endpointStore.endpointsApi.domain == object.domain
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change endpoints based on selected
                  EndpointsAPI endpointsAPI = new EndpointsAPI(
                      domain: object.domain, name: object.name);
                  _endpointStore.changeUrl(endpointsAPI);
                  _endpointStore.changeAllEndpoints(object.domain);
                  _listingStore.listingListData.clear();
                  _galleryStore.galleryListData.clear();
                  _galleryStore.galleryListSelected.clear();
                  _galleryStore.galleryListTestimonial.clear();
                  _articleStore.articleListData.clear();
                  _listingStore.getListings();
                  _galleryStore.getGalleries();
                  _galleryStore.getTestimonials();
                  _articleStore.getArticles();
                  _galleryStore.setSelectionTab(1);
                  setState(() {
                    _endpointStore.endpointsApi.domain = object.domain;
                    _endpointStore.endpointsApi.name = object.name;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  Widget _buildTitleAppBar(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        return Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 8, right: 8),
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: AppBar().preferredSize.height + 20,
                    height: AppBar().preferredSize.height,
                    margin: EdgeInsets.only(left: 10),
                    child: Container(
                      color: Colors.transparent,
                      child: Image.asset("assets/images/logo_mp.png"),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  _buildIfNotLogin()
                ],
              ),
            ));
        break;
      case 1:
        return Container();
        break;
      case 2:
        return Container();
        break;
      case 3:
        return Container(
            width: AppBar().preferredSize.height + 20,
            height: AppBar().preferredSize.height,
            margin: EdgeInsets.only(top: 15, bottom: 0),
            alignment: Alignment.center,
            child: Center(child: Padding(padding: EdgeInsets.only(top: 20))));
        break;
      default:
        return Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(top: 45, bottom: 10),
            alignment: Alignment.topLeft,
            child: Center(child: Text("")));
    }
  }

  Widget _buildBody(BuildContext context) {
    return PageView(
      physics: _userStore.isLogin ? null : NeverScrollableScrollPhysics(),
      controller: _tabController,
      onPageChanged: (value) => _onItemTapped(value),
      children: <Widget>[
        RefreshIndicator(
            onRefresh: refreshData, child: _buildHomeMainContent(context)),
        InboxPage(),
        InvoicePage(),
        ProfilePage(),
      ],
    );
  }

  Future refreshData() async {
    _listingStore.getListings();
    _galleryStore.getGalleries();
    _articleStore.getArticles();
  }

  Widget _buildHomeMainContent(BuildContext context) {
    return ListView(
      children: [
        _buildHomeTitleSearchBar(),
        // ListingUI(),
        _buildListingListContent(),
        _buildMenu(context),
        // GalleryUI(),
        _buildGalleryListContent(),
        // ArticleUI(),
        _buildArticleListContent()
      ],
    );
  }

  Widget _buildListingListContent() {
    return Observer(
      builder: (context) {
        return _listingStore.loading && _listingStore.isListingEmpty
            ? Center(
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : Material(child: _buildListing());
      },
    );
  }

  Widget _buildGalleryListContent() {
    return Observer(
      builder: (context) {
        return _galleryStore.loading && _galleryStore.isGalleryEmpty
            ? Center(
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : Material(child: _buildGallery());
      },
    );
  }

  Widget _buildArticleListContent() {
    return Observer(
      builder: (context) {
        return _articleStore.loading && _articleStore.isArticleEmpty
            ? Center(
                child: SpinKitWave(
                  color: Colors.blue[300],
                  type: SpinKitWaveType.center,
                  size: 30,
                ),
              )
            : Material(child: _buildArticles());
      },
    );
  }

  Widget _buildArticles() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Artikel Terbaru",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  child: Text(
                    "Lihat Semua",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.articleIndex);
                  },
                )
              ],
            )),
        SizedBox(
          height: 20,
        ),
        _buildArticleList()
      ],
    );
  }

  Widget _buildArticleList() {
    return _articleStore.isArticleEmpty
        ? Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 50),
            child: Center(
              child: Column(children: <Widget>[
                Image.asset(
                  "assets/images/blank_file.png",
                  height: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Belum ada item",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ))
        : Padding(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _articleStore.isArticleEmpty
                  ? 0
                  : (_articleStore.articleListData.length >= 5)
                      ? 5
                      : _articleStore.articleListData.length,
              itemBuilder: (BuildContext context, int index) {
                Article article = _articleStore.articleListData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    child: Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "${article.pict.url}",
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 130,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${article.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 13,
                                      color: Colors.blueGrey[300],
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "posted by Admin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.articleDetail, arguments: article);
                    },
                  ),
                );
              },
            ),
          );
  }

  Widget _buildGallery() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Gallery",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.galleryIndex);
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildCorouselGalleryList()
      ],
    );
  }

  Widget _buildCorouselGalleryList() {
    return _galleryStore.isGalleryEmpty
        ? Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Center(
              child: Column(children: <Widget>[
                Image.asset(
                  "assets/images/blank_file.png",
                  height: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Belum ada item",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ))
        : Column(children: [
            CarouselSlider.builder(
              itemCount: _galleryStore.galleryListData.length,
              options: CarouselOptions(
                  autoPlay: true,
                  height: 180,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    int current = (index > 5) ? 5 : index;
                    _galleryStore.setCurrentDotIndicator(current);
                  }),
              itemBuilder: (context, index) {
                Gallery item = _galleryStore.galleryListData[index];
                return GestureDetector(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: item.pict.url,
                              fit: BoxFit.cover,
                              width: 900.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                '${item.caption}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.galleryDetail,
                        arguments: item.pict.url);
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  map<Widget>(_galleryStore.galleryListData, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _galleryStore.indicatorCurrent == index
                        ? Colors.blue[400]
                        : Colors.blueGrey[200].withOpacity(0.3),
                  ),
                );
              }),
            )
          ]);
  }

  Widget _buildListing() {
    return _listingStore.isListingEmpty
        ? Container(
            padding: EdgeInsets.only(top: 15, left: 5, right: 5),
            child: Center(
              child: Column(children: <Widget>[
                Image.asset(
                  "assets/images/blank_file.png",
                  height: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Belum ada item",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                )
              ]),
            ))
        : Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            height: 320,
            child: ListView.builder(
                itemCount: _listingStore.listingListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Listing listing = _listingStore.listingListData[index];
                  if (index == _listingStore.listingListData.length - 1 &&
                      index != null)
                    return _otherListing();
                  else
                    return _listingCard(listing);
                }));
  }

  Widget _otherListing() {
    return GestureDetector(
      child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: Colors.blueGrey[300].withOpacity(0.02),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                child: Image.asset("assets/images/more.png"),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Lihat Semua",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.listingIndex);
      },
    );
  }

  Widget _listingCard(Listing listing) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: InkWell(
          child: Container(
            width: 220,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          ConvertVar.convertUrlPhoto(listing.pict.medium.url),
                      height: 120,
                      width: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "${listing.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.event_note,
                          size: 16,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Berangkat ${ConvertVar.dateToConvert(listing.departureAt, "dd MMM yyyy")}",
                          style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Paket ${listing.days} Hari",
                          style: TextStyle(
                              color: Colors.blueGrey[300],
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.hotel,
                          size: 16,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        RatingBar(
                          initialRating: listing.hotelStar.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: Colors.blueGrey[200],
                          itemSize: 14,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.airline_seat_recline_normal,
                          size: 16,
                          color: Colors.blueGrey[300],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        (listing.availableSeats <= 10)
                            ? Text(
                                "Tersisa ${listing.availableSeats} Kursi",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )
                            : Text(
                                "Tersisa ${listing.availableSeats} Kursi",
                                style: TextStyle(
                                    color: Colors.blueGrey[300],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                      padding: EdgeInsets.only(left: 12, bottom: 8),
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.blueGrey[300],
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                            children: [
                              TextSpan(text: "Mulai "),
                              TextSpan(
                                  text: (listing.currency == "IDR")
                                      ? "${ConvertVar.toSimbolCurrency(listing.currency)} ${ConvertVar.toDecimalMilion(listing.priceStart)} juta"
                                      : "${ConvertVar.toSimbolCurrency(listing.currency)} ${ConvertVar.toDecimal(listing.priceStart)}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ]),
                      )),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.listingDetail, arguments: listing.id);
          },
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Column(
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
      ],
    );
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
          isCard: true,
          callback: () => _navigate(Routes.quran),
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 8,
              ),
              new ImageIcon(AssetImage("assets/images/qurann.png"),
                  size: 48, color: const Color(0xFF0b99ff)),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: 70,
                child: Text(
                  "Al-Qur'an",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 16.0, fontFamily: "NeoSansStdMediumTR"),
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
          isCard: true,
          callback: () {
            _navigate(Routes.invoice);
          },
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
          isCard: true,
          callback: () {
            // _navigate(Routes.radio);
            // _showNativeView();
          },
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

  Future<Null> _showNativeView() async {
    await platform.invokeMethod("showNativeView");
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case "message":
        debugPrint(call.arguments);
        print("_message ${call.arguments}");
        return new Future.value("");
    }
  }

  Widget _buildMenuCardRowSecond(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        FlexibleCardWidget(
          isCard: true,
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
          isCard: true,
          callback: () {
            // _navigate(Routes.quran);
          },
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
          callback: () => Navigator.of(context).pushNamed(Routes.allMenu),
          isCard: true,
          column: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              new Icon(Icons.apps, size: 48, color: const Color(0xFF0b99ff)),
              new Text(
                'Semua Fitur',
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

  Widget _buildHomeTitleSearchBar() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0)),
                  Text(
                    "Paket Umroh",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MarqueeWidget(
                    child: Text(
                      "Nikmati kemudahan ibadah umrah Anda",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 5),
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    heroTag: "search",
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.search);
                    },
                    child: Icon(Icons.search, color: Colors.white),
                    splashColor: Colors.white,
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
