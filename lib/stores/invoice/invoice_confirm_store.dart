import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/payment/payment.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'invoice_confirm_store.g.dart';

class InvoiceConfirmStore = _InvoiceConfirmStoreBase with _$InvoiceConfirmStore;

abstract class _InvoiceConfirmStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _InvoiceConfirmStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------

  static ObservableFuture<Midtrans> emptyMidtransResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Midtrans> fetchMidtransFuture =
      ObservableFuture<Midtrans>(emptyMidtransResponse);

  @observable
  Midtrans midtrans;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchMidtransFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPaymentMidtrans(String slug) async {
    final future = _repository.getTokenMidtrans(slug);
    fetchMidtransFuture = ObservableFuture(future);

    future.then((midtrans) {
      this.midtrans = midtrans;
      success = true;
    }).catchError((error) async {
      success = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
  
  void dispose() {
    success = false;
  }
}