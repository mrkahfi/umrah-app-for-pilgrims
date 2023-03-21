// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GalleryStore on _GalleryStoreBase, Store {
  Computed<bool> _$isGalleryEmptyComputed;

  @override
  bool get isGalleryEmpty =>
      (_$isGalleryEmptyComputed ??= Computed<bool>(() => super.isGalleryEmpty,
              name: '_GalleryStoreBase.isGalleryEmpty'))
          .value;
  Computed<bool> _$isTestimonialEmptyComputed;

  @override
  bool get isTestimonialEmpty => (_$isTestimonialEmptyComputed ??=
          Computed<bool>(() => super.isTestimonialEmpty,
              name: '_GalleryStoreBase.isTestimonialEmpty'))
      .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_GalleryStoreBase.loading'))
      .value;
  Computed<bool> _$loadingTestimonialComputed;

  @override
  bool get loadingTestimonial => (_$loadingTestimonialComputed ??=
          Computed<bool>(() => super.loadingTestimonial,
              name: '_GalleryStoreBase.loadingTestimonial'))
      .value;

  final _$fetchGallerysFutureAtom =
      Atom(name: '_GalleryStoreBase.fetchGallerysFuture');

  @override
  ObservableFuture<GalleryList> get fetchGallerysFuture {
    _$fetchGallerysFutureAtom.reportRead();
    return super.fetchGallerysFuture;
  }

  @override
  set fetchGallerysFuture(ObservableFuture<GalleryList> value) {
    _$fetchGallerysFutureAtom.reportWrite(value, super.fetchGallerysFuture, () {
      super.fetchGallerysFuture = value;
    });
  }

  final _$fetchTestimonialFutureAtom =
      Atom(name: '_GalleryStoreBase.fetchTestimonialFuture');

  @override
  ObservableFuture<GalleryList> get fetchTestimonialFuture {
    _$fetchTestimonialFutureAtom.reportRead();
    return super.fetchTestimonialFuture;
  }

  @override
  set fetchTestimonialFuture(ObservableFuture<GalleryList> value) {
    _$fetchTestimonialFutureAtom
        .reportWrite(value, super.fetchTestimonialFuture, () {
      super.fetchTestimonialFuture = value;
    });
  }

  final _$galleryAtom = Atom(name: '_GalleryStoreBase.gallery');

  @override
  Gallery get gallery {
    _$galleryAtom.reportRead();
    return super.gallery;
  }

  @override
  set gallery(Gallery value) {
    _$galleryAtom.reportWrite(value, super.gallery, () {
      super.gallery = value;
    });
  }

  final _$indicatorCurrentAtom =
      Atom(name: '_GalleryStoreBase.indicatorCurrent');

  @override
  int get indicatorCurrent {
    _$indicatorCurrentAtom.reportRead();
    return super.indicatorCurrent;
  }

  @override
  set indicatorCurrent(int value) {
    _$indicatorCurrentAtom.reportWrite(value, super.indicatorCurrent, () {
      super.indicatorCurrent = value;
    });
  }

  final _$selectedButtonAtom = Atom(name: '_GalleryStoreBase.selectedButton');

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

  final _$galleryListDataAtom = Atom(name: '_GalleryStoreBase.galleryListData');

  @override
  ObservableList<Gallery> get galleryListData {
    _$galleryListDataAtom.reportRead();
    return super.galleryListData;
  }

  @override
  set galleryListData(ObservableList<Gallery> value) {
    _$galleryListDataAtom.reportWrite(value, super.galleryListData, () {
      super.galleryListData = value;
    });
  }

  final _$galleryListTestimonialAtom =
      Atom(name: '_GalleryStoreBase.galleryListTestimonial');

  @override
  ObservableList<Gallery> get galleryListTestimonial {
    _$galleryListTestimonialAtom.reportRead();
    return super.galleryListTestimonial;
  }

  @override
  set galleryListTestimonial(ObservableList<Gallery> value) {
    _$galleryListTestimonialAtom
        .reportWrite(value, super.galleryListTestimonial, () {
      super.galleryListTestimonial = value;
    });
  }

  final _$galleryListSelectedAtom =
      Atom(name: '_GalleryStoreBase.galleryListSelected');

  @override
  ObservableList<Gallery> get galleryListSelected {
    _$galleryListSelectedAtom.reportRead();
    return super.galleryListSelected;
  }

  @override
  set galleryListSelected(ObservableList<Gallery> value) {
    _$galleryListSelectedAtom.reportWrite(value, super.galleryListSelected, () {
      super.galleryListSelected = value;
    });
  }

  final _$successAtom = Atom(name: '_GalleryStoreBase.success');

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

  final _$getGalleriesAsyncAction =
      AsyncAction('_GalleryStoreBase.getGalleries');

  @override
  Future<dynamic> getGalleries() {
    return _$getGalleriesAsyncAction.run(() => super.getGalleries());
  }

  final _$getTestimonialsAsyncAction =
      AsyncAction('_GalleryStoreBase.getTestimonials');

  @override
  Future<dynamic> getTestimonials() {
    return _$getTestimonialsAsyncAction.run(() => super.getTestimonials());
  }

  final _$_GalleryStoreBaseActionController =
      ActionController(name: '_GalleryStoreBase');

  @override
  void setCurrentDotIndicator(dynamic value) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.setCurrentDotIndicator');
    try {
      return super.setCurrentDotIndicator(value);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectionTab(int value) {
    final _$actionInfo = _$_GalleryStoreBaseActionController.startAction(
        name: '_GalleryStoreBase.setSelectionTab');
    try {
      return super.setSelectionTab(value);
    } finally {
      _$_GalleryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchGallerysFuture: ${fetchGallerysFuture},
fetchTestimonialFuture: ${fetchTestimonialFuture},
gallery: ${gallery},
indicatorCurrent: ${indicatorCurrent},
selectedButton: ${selectedButton},
galleryListData: ${galleryListData},
galleryListTestimonial: ${galleryListTestimonial},
galleryListSelected: ${galleryListSelected},
success: ${success},
isGalleryEmpty: ${isGalleryEmpty},
isTestimonialEmpty: ${isTestimonialEmpty},
loading: ${loading},
loadingTestimonial: ${loadingTestimonial}
    ''';
  }
}
