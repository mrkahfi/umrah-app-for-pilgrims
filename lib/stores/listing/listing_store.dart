import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/listing/listing.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'listing_store.g.dart';

class ListingStore = _ListingStoreBase with _$ListingStore;

abstract class _ListingStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _ListingStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<ListingList> emptyListingResponse =
      ObservableFuture.value(null);

  static ObservableFuture<Listing> emptyListingDetailResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ListingList> fetchListingsFuture =
      ObservableFuture<ListingList>(emptyListingResponse);

  @observable
  ObservableFuture<Listing> fetchListingDetailFuture =
      ObservableFuture<Listing>(emptyListingDetailResponse);

  @observable
  Listing listing;

  @observable
  ObservableList<Listing> listingListData = ObservableList<Listing>();

  @observable
  ObservableList<Listing> searchListData = ObservableList<Listing>();

  @observable
  bool success = false;

  @computed
  bool get isListingEmpty => listingListData.isEmpty;

  @computed
  bool get isSearchListEmpty => searchListData.isEmpty;

  @computed
  bool get loading => fetchListingsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingDetail =>
      fetchListingDetailFuture.status == FutureStatus.pending;

  @action
  Future onSearchTextChanged(String text) async {
    searchListData.clear();
    if (text.isEmpty) {
      return;
    }

    listingListData.forEach((dataList) {
      if (dataList.name.toLowerCase().contains(text))
        searchListData.add(dataList);
    });
  }

  // actions:-------------------------------------------------------------------
  @action
  Future getListings() async {
    final future = _repository.getListings();
    fetchListingsFuture = ObservableFuture(future);

    future.then((listingList) {
      if (listingListData.isNotEmpty) {
        listingListData.clear();
      }
      listingListData.addAll(listingList.listings);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getListingDetail(int listingId) async {
    final future = _repository.getListingDetails(listingId);
    fetchListingDetailFuture = ObservableFuture(future);

    future.then((listing) {
      this.success = true;
      this.listing = listing;
    }).catchError((error) async {
      this.success = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
