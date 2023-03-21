// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BookingStore on _BookingStoreBase, Store {
  Computed<int> _$totalAmountComputed;

  @override
  int get totalAmount =>
      (_$totalAmountComputed ??= Computed<int>(() => super.totalAmount,
              name: '_BookingStoreBase.totalAmount'))
          .value;
  Computed<bool> _$canBookingComputed;

  @override
  bool get canBooking =>
      (_$canBookingComputed ??= Computed<bool>(() => super.canBooking,
              name: '_BookingStoreBase.canBooking'))
          .value;

  final _$fetchBookingFutureAtom =
      Atom(name: '_BookingStoreBase.fetchBookingFuture');

  @override
  ObservableFuture<Invoice> get fetchBookingFuture {
    _$fetchBookingFutureAtom.reportRead();
    return super.fetchBookingFuture;
  }

  @override
  set fetchBookingFuture(ObservableFuture<Invoice> value) {
    _$fetchBookingFutureAtom.reportWrite(value, super.fetchBookingFuture, () {
      super.fetchBookingFuture = value;
    });
  }

  final _$nameJamaahAtom = Atom(name: '_BookingStoreBase.nameJamaah');

  @override
  String get nameJamaah {
    _$nameJamaahAtom.reportRead();
    return super.nameJamaah;
  }

  @override
  set nameJamaah(String value) {
    _$nameJamaahAtom.reportWrite(value, super.nameJamaah, () {
      super.nameJamaah = value;
    });
  }

  final _$dropdownVariantAtom = Atom(name: '_BookingStoreBase.dropdownVariant');

  @override
  String get dropdownVariant {
    _$dropdownVariantAtom.reportRead();
    return super.dropdownVariant;
  }

  @override
  set dropdownVariant(String value) {
    _$dropdownVariantAtom.reportWrite(value, super.dropdownVariant, () {
      super.dropdownVariant = value;
    });
  }

  final _$variantAtom = Atom(name: '_BookingStoreBase.variant');

  @override
  Variants get variant {
    _$variantAtom.reportRead();
    return super.variant;
  }

  @override
  set variant(Variants value) {
    _$variantAtom.reportWrite(value, super.variant, () {
      super.variant = value;
    });
  }

  final _$jamaahAtom = Atom(name: '_BookingStoreBase.jamaah');

  @override
  Jamaah get jamaah {
    _$jamaahAtom.reportRead();
    return super.jamaah;
  }

  @override
  set jamaah(Jamaah value) {
    _$jamaahAtom.reportWrite(value, super.jamaah, () {
      super.jamaah = value;
    });
  }

  final _$invoiceAtom = Atom(name: '_BookingStoreBase.invoice');

  @override
  Invoice get invoice {
    _$invoiceAtom.reportRead();
    return super.invoice;
  }

  @override
  set invoice(Invoice value) {
    _$invoiceAtom.reportWrite(value, super.invoice, () {
      super.invoice = value;
    });
  }

  final _$totalAtom = Atom(name: '_BookingStoreBase.total');

  @override
  int get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(int value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$totalFeeAtom = Atom(name: '_BookingStoreBase.totalFee');

  @override
  int get totalFee {
    _$totalFeeAtom.reportRead();
    return super.totalFee;
  }

  @override
  set totalFee(int value) {
    _$totalFeeAtom.reportWrite(value, super.totalFee, () {
      super.totalFee = value;
    });
  }

  final _$successAtom = Atom(name: '_BookingStoreBase.success');

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

  final _$loadingAtom = Atom(name: '_BookingStoreBase.loading');

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

  final _$loadingVariantFeesAtom =
      Atom(name: '_BookingStoreBase.loadingVariantFees');

  @override
  bool get loadingVariantFees {
    _$loadingVariantFeesAtom.reportRead();
    return super.loadingVariantFees;
  }

  @override
  set loadingVariantFees(bool value) {
    _$loadingVariantFeesAtom.reportWrite(value, super.loadingVariantFees, () {
      super.loadingVariantFees = value;
    });
  }

  final _$switchIsJamaahAtom = Atom(name: '_BookingStoreBase.switchIsJamaah');

  @override
  bool get switchIsJamaah {
    _$switchIsJamaahAtom.reportRead();
    return super.switchIsJamaah;
  }

  @override
  set switchIsJamaah(bool value) {
    _$switchIsJamaahAtom.reportWrite(value, super.switchIsJamaah, () {
      super.switchIsJamaah = value;
    });
  }

  final _$listJamaahAtom = Atom(name: '_BookingStoreBase.listJamaah');

  @override
  ObservableList<Jamaah> get listJamaah {
    _$listJamaahAtom.reportRead();
    return super.listJamaah;
  }

  @override
  set listJamaah(ObservableList<Jamaah> value) {
    _$listJamaahAtom.reportWrite(value, super.listJamaah, () {
      super.listJamaah = value;
    });
  }

  final _$listPaketAtom = Atom(name: '_BookingStoreBase.listPaket');

  @override
  Map<dynamic, dynamic> get listPaket {
    _$listPaketAtom.reportRead();
    return super.listPaket;
  }

  @override
  set listPaket(Map<dynamic, dynamic> value) {
    _$listPaketAtom.reportWrite(value, super.listPaket, () {
      super.listPaket = value;
    });
  }

  final _$bookingNowAsyncAction = AsyncAction('_BookingStoreBase.bookingNow');

  @override
  Future<dynamic> bookingNow(
      String listingId, String userName, String userEmail, String userPhone) {
    return _$bookingNowAsyncAction
        .run(() => super.bookingNow(listingId, userName, userEmail, userPhone));
  }

  final _$_BookingStoreBaseActionController =
      ActionController(name: '_BookingStoreBase');

  @override
  void addJamaah() {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.addJamaah');
    try {
      return super.addJamaah();
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeJamaah(Jamaah jamaah) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.removeJamaah');
    try {
      return super.removeJamaah(jamaah);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVariant(dynamic value) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.setVariant');
    try {
      return super.setVariant(value);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setJamaah(dynamic value) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.setJamaah');
    try {
      return super.setJamaah(value);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameJamaah(dynamic value) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.setNameJamaah');
    try {
      return super.setNameJamaah(value);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSwitchJamaah(dynamic value) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.setSwitchJamaah');
    try {
      return super.setSwitchJamaah(value);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDropdownVariant(dynamic value) {
    final _$actionInfo = _$_BookingStoreBaseActionController.startAction(
        name: '_BookingStoreBase.setDropdownVariant');
    try {
      return super.setDropdownVariant(value);
    } finally {
      _$_BookingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchBookingFuture: ${fetchBookingFuture},
nameJamaah: ${nameJamaah},
dropdownVariant: ${dropdownVariant},
variant: ${variant},
jamaah: ${jamaah},
invoice: ${invoice},
total: ${total},
totalFee: ${totalFee},
success: ${success},
loading: ${loading},
loadingVariantFees: ${loadingVariantFees},
switchIsJamaah: ${switchIsJamaah},
listJamaah: ${listJamaah},
listPaket: ${listPaket},
totalAmount: ${totalAmount},
canBooking: ${canBooking}
    ''';
  }
}
