import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/models/article/article.dart';
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

import '../dio_client.dart';

class BaseApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  BaseApi(this._dioClient);

  /// Returns of User Login in response
  Future<Users> login(Map<String, dynamic> param) async {
    try {
      final res =
          await _dioClient.post(Endpoints.signinUrl, queryParameters: param);
      return Users.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns of User SignUp in response
  Future<Users> signUp(Map<String, dynamic> param) async {
    try {
      final res =
          await _dioClient.post(Endpoints.signupUrl, queryParameters: param);
      return Users.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns sites of get in response
  Future<Site> getSites() async {
    try {
      final res = await _dioClient.get(Endpoints.getSite);
      return Site.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns listing of get in response
  Future<ListingList> getListings() async {
    try {
      final res = await _dioClient.get(Endpoints.getListing);
      return ListingList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns prayerTime of get in response
  Future<Prayer> getPrayerTime(double lon, double lat) async {
    try {
      final res = await _dioClient.get("https://api.pray.zone/v2/times/today.json?longitude=$lon&latitude=$lat");
      return Prayer.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

   /// Returns surah of get in response
  Future<Surahs> getSurahs() async {
    try {
      final res = await _dioClient.get("https://api.alquran.cloud/v1/surah");
      return Surahs.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns surah by suratId of get in response
  Future<Ayah> getAyahs(int surahId) async {
    try {
      final res = await _dioClient.get("https://api.alquran.cloud/v1/surah/$surahId/ar.alafasy");
      return Ayah.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns surah translation by suratId of get in response
  Future<AyahTrans> getAyahsTranslate(int surahId) async {
    try {
      final res = await _dioClient.get("https://api.alquran.cloud/surah/$surahId/id.indonesian");
      return AyahTrans.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns listingDetail of get in response
  Future<Listing> getListingDetails(int id) async {
    try {
      final res = await _dioClient.get(Endpoints.getListing + "/" + id.toString());
      return Listing.fromJsonShow(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns booking of post invoice in response
  Future<Invoice> postBooking(FormData formData) async {
    try {
      final res = await _dioClient.post(Endpoints.getInvoices, data: formData);
      return Invoice.fromJsonBookingPost(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns galleries of get in response
  Future<GalleryList> getGalleries() async {
    try {
      final res = await _dioClient.get(Endpoints.getGallery);
      return GalleryList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns testimonials of get in response
  Future<GalleryList> getTestimonials() async {
    try {
      final res = await _dioClient.get(Endpoints.getTestimonial);
      return GalleryList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns profiles of get in response
  Future<ProfileList> getProfiles() async {
    try {
      final res = await _dioClient.get(Endpoints.getProfiles);
      return ProfileList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns profiles of get in response
  Future<Profile> getProfile(String slug) async {
    try {
      final res = await _dioClient.get(Endpoints.getProfiles + "/"  + slug);
      return Profile.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns Profiles of update in response
  Future<Profile> updateProfiles(String id, FormData formData) async {
    try {
      final res = await _dioClient.patch(Endpoints.getProfiles + "/" + id, data: formData);
      return Profile.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns inboxes list of get in response
  Future<InboxList> getInboxes() async {
    try {
      final res = await _dioClient.get(Endpoints.getInboxes);
      return InboxList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns inbox of update in response
  Future<Inbox> readInbox(String id, FormData formData) async {
    try {
      final res = await _dioClient.patch(Endpoints.getInboxes + "/" + id, data: formData);
      return Inbox.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns articles of get in response
  Future<ArticleList> getArticles() async {
    try {
      final res = await _dioClient.get(Endpoints.getArticle);
      return ArticleList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns banks of get in response
  Future<BankList> getBanks() async {
    try {
      final res = await _dioClient.get(Endpoints.getBanks);
      return BankList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns invoices of get in response
  Future<InvoiceList> getInvoices() async {
    try {
      final res = await _dioClient.get(Endpoints.getInvoices);
      return InvoiceList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns invoicesDetail of get in response
  Future<Invoice> getInvoicesDetail(String slug) async {
    try {
      final res = await _dioClient.get(Endpoints.getInvoices + "/"  + slug);
      return Invoice.fromJsonIndexShow(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns token Midtrans of get in response
  Future<Midtrans> getTokenMidtrans(String slug) async {
    try {
      final res = await _dioClient.get(Endpoints.getTokenMidtrans + "/"  + slug + "/pay.json");
      return Midtrans.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns of Invoice Payment in response
  Future<Payment> postInvoice(FormData formData) async {
    try {
      final res = await _dioClient.post(Endpoints.postKonfirmasi, data: formData,
          onSendProgress: (int send, int total) {
            print((send / total) * 100);
          });
      return Payment.fromJson(res);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request.headers);
        print(e.message);
      }
      throw e;
    }
  }
}
