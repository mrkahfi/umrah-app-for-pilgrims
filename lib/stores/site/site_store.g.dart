// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SiteStore on _SiteStoreBase, Store {
  Computed<bool> _$isSiteEmptyComputed;

  @override
  bool get isSiteEmpty =>
      (_$isSiteEmptyComputed ??= Computed<bool>(() => super.isSiteEmpty,
              name: '_SiteStoreBase.isSiteEmpty'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_SiteStoreBase.loading'))
      .value;

  final _$fetchSitesFutureAtom = Atom(name: '_SiteStoreBase.fetchSitesFuture');

  @override
  ObservableFuture<Site> get fetchSitesFuture {
    _$fetchSitesFutureAtom.reportRead();
    return super.fetchSitesFuture;
  }

  @override
  set fetchSitesFuture(ObservableFuture<Site> value) {
    _$fetchSitesFutureAtom.reportWrite(value, super.fetchSitesFuture, () {
      super.fetchSitesFuture = value;
    });
  }

  final _$siteAtom = Atom(name: '_SiteStoreBase.site');

  @override
  Site get site {
    _$siteAtom.reportRead();
    return super.site;
  }

  @override
  set site(Site value) {
    _$siteAtom.reportWrite(value, super.site, () {
      super.site = value;
    });
  }

  final _$branchAtom = Atom(name: '_SiteStoreBase.branch');

  @override
  EndpointsAPI get branch {
    _$branchAtom.reportRead();
    return super.branch;
  }

  @override
  set branch(EndpointsAPI value) {
    _$branchAtom.reportWrite(value, super.branch, () {
      super.branch = value;
    });
  }

  final _$successAtom = Atom(name: '_SiteStoreBase.success');

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

  final _$getSitesAsyncAction = AsyncAction('_SiteStoreBase.getSites');

  @override
  Future<dynamic> getSites() {
    return _$getSitesAsyncAction.run(() => super.getSites());
  }

  @override
  String toString() {
    return '''
fetchSitesFuture: ${fetchSitesFuture},
site: ${site},
branch: ${branch},
success: ${success},
isSiteEmpty: ${isSiteEmpty},
loading: ${loading}
    ''';
  }
}
