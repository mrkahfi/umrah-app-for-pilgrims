import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/prayer/prayer.dart';
import 'package:app_jamaah_boilerplate/models/quran/ayah.dart';
import 'package:app_jamaah_boilerplate/models/quran/ayah_translate.dart';
import 'package:app_jamaah_boilerplate/models/quran/surah.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:app_jamaah_boilerplate/widgets/base_app.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'quran_store.g.dart';

class QuranStore = _QuranStoreBase with _$QuranStore;

abstract class _QuranStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _QuranStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Surahs> emptySurahsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Surahs> fetchSurahsFuture =
      ObservableFuture<Surahs>(emptySurahsResponse);

  static ObservableFuture<Prayer> emptyPrayerResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Prayer> fetchPrayerFuture =
      ObservableFuture<Prayer>(emptyPrayerResponse);

  static ObservableFuture<List<DataSurah>> emptyBookmarksListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<DataSurah>> fetchBookmarksListFuture =
      ObservableFuture<List<DataSurah>>(emptyBookmarksListResponse);

  static ObservableFuture<DataSurah> emptyBookmarkResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<DataSurah> fetchBookmarkFuture =
      ObservableFuture<DataSurah>(emptyBookmarkResponse);

  static ObservableFuture<Ayah> emptyAyahsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Ayah> fetchAyahsFuture =
      ObservableFuture<Ayah>(emptyAyahsResponse);

  static ObservableFuture<AyahTrans> emptyAyahsTranslateResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AyahTrans> fetchAyahsTranslateFuture =
      ObservableFuture<AyahTrans>(emptyAyahsTranslateResponse);

  @observable
  DataSurah bookmarkData;

  @observable
  Surahs surahs;

  @observable
  Prayer prayer;

  @observable
  var curTime;

  @observable
  var curPrayer;

  @observable
  var curTimePrayer;

  @observable
  var fajr;

  @observable
  var dhuhr;

  @observable
  var ashr;

  @observable
  var maghrib;

  @observable
  var isya;

  @observable
  Ayah ayahs;

  @observable
  int selectedButton = 1;

  @observable
  int indexBookmark;

  @observable
  ObservableList<Ayahs> ayahListData = ObservableList<Ayahs>();

  @observable
  ObservableList<AyahsT> ayahTranslateListData = ObservableList<AyahsT>();

  @observable
  ObservableList<DataSurah> surahListData = ObservableList<DataSurah>();

  @observable
  List<DataSurah> surahListBookmark = List<DataSurah>();

  @observable
  ObservableList<DataSurah> searchSurahList = ObservableList<DataSurah>();

  @observable
  bool success = false;

  @observable
  bool deleteSurah = false;

  @observable
  bool loadBookmarkList = false;

  @observable
  bool loadBookmark = false;

  @observable
  bool isSaveBookmark = false;

  @observable
  bool successPrayerLoad = false;

  @observable
  double lat;

  @observable
  double lon;

  @observable
  String curLocation;

  @observable
  String curCity;

  @computed
  bool get isLocationNotEmpty => lat != null && lon != null && curLocation != null && curCity != null;

  @computed
  bool get isSurahsEmpty => surahListData.isEmpty;

  @computed
  bool get isSearchListEmpty => searchSurahList.isEmpty;

  @computed
  bool get isAyahsEmpty => ayahListData.isEmpty;

  @computed
  bool get isAyahsTranslateEmpty => ayahTranslateListData.isEmpty;

  @computed
  bool get loadingSurah => fetchSurahsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingAyah => fetchAyahsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingPrayer => fetchPrayerFuture.status == FutureStatus.pending;

  @computed
  bool get loadingAyahTranslate =>
      fetchAyahsFuture.status == FutureStatus.pending;

  @action
  Future onSearchTextChanged(String text) async {
    searchSurahList.clear();
    if (text.isEmpty) {
      return;
    }
    surahListData.forEach((dataList) {
      if (dataList.englishName.toLowerCase().contains(text))
        searchSurahList.add(dataList);
    });
  }

  @action
  void setSelectionTab(int value) {
    selectedButton = value;
  }

  // actions:-------------------------------------------------------------------
  @action
  Future getPrayerTime(double lon, double lat) async {
    final future = _repository.getPrayerTime(lon, lat);
    fetchPrayerFuture = ObservableFuture(future);

    future.then((prayer) {
      this.prayer = prayer;
      List<Datetime> listDatetime = prayer.results.datetime;
      curTime = Func.timeToInt(Func.getTime(Format.time_3));
      fajr = Func.timeToInt(listDatetime[0].times.fajr);
      dhuhr = Func.timeToInt(listDatetime[0].times.dhuhr);
      ashr = Func.timeToInt(listDatetime[0].times.asr);
      maghrib = Func.timeToInt(listDatetime[0].times.maghrib);
      isya = Func.timeToInt(listDatetime[0].times.isha);

      if (curTime >= fajr && curTime < dhuhr) {
        curPrayer = Time.dhuhur;
        curTimePrayer = listDatetime[0].times.dhuhr;
      } else if (curTime >= dhuhr && curTime < ashr) {
        curPrayer = Time.ashar;
        curTimePrayer = listDatetime[0].times.asr;
      } else if (curTime >= ashr && curTime < maghrib) {
        curPrayer = Time.maghrib;
        curTimePrayer = listDatetime[0].times.maghrib;
      } else if (curTime >= maghrib && curTime < isya) {
        curPrayer = Time.isya;
        curTimePrayer = listDatetime[0].times.isha;
      } else {
        curPrayer = Time.shubuh;
        curTimePrayer = listDatetime[0].times.fajr;
      }
      successPrayerLoad = true;
    }).catchError((error) async {
      successPrayerLoad = false;
      this.prayer = null;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getSurahs() async {
    final future = _repository.getSurahs();
    fetchSurahsFuture = ObservableFuture(future);

    future.then((surahsList) {
      if (surahListData.isNotEmpty) {
        surahListData.clear();
      }
      surahListData.addAll(surahsList.data);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future saveBookmarkSurah(DataSurah surah) async {
    final future = _repository.insertSurahBookmark(surah);
    bookmarkData = surah;
    return future;
  }

  @action
  Future deleteBookmarkSurah(DataSurah surah) async {
    final future = _repository.deleteSurahBookmark(surah);
    future.then((surah) {
      deleteSurah = true;
      bookmarkData = null;
      isSaveBookmark = false;
      indexBookmark = null;
      print("indexBookmark....$indexBookmark");
    }).catchError((error) async {
      deleteSurah = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
    return future;
  }

  @action
  Future getBookmarkList() async {
    loadBookmarkList = true;

    final future = _repository.getSurahListBookmark();
    fetchBookmarksListFuture = ObservableFuture(future);
    future.then((surah) {
      loadBookmarkList = false;
      success = true;
      if (surah != null) {
        surah.forEach((element) {
          print("BookmarList...... ${element.indexAyah}");
        });
        print("BookmarLenght...... ${surah.length}");
        this.surahListBookmark = surah;
      }
    }).catchError((error) async {
      print("BookmarList Err......$error");
      this.surahListBookmark = null;
      loadBookmarkList = false;
      success = false;
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getBookmark(int numberAyahId) async {
    if (surahListBookmark.isNotEmpty) {
      surahListBookmark.forEach((element) {
        if (numberAyahId == element.numberAyahId) {
          bookmarkData = element;
          isSaveBookmark = true;
          indexBookmark = element.indexAyah;
        }
      });
    }
  }

  @action
  Future getAyahs(int surahId) async {
    final future = _repository.getAyahs(surahId);
    fetchAyahsFuture = ObservableFuture(future);

    future.then((ayahs) {
      if (ayahListData.isNotEmpty) {
        ayahListData.clear();
      }
      this.ayahs = ayahs;
      ayahListData.addAll(ayahs.data.ayahs);
      ayahListData.forEach((element) {
        getBookmark(element.number);
      });
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getAyahsTranslate(int surahId) async {
    final future = _repository.getAyahsTranslate(surahId);
    fetchAyahsTranslateFuture = ObservableFuture(future);

    future.then((ayahs) {
      if (ayahTranslateListData.isNotEmpty) {
        ayahTranslateListData.clear();
      }
      ayahTranslateListData.addAll(ayahs.data.ayahs);
    }).catchError((error) async {
      await sentry.captureException(
        exception: error,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  void dispose() {
    bookmarkData = null;
    isSaveBookmark = false;
    indexBookmark = null;
    print("dispose.....$indexBookmark");
  }
}
