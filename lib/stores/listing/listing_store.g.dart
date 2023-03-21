// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListingStore on _ListingStoreBase, Store {
  Computed<bool> _$isListingEmptyComputed;

  @override
  bool get isListingEmpty =>
      (_$isListingEmptyComputed ??= Computed<bool>(() => super.isListingEmpty,
              name: '_ListingStoreBase.isListingEmpty'))
          .value;
  Computed<bool> _$isSearchListEmptyComputed;

  @override
  bool get isSearchListEmpty => (_$isSearchListEmptyComputed ??= Computed<bool>(
          () => super.isSearchListEmpty,
          name: '_ListingStoreBase.isSearchListEmpty'))
      .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ListingStoreBase.loading'))
      .value;
  Computed<bool> _$loadingDetailComputed;

  @override
  bool get loadingDetail =>
      (_$loadingDetailComputed ??= Computed<bool>(() => super.loadingDetail,
              name: '_ListingStoreBase.loadingDetail'))
          .value;

  final _$fetchListingsFutureAtom =
      Atom(name: '_ListingStoreBase.fetchListingsFuture');

  @override
  ObservableFuture<ListingList> get fetchListingsFuture {
    _$fetchListingsFutureAtom.reportRead();
    return super.fetchListingsFuture;
  }

  @override
  set fetchListingsFuture(ObservableFuture<ListingList> value) {
    _$fetchListingsFutureAtom.reportWrite(value, super.fetchListingsFuture, () {
      super.fetchListingsFuture = value;
    });
  }

  final _$fetchListingDetailFutureAtom =
      Atom(name: '_ListingStoreBase.fetchListingDetailFuture');

  @override
  ObservableFuture<Listing> get fetchListingDetailFuture {
    _$fetchListingDetailFutureAtom.reportRead();
    return super.fetchListingDetailFuture;
  }

  @override
  set fetchListingDetailFuture(ObservableFuture<Listing> value) {
    _$fetchListingDetailFutureAtom
        .reportWrite(value, super.fetchListingDetailFuture, () {
      super.fetchListingDetailFuture = value;
    });
  }

  final _$listingAtom = Atom(name: '_ListingStoreBase.listing');

  @override
  Listing get listing {
    _$listingAtom.reportRead();
    return super.listing;
  }

  @override
  set listing(Listing value) {
    _$listingAtom.reportWrite(value, super.listing, () {
      super.listing = value;
    });
  }

  final _$listingListDataAtom = Atom(name: '_ListingStoreBase.listingListData');

  @override
  ObservableList<Listing> get listingListData {
    _$listingListDataAtom.reportRead();
    return super.listingListData;
  }

  @override
  set listingListData(ObservableList<Listing> value) {
    _$listingListDataAtom.reportWrite(value, super.listingListData, () {
      super.listingListData = value;
    });
  }

  final _$searchListDataAtom = Atom(name: '_ListingStoreBase.searchListData');

  @override
  ObservableList<Listing> get searchListData {
    _$searchListDataAtom.reportRead();
    return super.searchListData;
  }

  @override
  set searchListData(ObservableList<Listing> value) {
    _$searchListDataAtom.reportWrite(value, super.searchListData, () {
      super.searchListData = value;
    });
  }

  final _$successAtom = Atom(name: '_ListingStoreBase.success');

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

  final _$onSearchTextChangedAsyncAction =
      AsyncAction('_ListingStoreBase.onSearchTextChanged');

  @override
  Future<dynamic> onSearchTextChanged(String text) {
    return _$onSearchTextChangedAsyncAction
        .run(() => super.onSearchTextChanged(text));
  }

  final _$getListingsAsyncAction = AsyncAction('_ListingStoreBase.getListings');

  @override
  Future<dynamic> getListings() {
    return _$getListingsAsyncAction.run(() => super.getListings());
  }

  final _$getListingDetailAsyncAction =
      AsyncAction('_ListingStoreBase.getListingDetail');

  @override
  Future<dynamic> getListingDetail(int listingId) {
    return _$getListingDetailAsyncAction
        .run(() => super.getListingDetail(listingId));
  }

  @override
  String toString() {
    return '''
fetchListingsFuture: ${fetchListingsFuture},
fetchListingDetailFuture: ${fetchListingDetailFuture},
listing: ${listing},
listingListData: ${listingListData},
searchListData: ${searchListData},
success: ${success},
isListingEmpty: ${isListingEmpty},
isSearchListEmpty: ${isSearchListEmpty},
loading: ${loading},
loadingDetail: ${loadingDetail}
    ''';
  }
}
