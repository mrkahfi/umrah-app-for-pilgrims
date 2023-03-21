import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'endpoint_store.g.dart';

class EndpointStore = _EndpointStoreBase with _$EndpointStore;

abstract class _EndpointStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _EndpointStoreBase(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------

  static ObservableFuture<EndpointsAPI> emptyEndpointsApiResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<EndpointsAPI> fetchEndpointsApiFuture =
      ObservableFuture<EndpointsAPI>(emptyEndpointsApiResponse);

  @observable
  EndpointsAPI endpointsApi;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool deleted = false;

  @observable
  int totalCount = 0;

  // @computed
  // bool get load => fetchEndpointsApiFuture.status == FutureStatus.pending;

  @computed
  bool get endpointIsEmpty => endpointsApi == null;

  @action
  Future saveEndpoint(EndpointsAPI endpointsAPI) async {
    final future = _repository.insertEndpoint(endpointsAPI);
    return future;
  }

  @action
  Future getEndpoints() async {
    loading = true;
    final future = _repository.getEndpoint();
    fetchEndpointsApiFuture = ObservableFuture(future);

    future.then((endpoint) {
      success = true;
      loading = false;
      this.endpointsApi = endpoint;
    }).catchError((error) async {
      this.endpointsApi = null;
      success = false;
      loading = false;
      await sentry.captureException(
        exception: error,
      );
    });
  }

  @action
  Future checkCount() async {
    final future = _repository.checkCountEndpoint();

    future.then((value) {
      totalCount = value;
      print("........" + value.toString());
    }).catchError((error) async {
      totalCount = 0;
      await sentry.captureException(
        exception: error,
      );
    });
  }

  @action
  Future changeUrl(EndpointsAPI endpointsAPI) async {
    final future = _repository.deleteEndpoint();

    future.then((value) {
      this.deleted = true;
      saveEndpoint(endpointsAPI);
    }).catchError((onError) async {
      this.deleted = false;
      await sentry.captureException(
        exception: onError,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(onError);
    });
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

  // dispose:-------------------------------------------------------------------
  void dispose() {
    success = false;
  }
}
