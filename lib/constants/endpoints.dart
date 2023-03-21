import 'package:global_configuration/global_configuration.dart';

class Endpoints {
  Endpoints._();

    // base url
  static String baseUrl = "${GlobalConfiguration().getValue("url_prod")}";
  static String protocol = "https://";

  // receiveTimeout
  static const int receiveTimeout = 60*1000;

  // connectTimeout
  static const int connectionTimeout = 60*1000;

  // listing
  static String getListing = protocol + baseUrl + "/api/listings";

  // gallery
  static String getGallery = protocol + baseUrl + "/api/galleries";

  // testimonial
  static String getTestimonial = protocol + baseUrl + "/api/testimonials";

  // article
  static String getArticle = protocol + baseUrl + "/api/articles";

  // listingDetail
  static String getListingDetail = protocol + baseUrl + "/user_api/listings/";

  // user SignIn
  static String signinUrl = protocol + baseUrl + "/user_api/sign-in.json";

  // user Register
  static String signupUrl = protocol + baseUrl + "/user_api/signup.json";

  // user Update
  static String updateUser = protocol + baseUrl + "/user_api/users/";
  
  // site
  static String getSite = protocol + baseUrl + "/api/sites.json";

  // bank
  static String getBanks = protocol + baseUrl + "/api/banks.json";

  // fee
  static String getFee = protocol + baseUrl + "/user_api/my_fee.json";

  // invoice
  static String getInvoices = protocol + baseUrl + "/user_api/invoices";

  // midtrans pay
  static String getTokenMidtrans = protocol + baseUrl + "/user_api/invoices_payments";

  // profiles
  static String getProfiles = protocol + baseUrl + "/user_api/profiles";

  // inbox
  static String getInboxes = protocol + baseUrl + "/user_api/inboxes";

  // konfirmasi
  static String postKonfirmasi = protocol + baseUrl + "/user_api/invoices_payments.json";
}
