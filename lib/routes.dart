
import 'package:app_jamaah_boilerplate/ui/booking/add_jamaah.dart';
import 'package:app_jamaah_boilerplate/ui/booking/booking.dart';
import 'package:app_jamaah_boilerplate/ui/booking/booking_detail.dart';
import 'package:app_jamaah_boilerplate/ui/booking/confirm_booking.dart';
import 'package:app_jamaah_boilerplate/ui/family/family.dart';
import 'package:app_jamaah_boilerplate/ui/home/all_menu.dart';
import 'package:app_jamaah_boilerplate/ui/home/article/article_detail.dart';
import 'package:app_jamaah_boilerplate/ui/home/article/article_index.dart';
import 'package:app_jamaah_boilerplate/ui/home/gallery/gallery_detail.dart';
import 'package:app_jamaah_boilerplate/ui/home/gallery/gallery_index.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_detail.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_index.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_info_airline.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_info_bus.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_info_hotel.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_info_itinerary.dart';
import 'package:app_jamaah_boilerplate/ui/home/listing/listing_info_price.dart';
import 'package:app_jamaah_boilerplate/ui/inbox/inbox.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice_confirm.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice_detail.dart';
import 'package:app_jamaah_boilerplate/ui/invoice/invoice_form.dart';
import 'package:app_jamaah_boilerplate/ui/login/login.dart';
import 'package:app_jamaah_boilerplate/ui/manasik/manasik.dart';
import 'package:app_jamaah_boilerplate/ui/manasik/sai.dart';
import 'package:app_jamaah_boilerplate/ui/manasik/thawaf.dart';
import 'package:app_jamaah_boilerplate/ui/profile/choose_profile.dart';
import 'package:app_jamaah_boilerplate/ui/profile/form_edit/profiles_form_contact.dart';
import 'package:app_jamaah_boilerplate/ui/profile/form_edit/profiles_form_document.dart';
import 'package:app_jamaah_boilerplate/ui/profile/form_edit/profiles_form_family.dart';
import 'package:app_jamaah_boilerplate/ui/profile/form_edit/profiles_form_self.dart';
import 'package:app_jamaah_boilerplate/ui/profile/form_edit/profiles_form_status.dart';
import 'package:app_jamaah_boilerplate/ui/profile/profiles.dart';
import 'package:app_jamaah_boilerplate/ui/quran/quran.dart';
import 'package:app_jamaah_boilerplate/ui/quran/quran_detail.dart';
import 'package:app_jamaah_boilerplate/ui/radio/radio.dart';
import 'package:app_jamaah_boilerplate/ui/search/search.dart';
import 'package:app_jamaah_boilerplate/ui/shalat/shalat.dart';
import 'package:app_jamaah_boilerplate/ui/signup/signup.dart';
import 'package:flutter/material.dart';
import 'ui/home/home.dart';
import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String search = '/search';
  static const String invoice = '/invoice';
  static const String chooseProfile = '/choose_profile';
  static const String allMenu = '/all_menu';
  static const String signup = '/signup';
  // static const String success = '/success';
  static const String booking = '/booking';
  static const String confirmBooking = '/confirm_booking';
  static const String inbox = '/inbox';
  static const String profiles = '/profiles';
  static const String profilesFormSelf = '/profiles_form_self';
  static const String profilesFormContact = '/profiles_form_contact';
  static const String profilesFormFamily = '/profiles_form_family';
  static const String profilesFormDocument = '/profiles_form_document';
  static const String profilesFormStatus = '/profiles_form_status';
  static const String addJamaah = '/add_jamaah';
  static const String invoiceForm = '/invoice_form';
  static const String invoiceConfirm = '/invoice_confirm';
  static const String invoiceDetail = '/invoice_detail';
  static const String bookingDetail = '/booking_detail';
  static const String radio = '/radio';
  static const String quran = '/quran';
  static const String quranDetail = '/quran_detail';
  static const String family = '/family';
  static const String manasik = '/manasik';
  static const String sai = '/sai';
  static const String thawaf = '/thawaf';
  static const String shalat = '/shalat';
  static const String articleDetail = '/article_detail';
  static const String listingDetail = '/listing_detail';
  static const String galleryDetail = '/gallery_detail';
  static const String articleIndex = '/article_index';
  static const String listingIndex = '/listing_index';
  static const String galleryIndex = '/gallery_index';
  static const String listingInfoPrice = '/listing_info_price';
  static const String listingInfoItinerary = '/listing_info_itinerary';
  static const String listingInfoHotel = '/listing_info_hotel';
  static const String listingInfoAirline = '/listing_info_airline';
  static const String listingInfoBus = '/listing_info_bus';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashPage(),
    home: (BuildContext context) => HomePage(),
    search: (BuildContext context) => SearchPage(),
    login: (BuildContext context) => LoginPage(),
    invoice: (BuildContext context) => InvoicePage(),
    chooseProfile: (BuildContext context) => ChooseProfilePage(),
    allMenu: (BuildContext context) => AllMenuPage(),
    signup: (BuildContext context) => SignUpPage(),
    // success: (BuildContext context) => SuccessScreen(),
    booking: (BuildContext context) => BookingPage(),
    confirmBooking: (BuildContext context) => ConfirmBookingPage(),
    inbox: (BuildContext context) => InboxPage(),
    profiles: (BuildContext context) => ProfilesPage(),
    profilesFormSelf: (BuildContext context) => ProfilesFormSelfPage(),
    profilesFormContact: (BuildContext context) => ProfilesFormContactPage(),
    profilesFormFamily: (BuildContext context) => ProfilesFormFamilyPage(),
    profilesFormDocument: (BuildContext context) => ProfilesFormDocumentPage(),
    profilesFormStatus: (BuildContext context) => ProfilesFormStatusPage(),
    addJamaah: (BuildContext context) => AddJamaahPage(),
    invoiceForm: (BuildContext context) => InvoiceFormPage(),
    invoiceConfirm: (BuildContext context) => InvoiceConfirmPage(),
    invoiceDetail: (BuildContext context) => InvoiceDetailPage(),
    bookingDetail: (BuildContext context) => BookingDetailPage(),
    radio: (BuildContext context) => RadioPage(),
    quran: (BuildContext context) => QuranPage(),
    quranDetail: (BuildContext context) => QuranDetailPage(),
    manasik: (BuildContext context) => ManasikPage(),
    sai: (BuildContext context) => SaiPage(),
    thawaf: (BuildContext context) => ThawafPage(),
    family: (BuildContext context) => FamilyPage(),
    shalat: (BuildContext context) => ShalatPage(),
    listingIndex: (BuildContext context) => ListingIndexPage(),
    galleryIndex: (BuildContext context) => GalleryIndexPage(),
    articleIndex: (BuildContext context) => ArticleIndexPage(),
    listingDetail: (BuildContext context) => ListingDetailPage(),
    galleryDetail: (BuildContext context) => GalleryDetailPage(),
    articleDetail: (BuildContext context) => ArticleDetailPage(),
    listingInfoPrice: (BuildContext context) => ListingInfoPricePage(),
    listingInfoItinerary: (BuildContext context) => ListingInfoIteneraryPage(),
    listingInfoHotel: (BuildContext context) => ListingInfoHotelPage(),
    listingInfoAirline: (BuildContext context) => ListingInfoAirlinePage(),
    listingInfoBus: (BuildContext context) => ListingInfoBusPage(),
  };
}