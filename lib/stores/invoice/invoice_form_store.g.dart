// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InvoiceFormStore on _InvoiceFormStoreBase, Store {
  Computed<ObservableList<String>> _$listDropdownBankComputed;

  @override
  ObservableList<String> get listDropdownBank => (_$listDropdownBankComputed ??=
          Computed<ObservableList<String>>(() => super.listDropdownBank,
              name: '_InvoiceFormStoreBase.listDropdownBank'))
      .value;
  Computed<bool> _$haslistDropdownBankComputed;

  @override
  bool get haslistDropdownBank => (_$haslistDropdownBankComputed ??=
          Computed<bool>(() => super.haslistDropdownBank,
              name: '_InvoiceFormStoreBase.haslistDropdownBank'))
      .value;

  final _$bankIdAtom = Atom(name: '_InvoiceFormStoreBase.bankId');

  @override
  int get bankId {
    _$bankIdAtom.reportRead();
    return super.bankId;
  }

  @override
  set bankId(int value) {
    _$bankIdAtom.reportWrite(value, super.bankId, () {
      super.bankId = value;
    });
  }

  final _$tipeAtom = Atom(name: '_InvoiceFormStoreBase.tipe');

  @override
  String get tipe {
    _$tipeAtom.reportRead();
    return super.tipe;
  }

  @override
  set tipe(String value) {
    _$tipeAtom.reportWrite(value, super.tipe, () {
      super.tipe = value;
    });
  }

  final _$noteAtom = Atom(name: '_InvoiceFormStoreBase.note');

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$currencyAtom = Atom(name: '_InvoiceFormStoreBase.currency');

  @override
  String get currency {
    _$currencyAtom.reportRead();
    return super.currency;
  }

  @override
  set currency(String value) {
    _$currencyAtom.reportWrite(value, super.currency, () {
      super.currency = value;
    });
  }

  final _$channelBankAtom = Atom(name: '_InvoiceFormStoreBase.channelBank');

  @override
  String get channelBank {
    _$channelBankAtom.reportRead();
    return super.channelBank;
  }

  @override
  set channelBank(String value) {
    _$channelBankAtom.reportWrite(value, super.channelBank, () {
      super.channelBank = value;
    });
  }

  final _$strukAtom = Atom(name: '_InvoiceFormStoreBase.struk');

  @override
  File get struk {
    _$strukAtom.reportRead();
    return super.struk;
  }

  @override
  set struk(File value) {
    _$strukAtom.reportWrite(value, super.struk, () {
      super.struk = value;
    });
  }

  final _$invoicePaymentAtom =
      Atom(name: '_InvoiceFormStoreBase.invoicePayment');

  @override
  Payment get invoicePayment {
    _$invoicePaymentAtom.reportRead();
    return super.invoicePayment;
  }

  @override
  set invoicePayment(Payment value) {
    _$invoicePaymentAtom.reportWrite(value, super.invoicePayment, () {
      super.invoicePayment = value;
    });
  }

  final _$successAtom = Atom(name: '_InvoiceFormStoreBase.success');

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

  final _$loadingAtom = Atom(name: '_InvoiceFormStoreBase.loading');

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

  final _$fetchPaymentFutureAtom =
      Atom(name: '_InvoiceFormStoreBase.fetchPaymentFuture');

  @override
  ObservableFuture<Payment> get fetchPaymentFuture {
    _$fetchPaymentFutureAtom.reportRead();
    return super.fetchPaymentFuture;
  }

  @override
  set fetchPaymentFuture(ObservableFuture<Payment> value) {
    _$fetchPaymentFutureAtom.reportWrite(value, super.fetchPaymentFuture, () {
      super.fetchPaymentFuture = value;
    });
  }

  final _$rekBankAtom = Atom(name: '_InvoiceFormStoreBase.rekBank');

  @override
  String get rekBank {
    _$rekBankAtom.reportRead();
    return super.rekBank;
  }

  @override
  set rekBank(String value) {
    _$rekBankAtom.reportWrite(value, super.rekBank, () {
      super.rekBank = value;
    });
  }

  final _$totalAtom = Atom(name: '_InvoiceFormStoreBase.total');

  @override
  String get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(String value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$typeAtom = Atom(name: '_InvoiceFormStoreBase.type');

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$dropdownBankAtom = Atom(name: '_InvoiceFormStoreBase.dropdownBank');

  @override
  List<String> get dropdownBank {
    _$dropdownBankAtom.reportRead();
    return super.dropdownBank;
  }

  @override
  set dropdownBank(List<String> value) {
    _$dropdownBankAtom.reportWrite(value, super.dropdownBank, () {
      super.dropdownBank = value;
    });
  }

  final _$dropdownTypeAtom = Atom(name: '_InvoiceFormStoreBase.dropdownType');

  @override
  List<String> get dropdownType {
    _$dropdownTypeAtom.reportRead();
    return super.dropdownType;
  }

  @override
  set dropdownType(List<String> value) {
    _$dropdownTypeAtom.reportWrite(value, super.dropdownType, () {
      super.dropdownType = value;
    });
  }

  final _$dropdownChannelAtom =
      Atom(name: '_InvoiceFormStoreBase.dropdownChannel');

  @override
  List<String> get dropdownChannel {
    _$dropdownChannelAtom.reportRead();
    return super.dropdownChannel;
  }

  @override
  set dropdownChannel(List<String> value) {
    _$dropdownChannelAtom.reportWrite(value, super.dropdownChannel, () {
      super.dropdownChannel = value;
    });
  }

  final _$dropdownCurrencyAtom =
      Atom(name: '_InvoiceFormStoreBase.dropdownCurrency');

  @override
  List<String> get dropdownCurrency {
    _$dropdownCurrencyAtom.reportRead();
    return super.dropdownCurrency;
  }

  @override
  set dropdownCurrency(List<String> value) {
    _$dropdownCurrencyAtom.reportWrite(value, super.dropdownCurrency, () {
      super.dropdownCurrency = value;
    });
  }

  final _$konfirmasiAsyncAction =
      AsyncAction('_InvoiceFormStoreBase.konfirmasi');

  @override
  Future<dynamic> konfirmasi(String id, bool isMidtrans) {
    return _$konfirmasiAsyncAction.run(() => super.konfirmasi(id, isMidtrans));
  }

  final _$_InvoiceFormStoreBaseActionController =
      ActionController(name: '_InvoiceFormStoreBase');

  @override
  void setRekBank(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setRekBank');
    try {
      return super.setRekBank(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrency(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setCurrency');
    try {
      return super.setCurrency(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChannel(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setChannel');
    try {
      return super.setChannel(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBankId(int value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setBankId');
    try {
      return super.setBankId(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotal(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setTotal');
    try {
      return super.setTotal(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setType(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setType');
    try {
      return super.setType(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNote(String value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setNote');
    try {
      return super.setNote(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStruk(File value) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setStruk');
    try {
      return super.setStruk(value);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDropdownValue(ObservableList<Bank> bankList) {
    final _$actionInfo = _$_InvoiceFormStoreBaseActionController.startAction(
        name: '_InvoiceFormStoreBase.setDropdownValue');
    try {
      return super.setDropdownValue(bankList);
    } finally {
      _$_InvoiceFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bankId: ${bankId},
tipe: ${tipe},
note: ${note},
currency: ${currency},
channelBank: ${channelBank},
struk: ${struk},
invoicePayment: ${invoicePayment},
success: ${success},
loading: ${loading},
fetchPaymentFuture: ${fetchPaymentFuture},
rekBank: ${rekBank},
total: ${total},
type: ${type},
dropdownBank: ${dropdownBank},
dropdownType: ${dropdownType},
dropdownChannel: ${dropdownChannel},
dropdownCurrency: ${dropdownCurrency},
listDropdownBank: ${listDropdownBank},
haslistDropdownBank: ${haslistDropdownBank}
    ''';
  }
}
