import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/article/article.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/gallery/gallery.dart';
import 'package:app_jamaah_boilerplate/models/inbox/inbox.dart';
import 'package:app_jamaah_boilerplate/models/invoice/bank.dart';
import 'package:app_jamaah_boilerplate/models/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/models/listing/listing.dart';
import 'package:app_jamaah_boilerplate/models/payment/payment.dart';
import 'package:app_jamaah_boilerplate/models/prayer/prayer.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';
import 'package:app_jamaah_boilerplate/models/quran/ayah.dart';
import 'package:app_jamaah_boilerplate/models/quran/ayah_translate.dart';
import 'package:app_jamaah_boilerplate/models/quran/surah.dart';
import 'package:app_jamaah_boilerplate/models/site/site.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:dio/dio.dart';
import 'local/datasources/user_datasource.dart';
import 'network/apis/base_api.dart';

class Repository {
  // data source user object
  final UserDataSource _userDataSource;

  // api baseApi objects
  final BaseApi _baseApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._baseApi, this._sharedPrefsHelper, this._userDataSource);

  //  // User Login: ---------------------------------------------------------------------
  Future<Users> login(Map<String, dynamic> param) async {
    // check to see if users are present in database, then fetch from database
    // else make a network call to get all users, store them into database for
    // later use
    return _baseApi.login(param).then((user) {
      _userDataSource.insertSession(user);
      _sharedPrefsHelper.saveAuthToken(user.authToken);
      return user;
    }).catchError((error) => throw error);
  }

  //  // User signUp: ---------------------------------------------------------------------
  Future<Users> signUp(Map<String, dynamic> param) async {
    // check to see if users are present in database, then fetch from database
    // else make a network call to get all users, store them into database for
    // later use
    return _baseApi.signUp(param).then((user) {
      _userDataSource.insertSession(user);
      _sharedPrefsHelper.saveAuthToken(user.authToken);
      return user;
    }).catchError((error) => throw error);
  }

  // Site: ---------------------------------------------------------------------
  Future<Site> getSites() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getSites().then((site) {
      var phone = site.phone;
      if (phone.startsWith('08')) {
        var wa = phone.replaceFirst(RegExp('0'), '62');
        _sharedPrefsHelper.savePhoneSite(wa);
        print('hello $wa');
      }
      return site;
    }).catchError((error) => throw error);
  }

  // Listing: ---------------------------------------------------------------------
  Future<ListingList> getListings() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getListings().then((listingsList) {
      return listingsList;
    }).catchError((error) => throw error);
  }

  // PrayerTime https://api.pray.zone/v2/times/today.json?city=Surakarta: ---------------------------------------------------------------------
  Future<Prayer> getPrayerTime(double lon, double lat) async {
    // check to see if PrayerTime are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getPrayerTime(lon, lat).then((prayer) {
      return prayer;
    }).catchError((error) => throw error);
  }

  // Surah https://alquran.cloud/api: ---------------------------------------------------------------------
  Future<Surahs> getSurahs() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getSurahs().then((surahs) {
      return surahs;
    }).catchError((error) => throw error);
  }

  // Surah by number https://alquran.cloud/api: ---------------------------------------------------------------------
  Future<Ayah> getAyahs(int surahId) async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getAyahs(surahId).then((ayahs) {
      return ayahs;
    }).catchError((error) => throw error);
  }

  // Surah by tranlation https://alquran.cloud/api: ---------------------------------------------------------------------
  Future<AyahTrans> getAyahsTranslate(int surahId) async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getAyahsTranslate(surahId).then((ayahs) {
      return ayahs;
    }).catchError((error) => throw error);
  }

  // ListingDetail: ---------------------------------------------------------------------
  Future<Listing> getListingDetails(int id) async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getListingDetails(id).then((listing) {
      return listing;
    }).catchError((error) => throw error);
  }

  // Article: ---------------------------------------------------------------------
  Future<ArticleList> getArticles() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getArticles().then((articlesList) {
      return articlesList;
    }).catchError((error) => throw error);
  }

  // Galleries: ---------------------------------------------------------------------
  Future<GalleryList> getGalleries() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getGalleries().then((galleriesList) {
      return galleriesList;
    }).catchError((error) => throw error);
  }

  // Testimonials: ---------------------------------------------------------------------
  Future<GalleryList> getTestimonials() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getTestimonials().then((galleriesList) {
      return galleriesList;
    }).catchError((error) => throw error);
  }

  // Profiles: ---------------------------------------------------------------------
  Future<ProfileList> getProfiles() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getProfiles().then((profileList) {
      return profileList;
    }).catchError((error) => throw error);
  }

  // Profiles: ---------------------------------------------------------------------
  Future<Profile> getProfile(String slug) async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getProfile(slug).then((profile) {
      return profile;
    }).catchError((error) => throw error);
  }

  // Update Profiles: ---------------------------------------------------------------------
  Future<Profile> updateProfiles(String id, FormData param) async {
    return _baseApi
        .updateProfiles(id, param)
        .then((profile) => profile)
        .catchError((error) => throw error);
  }

  // Inboxes List: ---------------------------------------------------------------------
  Future<InboxList> getInboxes() async {
    return _baseApi
        .getInboxes()
        .then((inboxList) => inboxList)
        .catchError((error) => throw error);
  }

  // Update inbox to read: ---------------------------------------------------------------------
  Future<Inbox> readInbox(String id, FormData param) async {
    return _baseApi
        .readInbox(id, param)
        .then((inbox) => inbox)
        .catchError((error) => throw error);
  }

  // Banks: ---------------------------------------------------------------------
  Future<BankList> getBanks() async {
    // check to see if listings are present in database, then fetch from database
    // else make a network call to get all listings, store them into database for
    // later use
    return _baseApi.getBanks().then((banksList) {
      return banksList;
    }).catchError((error) => throw error);
  }

  // Booking : ---------------------------------------------------------------------
  Future<Invoice> bookingNow(FormData param) async {
    // check to see if admins are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _baseApi.postBooking(param).then((invoice) {
      return invoice;
    }).catchError((error) => throw error);
  }

  // User Session: ---------------------------------------------------------------------
  Future<Users> getUser() async {
    // check to see if admins are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _userDataSource
        .getUserFromDb()
        .then((user) => user)
        .catchError((error) => throw error);
  }

  // User Delete Session: ------------------------------------------------------
  Future<int> deleteUser(Users user) async {
    return _userDataSource.delete(user).then((id) {
      _sharedPrefsHelper.removeAuthToken();
      _sharedPrefsHelper.removeProfileName();
      _sharedPrefsHelper.removeProfileSlug();
      _sharedPrefsHelper.removeProfileId();
      return id;
    }).catchError((error) => throw error);
  }

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;
  Future<String> get getAuthToken => _sharedPrefsHelper.authToken;

  // Invoices: ---------------------------------------------------------------------
  Future<InvoiceList> getInvoices() async {
    return _baseApi
        .getInvoices()
        .then((invoiceList) => invoiceList)
        .catchError((error) => throw error);
  }

  // InvoicesDetail: ---------------------------------------------------------------------
  Future<Invoice> getInvoicesDetail(String slug) async {
    return _baseApi
        .getInvoicesDetail(slug)
        .then((invoice) => invoice)
        .catchError((error) => throw error);
  }

  // Midtrans: ---------------------------------------------------------------------
  Future<Midtrans> getTokenMidtrans(String slug) async {
    return _baseApi
        .getTokenMidtrans(slug)
        .then((midtrans) => midtrans)
        .catchError((error) => throw error);
  }

  //  // Payment Invoice: ---------------------------------------------------------------------
  Future<Payment> postInvoice(FormData params) async {
    // check to see if admins are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _baseApi.postInvoice(params).then((payment) {
      return payment;
    }).catchError((error) => throw error);
  }

  Future<int> insertSurahBookmark(DataSurah surah) => _userDataSource
      .insertSurah(surah)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<List<DataSurah>> getSurahListBookmark() async {
    // check to see if surahList are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _userDataSource
        .getSurahListFromDb()
        .then((surahList) => surahList)
        .catchError((error) => throw error);
  }

  Future<DataSurah> getSurahBookmark() async {
    // check to see if surah are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _userDataSource
        .getSurahFromDb()
        .then((surah) => surah)
        .catchError((error) => throw error);
  }

  Future<int> deleteSurahBookmark(DataSurah surah) async {
    return _userDataSource.deleteSurah(surah).then((id) {
      return id;
    }).catchError((error) => throw error);
  }

  Future<int> checkCountSurahBookmark() => _userDataSource
      .checkSurah()
      .then((id) => id)
      .catchError((error) => throw error);

   Future<int> insertEndpoint(EndpointsAPI endpointsAPI) => _userDataSource
      .insertEndpoint(endpointsAPI)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<EndpointsAPI> getEndpoint() async {
    // check to see if admins are present in database, then fetch from database
    // else make a network call to get all admins, store them into database for
    // later use
    return _userDataSource
        .getEndpointFromDb()
        .then((endpoint) => endpoint)
        .catchError((error) => throw error);
  }

  Future deleteEndpoint() =>
      _userDataSource.deleteSessionEndpoint().catchError((error) => throw error);

  Future<int> checkCountEndpoint() => _userDataSource
      .checkEndpoint()
      .then((id) => id)
      .catchError((error) => throw error);
}
