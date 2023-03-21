import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/site/site.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'site_store.g.dart';

class SiteStore = _SiteStoreBase with _$SiteStore;

abstract class _SiteStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _SiteStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Site> emptySiteResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Site> fetchSitesFuture =
      ObservableFuture<Site>(emptySiteResponse);

  @observable
  Site site;

  @observable
  EndpointsAPI branch;

  @observable
  bool success = false;

  @computed
  bool get isSiteEmpty => site != null;

  @computed
  bool get loading => fetchSitesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getSites() async {
    final future = _repository.getSites();
    fetchSitesFuture = ObservableFuture(future);

    future.then((site) {
      this.site = site;
      success = true;
      if (site.branchs != null){
        this.branch = this.site.branchs.firstWhere((element) => element.domain.contains(Endpoints.baseUrl));
      }
    }).catchError((error) async {
      success = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  // Future myBranchs(){
  //   return 
  // }
}
