import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/inbox/inbox.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'inbox_store.g.dart';

class InboxStore = _InboxStoreBase with _$InboxStore;

abstract class _InboxStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _InboxStoreBase(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<InboxList> emptyInboxListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<InboxList> fetchInboxListFuture =
      ObservableFuture<InboxList>(emptyInboxListResponse);

  static ObservableFuture<Inbox> emptyInboxResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Inbox> fetchInboxFuture =
      ObservableFuture<Inbox>(emptyInboxResponse);

  @observable
  ObservableList<Inbox> inboxListData = ObservableList<Inbox>();

  @observable
  Inbox inbox;

  @observable
  bool success = false;

  @observable
  bool progress = false;

  @computed
  bool get isInboxEmpty => inboxListData.isEmpty;

  @computed
  ObservableList<Inbox> get completedReadInboxes =>
      ObservableList.of(inboxListData.where((inbox) => inbox.read != true));

  @computed
  bool get loading => fetchInboxListFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getInboxes() async {
    if (inboxListData.isNotEmpty) {
      inboxListData.clear();
    }

    final future = _repository.getInboxes();
    fetchInboxListFuture = ObservableFuture(future);

    future.then((inboxList) {
      inboxListData.addAll(inboxList.inboxes);
      this.success = true;
    }).catchError((error) async {
      this.success = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future updateReadInbox(String id) async {
    progress = true;
    var hasRead = FormData.fromMap({"inbox[read]": true});

    final future = _repository.readInbox(id, hasRead);
    fetchInboxFuture = ObservableFuture(future);
    future.then((inbox) {
      progress = false;
      success = true;
      this.inbox = inbox;
      getInboxes();
      print('Success.......');
    }).catchError((e) async {
      progress = false;
      success = false;
      print('Error.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }
}