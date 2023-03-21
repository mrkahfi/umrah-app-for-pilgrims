import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/gallery/gallery.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'gallery_store.g.dart';

class GalleryStore = _GalleryStoreBase with _$GalleryStore;

abstract class _GalleryStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _GalleryStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<GalleryList> emptyGalleryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<GalleryList> fetchGallerysFuture =
      ObservableFuture<GalleryList>(emptyGalleryResponse);

  static ObservableFuture<GalleryList> emptyTestimonialResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<GalleryList> fetchTestimonialFuture =
      ObservableFuture<GalleryList>(emptyTestimonialResponse);

  @observable
  Gallery gallery;

  @observable
  int indicatorCurrent = 0;

  @observable
  int selectedButton = 1;

  @observable
  ObservableList<Gallery> galleryListData = ObservableList<Gallery>();

  @observable
  ObservableList<Gallery> galleryListTestimonial = ObservableList<Gallery>();

  @observable
  ObservableList<Gallery> galleryListSelected = ObservableList<Gallery>();

  @observable
  bool success = false;

  @computed
  bool get isGalleryEmpty => galleryListData.isEmpty;

  @computed
  bool get isTestimonialEmpty => galleryListTestimonial.isEmpty;

  @computed
  bool get loading => fetchGallerysFuture.status == FutureStatus.pending;

  @computed
  bool get loadingTestimonial =>
      fetchTestimonialFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  void setCurrentDotIndicator(value) => indicatorCurrent = value;

  @action
  void setSelectionTab(int value) {
    selectedButton = value;
    if (selectedButton == 1) {
      galleryListSelected.clear();
      galleryListData.forEach((gallery) {
        galleryListSelected.add(gallery);
      });
    }
    if (selectedButton == 2) {
      galleryListSelected.clear();
      galleryListTestimonial.forEach((gallery) {
        galleryListSelected.add(gallery);
      });
    }
  }

  // @action
  ObservableList<Gallery> getSelectedButton(int selectedButton) {
    if (selectedButton == 1) {
      galleryListSelected.clear();
      galleryListData.forEach((gallery) {
        galleryListSelected.add(gallery);
      });
    }
    if (selectedButton == 2) {
      galleryListSelected.clear();
      galleryListTestimonial.forEach((gallery) {
        galleryListSelected.add(gallery);
      });
    }
    return galleryListSelected;
  }

  @action
  Future getGalleries() async {
    final future = _repository.getGalleries();
    fetchGallerysFuture = ObservableFuture(future);

    future.then((galleryList) {
      if (galleryListData.isNotEmpty) {
        galleryListData.clear();
      }
      if (galleryListSelected.isNotEmpty) {
        galleryListSelected.clear();
      }
      galleryListData.addAll(galleryList.galleries);
      galleryListSelected.addAll(galleryList.galleries);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getTestimonials() async {
    final future = _repository.getTestimonials();
    fetchTestimonialFuture = ObservableFuture(future);

    future.then((testimonialList) {
      if (galleryListTestimonial.isNotEmpty) {
        galleryListTestimonial.clear();
      }
      galleryListTestimonial.addAll(testimonialList.galleries);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
