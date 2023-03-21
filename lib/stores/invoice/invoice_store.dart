import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';

import '../error/error_store.dart';
part 'invoice_store.g.dart';

class InvoiceStore = _InvoiceStoreBase with _$InvoiceStore;

abstract class _InvoiceStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _InvoiceStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------

  static ObservableFuture<InvoiceList> emptyInvoiceListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<InvoiceList> fetchInvoicesListFuture =
      ObservableFuture<InvoiceList>(emptyInvoiceListResponse);

  static ObservableFuture<Invoice> emptyInvoiceResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Invoice> fetchInvoicesFuture =
      ObservableFuture<Invoice>(emptyInvoiceResponse);

  @observable
  Invoice invoice;

  @observable
  ObservableList<Invoice> invoiceListData = ObservableList<Invoice>();

  @observable
  Map listPaket = new Map();

  @observable
  bool success = false;

  @computed
  bool get isInvoiceEmpty => invoiceListData.isEmpty;

  @computed
  bool get loading => fetchInvoicesListFuture.status == FutureStatus.pending;

  @computed
  bool get loadingDetail => fetchInvoicesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getInvoices() async {
    if (invoiceListData.isNotEmpty) {
      invoiceListData.clear();
    }

    final future = _repository.getInvoices();
    fetchInvoicesListFuture = ObservableFuture(future);

    future.then((invoiceList) {
      invoiceListData.addAll(invoiceList.invoices);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  void recalculateCost() {
    var map = Map();
    invoice.bookings.forEach((element) {
      if (!map.containsKey(element.variant.name)) {
        listPaket.addAll({
          element.variant.name: {
            "paket": element.variant.name,
            "price": !listPaket.containsKey(element.variant.name)
                ? (element.variant.price)
                : (listPaket[element.variant.name]['price'] +
                    1 * element.variant.price),
            "count": !listPaket.containsKey(element.variant.name)
                ? (1)
                : (listPaket[element.variant.name]['count'] + 1)
          }
        });
      } else {
        listPaket.addAll({
          element.variant.name: {
            "paket": element.variant.name,
            "price": !listPaket.containsKey(element.variant.name)
                ? (element.variant.price)
                : (listPaket[element.variant.name]['price'] +
                    1 * element.variant.price),
            "count": !listPaket.containsKey(element.variant.name)
                ? (1)
                : (listPaket[element.variant.name]['count'] + 1)
          }
        });
      }
    });
    print(listPaket);
  }

  @action
  Future getInvoicesDetail(String slug) async {
    if (listPaket.isNotEmpty) {
      listPaket.clear();
    }

    final future = _repository.getInvoicesDetail(slug);
    fetchInvoicesFuture = ObservableFuture(future);

    future.then((invoice) {
      this.invoice = invoice;
      recalculateCost();
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}