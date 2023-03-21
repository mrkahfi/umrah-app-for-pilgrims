// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InboxStore on _InboxStoreBase, Store {
  Computed<bool> _$isInboxEmptyComputed;

  @override
  bool get isInboxEmpty =>
      (_$isInboxEmptyComputed ??= Computed<bool>(() => super.isInboxEmpty,
              name: '_InboxStoreBase.isInboxEmpty'))
          .value;
  Computed<ObservableList<Inbox>> _$completedReadInboxesComputed;

  @override
  ObservableList<Inbox> get completedReadInboxes =>
      (_$completedReadInboxesComputed ??= Computed<ObservableList<Inbox>>(
              () => super.completedReadInboxes,
              name: '_InboxStoreBase.completedReadInboxes'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_InboxStoreBase.loading'))
      .value;

  final _$fetchInboxListFutureAtom =
      Atom(name: '_InboxStoreBase.fetchInboxListFuture');

  @override
  ObservableFuture<InboxList> get fetchInboxListFuture {
    _$fetchInboxListFutureAtom.reportRead();
    return super.fetchInboxListFuture;
  }

  @override
  set fetchInboxListFuture(ObservableFuture<InboxList> value) {
    _$fetchInboxListFutureAtom.reportWrite(value, super.fetchInboxListFuture,
        () {
      super.fetchInboxListFuture = value;
    });
  }

  final _$fetchInboxFutureAtom = Atom(name: '_InboxStoreBase.fetchInboxFuture');

  @override
  ObservableFuture<Inbox> get fetchInboxFuture {
    _$fetchInboxFutureAtom.reportRead();
    return super.fetchInboxFuture;
  }

  @override
  set fetchInboxFuture(ObservableFuture<Inbox> value) {
    _$fetchInboxFutureAtom.reportWrite(value, super.fetchInboxFuture, () {
      super.fetchInboxFuture = value;
    });
  }

  final _$inboxListDataAtom = Atom(name: '_InboxStoreBase.inboxListData');

  @override
  ObservableList<Inbox> get inboxListData {
    _$inboxListDataAtom.reportRead();
    return super.inboxListData;
  }

  @override
  set inboxListData(ObservableList<Inbox> value) {
    _$inboxListDataAtom.reportWrite(value, super.inboxListData, () {
      super.inboxListData = value;
    });
  }

  final _$inboxAtom = Atom(name: '_InboxStoreBase.inbox');

  @override
  Inbox get inbox {
    _$inboxAtom.reportRead();
    return super.inbox;
  }

  @override
  set inbox(Inbox value) {
    _$inboxAtom.reportWrite(value, super.inbox, () {
      super.inbox = value;
    });
  }

  final _$successAtom = Atom(name: '_InboxStoreBase.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$progressAtom = Atom(name: '_InboxStoreBase.progress');

  @override
  bool get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(bool value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  final _$getInboxesAsyncAction = AsyncAction('_InboxStoreBase.getInboxes');

  @override
  Future<dynamic> getInboxes() {
    return _$getInboxesAsyncAction.run(() => super.getInboxes());
  }

  final _$updateReadInboxAsyncAction =
      AsyncAction('_InboxStoreBase.updateReadInbox');

  @override
  Future<dynamic> updateReadInbox(String id) {
    return _$updateReadInboxAsyncAction.run(() => super.updateReadInbox(id));
  }

  @override
  String toString() {
    return '''
fetchInboxListFuture: ${fetchInboxListFuture},
fetchInboxFuture: ${fetchInboxFuture},
inboxListData: ${inboxListData},
inbox: ${inbox},
success: ${success},
progress: ${progress},
isInboxEmpty: ${isInboxEmpty},
completedReadInboxes: ${completedReadInboxes},
loading: ${loading}
    ''';
  }
}
