// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuranStore on _QuranStoreBase, Store {
  Computed<bool> _$isLocationNotEmptyComputed;

  @override
  bool get isLocationNotEmpty => (_$isLocationNotEmptyComputed ??=
          Computed<bool>(() => super.isLocationNotEmpty,
              name: '_QuranStoreBase.isLocationNotEmpty'))
      .value;
  Computed<bool> _$isSurahsEmptyComputed;

  @override
  bool get isSurahsEmpty =>
      (_$isSurahsEmptyComputed ??= Computed<bool>(() => super.isSurahsEmpty,
              name: '_QuranStoreBase.isSurahsEmpty'))
          .value;
  Computed<bool> _$isSearchListEmptyComputed;

  @override
  bool get isSearchListEmpty => (_$isSearchListEmptyComputed ??= Computed<bool>(
          () => super.isSearchListEmpty,
          name: '_QuranStoreBase.isSearchListEmpty'))
      .value;
  Computed<bool> _$isAyahsEmptyComputed;

  @override
  bool get isAyahsEmpty =>
      (_$isAyahsEmptyComputed ??= Computed<bool>(() => super.isAyahsEmpty,
              name: '_QuranStoreBase.isAyahsEmpty'))
          .value;
  Computed<bool> _$isAyahsTranslateEmptyComputed;

  @override
  bool get isAyahsTranslateEmpty => (_$isAyahsTranslateEmptyComputed ??=
          Computed<bool>(() => super.isAyahsTranslateEmpty,
              name: '_QuranStoreBase.isAyahsTranslateEmpty'))
      .value;
  Computed<bool> _$loadingSurahComputed;

  @override
  bool get loadingSurah =>
      (_$loadingSurahComputed ??= Computed<bool>(() => super.loadingSurah,
              name: '_QuranStoreBase.loadingSurah'))
          .value;
  Computed<bool> _$loadingAyahComputed;

  @override
  bool get loadingAyah =>
      (_$loadingAyahComputed ??= Computed<bool>(() => super.loadingAyah,
              name: '_QuranStoreBase.loadingAyah'))
          .value;
  Computed<bool> _$loadingAyahTranslateComputed;

  @override
  bool get loadingAyahTranslate => (_$loadingAyahTranslateComputed ??=
          Computed<bool>(() => super.loadingAyahTranslate,
              name: '_QuranStoreBase.loadingAyahTranslate'))
      .value;

  final _$fetchSurahsFutureAtom =
      Atom(name: '_QuranStoreBase.fetchSurahsFuture');

  @override
  ObservableFuture<Surahs> get fetchSurahsFuture {
    _$fetchSurahsFutureAtom.reportRead();
    return super.fetchSurahsFuture;
  }

  @override
  set fetchSurahsFuture(ObservableFuture<Surahs> value) {
    _$fetchSurahsFutureAtom.reportWrite(value, super.fetchSurahsFuture, () {
      super.fetchSurahsFuture = value;
    });
  }

  final _$fetchPrayerFutureAtom =
      Atom(name: '_QuranStoreBase.fetchPrayerFuture');

  @override
  ObservableFuture<Prayer> get fetchPrayerFuture {
    _$fetchPrayerFutureAtom.reportRead();
    return super.fetchPrayerFuture;
  }

  @override
  set fetchPrayerFuture(ObservableFuture<Prayer> value) {
    _$fetchPrayerFutureAtom.reportWrite(value, super.fetchPrayerFuture, () {
      super.fetchPrayerFuture = value;
    });
  }

  final _$fetchBookmarksListFutureAtom =
      Atom(name: '_QuranStoreBase.fetchBookmarksListFuture');

  @override
  ObservableFuture<List<DataSurah>> get fetchBookmarksListFuture {
    _$fetchBookmarksListFutureAtom.reportRead();
    return super.fetchBookmarksListFuture;
  }

  @override
  set fetchBookmarksListFuture(ObservableFuture<List<DataSurah>> value) {
    _$fetchBookmarksListFutureAtom
        .reportWrite(value, super.fetchBookmarksListFuture, () {
      super.fetchBookmarksListFuture = value;
    });
  }

  final _$fetchBookmarkFutureAtom =
      Atom(name: '_QuranStoreBase.fetchBookmarkFuture');

  @override
  ObservableFuture<DataSurah> get fetchBookmarkFuture {
    _$fetchBookmarkFutureAtom.reportRead();
    return super.fetchBookmarkFuture;
  }

  @override
  set fetchBookmarkFuture(ObservableFuture<DataSurah> value) {
    _$fetchBookmarkFutureAtom.reportWrite(value, super.fetchBookmarkFuture, () {
      super.fetchBookmarkFuture = value;
    });
  }

  final _$fetchAyahsFutureAtom = Atom(name: '_QuranStoreBase.fetchAyahsFuture');

  @override
  ObservableFuture<Ayah> get fetchAyahsFuture {
    _$fetchAyahsFutureAtom.reportRead();
    return super.fetchAyahsFuture;
  }

  @override
  set fetchAyahsFuture(ObservableFuture<Ayah> value) {
    _$fetchAyahsFutureAtom.reportWrite(value, super.fetchAyahsFuture, () {
      super.fetchAyahsFuture = value;
    });
  }

  final _$fetchAyahsTranslateFutureAtom =
      Atom(name: '_QuranStoreBase.fetchAyahsTranslateFuture');

  @override
  ObservableFuture<AyahTrans> get fetchAyahsTranslateFuture {
    _$fetchAyahsTranslateFutureAtom.reportRead();
    return super.fetchAyahsTranslateFuture;
  }

  @override
  set fetchAyahsTranslateFuture(ObservableFuture<AyahTrans> value) {
    _$fetchAyahsTranslateFutureAtom
        .reportWrite(value, super.fetchAyahsTranslateFuture, () {
      super.fetchAyahsTranslateFuture = value;
    });
  }

  final _$bookmarkDataAtom = Atom(name: '_QuranStoreBase.bookmarkData');

  @override
  DataSurah get bookmarkData {
    _$bookmarkDataAtom.reportRead();
    return super.bookmarkData;
  }

  @override
  set bookmarkData(DataSurah value) {
    _$bookmarkDataAtom.reportWrite(value, super.bookmarkData, () {
      super.bookmarkData = value;
    });
  }

  final _$surahsAtom = Atom(name: '_QuranStoreBase.surahs');

  @override
  Surahs get surahs {
    _$surahsAtom.reportRead();
    return super.surahs;
  }

  @override
  set surahs(Surahs value) {
    _$surahsAtom.reportWrite(value, super.surahs, () {
      super.surahs = value;
    });
  }

  final _$prayerAtom = Atom(name: '_QuranStoreBase.prayer');

  @override
  Prayer get prayer {
    _$prayerAtom.reportRead();
    return super.prayer;
  }

  @override
  set prayer(Prayer value) {
    _$prayerAtom.reportWrite(value, super.prayer, () {
      super.prayer = value;
    });
  }

  final _$curTimeAtom = Atom(name: '_QuranStoreBase.curTime');

  @override
  dynamic get curTime {
    _$curTimeAtom.reportRead();
    return super.curTime;
  }

  @override
  set curTime(dynamic value) {
    _$curTimeAtom.reportWrite(value, super.curTime, () {
      super.curTime = value;
    });
  }

  final _$curPrayerAtom = Atom(name: '_QuranStoreBase.curPrayer');

  @override
  dynamic get curPrayer {
    _$curPrayerAtom.reportRead();
    return super.curPrayer;
  }

  @override
  set curPrayer(dynamic value) {
    _$curPrayerAtom.reportWrite(value, super.curPrayer, () {
      super.curPrayer = value;
    });
  }

  final _$curTimePrayerAtom = Atom(name: '_QuranStoreBase.curTimePrayer');

  @override
  dynamic get curTimePrayer {
    _$curTimePrayerAtom.reportRead();
    return super.curTimePrayer;
  }

  @override
  set curTimePrayer(dynamic value) {
    _$curTimePrayerAtom.reportWrite(value, super.curTimePrayer, () {
      super.curTimePrayer = value;
    });
  }

  final _$fajrAtom = Atom(name: '_QuranStoreBase.fajr');

  @override
  dynamic get fajr {
    _$fajrAtom.reportRead();
    return super.fajr;
  }

  @override
  set fajr(dynamic value) {
    _$fajrAtom.reportWrite(value, super.fajr, () {
      super.fajr = value;
    });
  }

  final _$dhuhrAtom = Atom(name: '_QuranStoreBase.dhuhr');

  @override
  dynamic get dhuhr {
    _$dhuhrAtom.reportRead();
    return super.dhuhr;
  }

  @override
  set dhuhr(dynamic value) {
    _$dhuhrAtom.reportWrite(value, super.dhuhr, () {
      super.dhuhr = value;
    });
  }

  final _$ashrAtom = Atom(name: '_QuranStoreBase.ashr');

  @override
  dynamic get ashr {
    _$ashrAtom.reportRead();
    return super.ashr;
  }

  @override
  set ashr(dynamic value) {
    _$ashrAtom.reportWrite(value, super.ashr, () {
      super.ashr = value;
    });
  }

  final _$maghribAtom = Atom(name: '_QuranStoreBase.maghrib');

  @override
  dynamic get maghrib {
    _$maghribAtom.reportRead();
    return super.maghrib;
  }

  @override
  set maghrib(dynamic value) {
    _$maghribAtom.reportWrite(value, super.maghrib, () {
      super.maghrib = value;
    });
  }

  final _$isyaAtom = Atom(name: '_QuranStoreBase.isya');

  @override
  dynamic get isya {
    _$isyaAtom.reportRead();
    return super.isya;
  }

  @override
  set isya(dynamic value) {
    _$isyaAtom.reportWrite(value, super.isya, () {
      super.isya = value;
    });
  }

  final _$ayahsAtom = Atom(name: '_QuranStoreBase.ayahs');

  @override
  Ayah get ayahs {
    _$ayahsAtom.reportRead();
    return super.ayahs;
  }

  @override
  set ayahs(Ayah value) {
    _$ayahsAtom.reportWrite(value, super.ayahs, () {
      super.ayahs = value;
    });
  }

  final _$selectedButtonAtom = Atom(name: '_QuranStoreBase.selectedButton');

  @override
  int get selectedButton {
    _$selectedButtonAtom.reportRead();
    return super.selectedButton;
  }

  @override
  set selectedButton(int value) {
    _$selectedButtonAtom.reportWrite(value, super.selectedButton, () {
      super.selectedButton = value;
    });
  }

  final _$indexBookmarkAtom = Atom(name: '_QuranStoreBase.indexBookmark');

  @override
  int get indexBookmark {
    _$indexBookmarkAtom.reportRead();
    return super.indexBookmark;
  }

  @override
  set indexBookmark(int value) {
    _$indexBookmarkAtom.reportWrite(value, super.indexBookmark, () {
      super.indexBookmark = value;
    });
  }

  final _$ayahListDataAtom = Atom(name: '_QuranStoreBase.ayahListData');

  @override
  ObservableList<Ayahs> get ayahListData {
    _$ayahListDataAtom.reportRead();
    return super.ayahListData;
  }

  @override
  set ayahListData(ObservableList<Ayahs> value) {
    _$ayahListDataAtom.reportWrite(value, super.ayahListData, () {
      super.ayahListData = value;
    });
  }

  final _$ayahTranslateListDataAtom =
      Atom(name: '_QuranStoreBase.ayahTranslateListData');

  @override
  ObservableList<AyahsT> get ayahTranslateListData {
    _$ayahTranslateListDataAtom.reportRead();
    return super.ayahTranslateListData;
  }

  @override
  set ayahTranslateListData(ObservableList<AyahsT> value) {
    _$ayahTranslateListDataAtom.reportWrite(value, super.ayahTranslateListData,
        () {
      super.ayahTranslateListData = value;
    });
  }

  final _$surahListDataAtom = Atom(name: '_QuranStoreBase.surahListData');

  @override
  ObservableList<DataSurah> get surahListData {
    _$surahListDataAtom.reportRead();
    return super.surahListData;
  }

  @override
  set surahListData(ObservableList<DataSurah> value) {
    _$surahListDataAtom.reportWrite(value, super.surahListData, () {
      super.surahListData = value;
    });
  }

  final _$surahListBookmarkAtom =
      Atom(name: '_QuranStoreBase.surahListBookmark');

  @override
  List<DataSurah> get surahListBookmark {
    _$surahListBookmarkAtom.reportRead();
    return super.surahListBookmark;
  }

  @override
  set surahListBookmark(List<DataSurah> value) {
    _$surahListBookmarkAtom.reportWrite(value, super.surahListBookmark, () {
      super.surahListBookmark = value;
    });
  }

  final _$searchSurahListAtom = Atom(name: '_QuranStoreBase.searchSurahList');

  @override
  ObservableList<DataSurah> get searchSurahList {
    _$searchSurahListAtom.reportRead();
    return super.searchSurahList;
  }

  @override
  set searchSurahList(ObservableList<DataSurah> value) {
    _$searchSurahListAtom.reportWrite(value, super.searchSurahList, () {
      super.searchSurahList = value;
    });
  }

  final _$successAtom = Atom(name: '_QuranStoreBase.success');

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

  final _$deleteSurahAtom = Atom(name: '_QuranStoreBase.deleteSurah');

  @override
  bool get deleteSurah {
    _$deleteSurahAtom.reportRead();
    return super.deleteSurah;
  }

  @override
  set deleteSurah(bool value) {
    _$deleteSurahAtom.reportWrite(value, super.deleteSurah, () {
      super.deleteSurah = value;
    });
  }

  final _$loadBookmarkListAtom = Atom(name: '_QuranStoreBase.loadBookmarkList');

  @override
  bool get loadBookmarkList {
    _$loadBookmarkListAtom.reportRead();
    return super.loadBookmarkList;
  }

  @override
  set loadBookmarkList(bool value) {
    _$loadBookmarkListAtom.reportWrite(value, super.loadBookmarkList, () {
      super.loadBookmarkList = value;
    });
  }

  final _$loadBookmarkAtom = Atom(name: '_QuranStoreBase.loadBookmark');

  @override
  bool get loadBookmark {
    _$loadBookmarkAtom.reportRead();
    return super.loadBookmark;
  }

  @override
  set loadBookmark(bool value) {
    _$loadBookmarkAtom.reportWrite(value, super.loadBookmark, () {
      super.loadBookmark = value;
    });
  }

  final _$isSaveBookmarkAtom = Atom(name: '_QuranStoreBase.isSaveBookmark');

  @override
  bool get isSaveBookmark {
    _$isSaveBookmarkAtom.reportRead();
    return super.isSaveBookmark;
  }

  @override
  set isSaveBookmark(bool value) {
    _$isSaveBookmarkAtom.reportWrite(value, super.isSaveBookmark, () {
      super.isSaveBookmark = value;
    });
  }

  final _$successPrayerLoadAtom =
      Atom(name: '_QuranStoreBase.successPrayerLoad');

  @override
  bool get successPrayerLoad {
    _$successPrayerLoadAtom.reportRead();
    return super.successPrayerLoad;
  }

  @override
  set successPrayerLoad(bool value) {
    _$successPrayerLoadAtom.reportWrite(value, super.successPrayerLoad, () {
      super.successPrayerLoad = value;
    });
  }

  final _$latAtom = Atom(name: '_QuranStoreBase.lat');

  @override
  double get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  final _$lonAtom = Atom(name: '_QuranStoreBase.lon');

  @override
  double get lon {
    _$lonAtom.reportRead();
    return super.lon;
  }

  @override
  set lon(double value) {
    _$lonAtom.reportWrite(value, super.lon, () {
      super.lon = value;
    });
  }

  final _$curLocationAtom = Atom(name: '_QuranStoreBase.curLocation');

  @override
  String get curLocation {
    _$curLocationAtom.reportRead();
    return super.curLocation;
  }

  @override
  set curLocation(String value) {
    _$curLocationAtom.reportWrite(value, super.curLocation, () {
      super.curLocation = value;
    });
  }

  final _$curCityAtom = Atom(name: '_QuranStoreBase.curCity');

  @override
  String get curCity {
    _$curCityAtom.reportRead();
    return super.curCity;
  }

  @override
  set curCity(String value) {
    _$curCityAtom.reportWrite(value, super.curCity, () {
      super.curCity = value;
    });
  }

  final _$onSearchTextChangedAsyncAction =
      AsyncAction('_QuranStoreBase.onSearchTextChanged');

  @override
  Future<dynamic> onSearchTextChanged(String text) {
    return _$onSearchTextChangedAsyncAction
        .run(() => super.onSearchTextChanged(text));
  }

  final _$getPrayerTimeAsyncAction =
      AsyncAction('_QuranStoreBase.getPrayerTime');

  @override
  Future<dynamic> getPrayerTime(double lon, double lat) {
    return _$getPrayerTimeAsyncAction.run(() => super.getPrayerTime(lon, lat));
  }

  final _$getSurahsAsyncAction = AsyncAction('_QuranStoreBase.getSurahs');

  @override
  Future<dynamic> getSurahs() {
    return _$getSurahsAsyncAction.run(() => super.getSurahs());
  }

  final _$saveBookmarkSurahAsyncAction =
      AsyncAction('_QuranStoreBase.saveBookmarkSurah');

  @override
  Future<dynamic> saveBookmarkSurah(DataSurah surah) {
    return _$saveBookmarkSurahAsyncAction
        .run(() => super.saveBookmarkSurah(surah));
  }

  final _$deleteBookmarkSurahAsyncAction =
      AsyncAction('_QuranStoreBase.deleteBookmarkSurah');

  @override
  Future<dynamic> deleteBookmarkSurah(DataSurah surah) {
    return _$deleteBookmarkSurahAsyncAction
        .run(() => super.deleteBookmarkSurah(surah));
  }

  final _$getBookmarkListAsyncAction =
      AsyncAction('_QuranStoreBase.getBookmarkList');

  @override
  Future<dynamic> getBookmarkList() {
    return _$getBookmarkListAsyncAction.run(() => super.getBookmarkList());
  }

  final _$getBookmarkAsyncAction = AsyncAction('_QuranStoreBase.getBookmark');

  @override
  Future<dynamic> getBookmark(int numberAyahId) {
    return _$getBookmarkAsyncAction.run(() => super.getBookmark(numberAyahId));
  }

  final _$getAyahsAsyncAction = AsyncAction('_QuranStoreBase.getAyahs');

  @override
  Future<dynamic> getAyahs(int surahId) {
    return _$getAyahsAsyncAction.run(() => super.getAyahs(surahId));
  }

  final _$getAyahsTranslateAsyncAction =
      AsyncAction('_QuranStoreBase.getAyahsTranslate');

  @override
  Future<dynamic> getAyahsTranslate(int surahId) {
    return _$getAyahsTranslateAsyncAction
        .run(() => super.getAyahsTranslate(surahId));
  }

  final _$_QuranStoreBaseActionController =
      ActionController(name: '_QuranStoreBase');

  @override
  void setSelectionTab(int value) {
    final _$actionInfo = _$_QuranStoreBaseActionController.startAction(
        name: '_QuranStoreBase.setSelectionTab');
    try {
      return super.setSelectionTab(value);
    } finally {
      _$_QuranStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchSurahsFuture: ${fetchSurahsFuture},
fetchPrayerFuture: ${fetchPrayerFuture},
fetchBookmarksListFuture: ${fetchBookmarksListFuture},
fetchBookmarkFuture: ${fetchBookmarkFuture},
fetchAyahsFuture: ${fetchAyahsFuture},
fetchAyahsTranslateFuture: ${fetchAyahsTranslateFuture},
bookmarkData: ${bookmarkData},
surahs: ${surahs},
prayer: ${prayer},
curTime: ${curTime},
curPrayer: ${curPrayer},
curTimePrayer: ${curTimePrayer},
fajr: ${fajr},
dhuhr: ${dhuhr},
ashr: ${ashr},
maghrib: ${maghrib},
isya: ${isya},
ayahs: ${ayahs},
selectedButton: ${selectedButton},
indexBookmark: ${indexBookmark},
ayahListData: ${ayahListData},
ayahTranslateListData: ${ayahTranslateListData},
surahListData: ${surahListData},
surahListBookmark: ${surahListBookmark},
searchSurahList: ${searchSurahList},
success: ${success},
deleteSurah: ${deleteSurah},
loadBookmarkList: ${loadBookmarkList},
loadBookmark: ${loadBookmark},
isSaveBookmark: ${isSaveBookmark},
successPrayerLoad: ${successPrayerLoad},
lat: ${lat},
lon: ${lon},
curLocation: ${curLocation},
curCity: ${curCity},
isLocationNotEmpty: ${isLocationNotEmpty},
isSurahsEmpty: ${isSurahsEmpty},
isSearchListEmpty: ${isSearchListEmpty},
isAyahsEmpty: ${isAyahsEmpty},
isAyahsTranslateEmpty: ${isAyahsTranslateEmpty},
loadingSurah: ${loadingSurah},
loadingAyah: ${loadingAyah},
loadingAyahTranslate: ${loadingAyahTranslate}
    ''';
  }
}
