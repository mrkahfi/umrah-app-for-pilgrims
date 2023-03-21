import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/invoice/bank.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'bank_store.g.dart';

class BankStore = _BankStoreBase with _$BankStore;

abstract class _BankStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _BankStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<BankList> emptyBankResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<BankList> fetchBanksFuture =
      ObservableFuture<BankList>(emptyBankResponse);

  @observable
  Bank bank;

  @observable
  ObservableList<Bank> bankListData = ObservableList<Bank>();

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get isBankEmpty => bankListData.length > 0 ? bankListData.isNotEmpty : bankListData.isEmpty;
  
  // actions:-------------------------------------------------------------------
  @action
  Future getBanks() async {
    loading = true;
    if (bankListData.isNotEmpty) {
      bankListData.clear();
    }

    final future = _repository.getBanks();
    fetchBanksFuture = ObservableFuture(future);

    future.then((bankList) {
      bankListData.addAll(bankList.banks);
      success = true;
      loading = false;
    }).catchError((error) async {
      success = false;
      loading = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
