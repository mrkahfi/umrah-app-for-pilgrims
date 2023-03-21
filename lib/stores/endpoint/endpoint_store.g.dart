// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoint_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EndpointStore on _EndpointStoreBase, Store {
  Computed<bool> _$endpointIsEmptyComputed;

  @override
  bool get endpointIsEmpty =>
      (_$endpointIsEmptyComputed ??= Computed<bool>(() => super.endpointIsEmpty,
              name: '_EndpointStoreBase.endpointIsEmpty'))
          .value;

  final _$fetchEndpointsApiFutureAtom =
      Atom(name: '_EndpointStoreBase.fetchEndpointsApiFuture');

  @override
  ObservableFuture<EndpointsAPI> get fetchEndpointsApiFuture {
    _$fetchEndpointsApiFutureAtom.reportRead();
    return super.fetchEndpointsApiFuture;
  }

  @override
  set fetchEndpointsApiFuture(ObservableFuture<EndpointsAPI> value) {
    _$fetchEndpointsApiFutureAtom
        .reportWrite(value, super.fetchEndpointsApiFuture, () {
      super.fetchEndpointsApiFuture = value;
    });
  }

  final _$endpointsApiAtom = Atom(name: '_EndpointStoreBase.endpointsApi');

  @override
  EndpointsAPI get endpointsApi {
    _$endpointsApiAtom.reportRead();
    return super.endpointsApi;
  }

  @override
  set endpointsApi(EndpointsAPI value) {
    _$endpointsApiAtom.reportWrite(value, super.endpointsApi, () {
      super.endpointsApi = value;
    });
  }

  final _$successAtom = Atom(name: '_EndpointStoreBase.success');

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

  final _$loadingAtom = Atom(name: '_EndpointStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$deletedAtom = Atom(name: '_EndpointStoreBase.deleted');

  @override
  bool get deleted {
    _$deletedAtom.reportRead();
    return super.deleted;
  }

  @override
  set deleted(bool value) {
    _$deletedAtom.reportWrite(value, super.deleted, () {
      super.deleted = value;
    });
  }

  final _$totalCountAtom = Atom(name: '_EndpointStoreBase.totalCount');

  @override
  int get totalCount {
    _$totalCountAtom.reportRead();
    return super.totalCount;
  }

  @override
  set totalCount(int value) {
    _$totalCountAtom.reportWrite(value, super.totalCount, () {
      super.totalCount = value;
    });
  }

  final _$saveEndpointAsyncAction =
      AsyncAction('_EndpointStoreBase.saveEndpoint');

  @override
  Future<dynamic> saveEndpoint(EndpointsAPI endpointsAPI) {
    return _$saveEndpointAsyncAction
        .run(() => super.saveEndpoint(endpointsAPI));
  }

  final _$getEndpointsAsyncAction =
      AsyncAction('_EndpointStoreBase.getEndpoints');

  @override
  Future<dynamic> getEndpoints() {
    return _$getEndpointsAsyncAction.run(() => super.getEndpoints());
  }

  final _$checkCountAsyncAction = AsyncAction('_EndpointStoreBase.checkCount');

  @override
  Future<dynamic> checkCount() {
    return _$checkCountAsyncAction.run(() => super.checkCount());
  }

  final _$changeUrlAsyncAction = AsyncAction('_EndpointStoreBase.changeUrl');

  @override
  Future<dynamic> changeUrl(EndpointsAPI endpointsAPI) {
    return _$changeUrlAsyncAction.run(() => super.changeUrl(endpointsAPI));
  }

  @override
  String toString() {
    return '''
fetchEndpointsApiFuture: ${fetchEndpointsApiFuture},
endpointsApi: ${endpointsApi},
success: ${success},
loading: ${loading},
deleted: ${deleted},
totalCount: ${totalCount},
endpointIsEmpty: ${endpointIsEmpty}
    ''';
  }
}
