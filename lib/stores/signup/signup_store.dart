import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'signup_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  // store for handling signup errors

  Repository _repository;

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  static ObservableFuture<Users> emptyUserResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Users> fetchUserFuture =
      ObservableFuture<Users>(emptyUserResponse);

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _SignUpStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  @observable
  String email = '';

  @observable
  String fullname = '';

  @observable
  String phone = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  Users user;

  @observable
  EndpointsAPI branch;

  @action
  void setBranch(value) => branch = value;

  @computed
  bool get canSignUp => email != '' && fullname != '' && phone != '';

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value;
  }

  // actions:-------------------------------------------------------------------
  @action
  void setFullname(String value) {
    fullname = value;
  }

  // actions:-------------------------------------------------------------------
  @action
  void setPhone(String value) {
    phone = value;
  }

  // actions:-------------------------------------------------------------------
  @action
  Future signUp() async {
    loading = true;

    if(branch != null){
      changeAllEndpoints(branch.domain);
      // Endpoints.signinUrl = Endpoints.protocol + branch.domain + "/admin_api/sign-in.json";
    }

    final future = _repository.signUp(
        {"user[phone]": phone, "user[email]": email, "user[name]": fullname});
    fetchUserFuture = ObservableFuture(future);

    future.then((user) {
      loading = false;
      success = true;
      this.user = user;
      if(branch != null){
        _repository.insertEndpoint(branch);
      }
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  void dispose() {
    fullname = '';
    email = '';
    phone = '';
    user = null;
    success = false;
  }

  void changeAllEndpoints(String domain) {
    Endpoints.baseUrl = domain;
    // listing
    Endpoints.getListing = Endpoints.protocol + domain + "/api/listings";

    // gallery
    Endpoints.getGallery = Endpoints.protocol + domain + "/api/galleries";

    // testimonial
    Endpoints.getTestimonial =
        Endpoints.protocol + domain + "/api/testimonials";

    // article
    Endpoints.getArticle = Endpoints.protocol + domain + "/api/articles";

    // listingDetail
    Endpoints.getListingDetail =
        Endpoints.protocol + domain + "/user_api/listings/";

    // user SignIn
    Endpoints.signinUrl =
        Endpoints.protocol + domain + "/user_api/sign-in.json";

    // user Register
    Endpoints.signupUrl = Endpoints.protocol + domain + "/user_api/signup.json";

    // user Update
    Endpoints.updateUser = Endpoints.protocol + domain + "/user_api/users/";

    // site
    Endpoints.getSite = Endpoints.protocol + domain + "/api/sites.json";

    // bank
    Endpoints.getBanks = Endpoints.protocol + domain + "/api/banks.json";

    // fee
    Endpoints.getFee = Endpoints.protocol + domain + "/user_api/my_fee.json";

    // invoice
    Endpoints.getInvoices = Endpoints.protocol + domain + "/user_api/invoices";

    // profiles
    Endpoints.getProfiles = Endpoints.protocol + domain + "/user_api/profiles";

    // inbox
    Endpoints.getInboxes = Endpoints.protocol + domain + "/user_api/inboxes";

    // konfirmasi
    Endpoints.postKonfirmasi =
        Endpoints.protocol + domain + "/user_api/invoices_payments.json";
  }
}
