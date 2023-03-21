// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InvoiceStore on _InvoiceStoreBase, Store {
  Computed<bool> _$isInvoiceEmptyComputed;

  @override
  bool get isInvoiceEmpty =>
      (_$isInvoiceEmptyComputed ??= Computed<bool>(() => super.isInvoiceEmpty,
              name: '_InvoiceStoreBase.isInvoiceEmpty'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_InvoiceStoreBase.loading'))
      .value;
  Computed<bool> _$loadingDetailComputed;

  @override
  bool get loadingDetail =>
      (_$loadingDetailComputed ??= Computed<bool>(() => super.loadingDetail,
              name: '_InvoiceStoreBase.loadingDetail'))
          .value;

  final _$fetchInvoicesListFutureAtom =
      Atom(name: '_InvoiceStoreBase.fetchInvoicesListFuture');

  @override
  ObservableFuture<InvoiceList> get fetchInvoicesListFuture {
    _$fetchInvoicesListFutureAtom.reportRead();
    return super.fetchInvoicesListFuture;
  }

  @override
  set fetchInvoicesListFuture(ObservableFuture<InvoiceList> value) {
    _$fetchInvoicesListFutureAtom
        .reportWrite(value, super.fetchInvoicesListFuture, () {
      super.fetchInvoicesListFuture = value;
    });
  }

  final _$fetchInvoicesFutureAtom =
      Atom(name: '_InvoiceStoreBase.fetchInvoicesFuture');

  @override
  ObservableFuture<Invoice> get fetchInvoicesFuture {
    _$fetchInvoicesFutureAtom.reportRead();
    return super.fetchInvoicesFuture;
  }

  @override
  set fetchInvoicesFuture(ObservableFuture<Invoice> value) {
    _$fetchInvoicesFutureAtom.reportWrite(value, super.fetchInvoicesFuture, () {
      super.fetchInvoicesFuture = value;
    });
  }

  final _$invoiceAtom = Atom(name: '_InvoiceStoreBase.invoice');

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

  final _$invoiceListDataAtom = Atom(name: '_InvoiceStoreBase.invoiceListData');

  @override
  ObservableList<Invoice> get invoiceListData {
    _$invoiceListDataAtom.reportRead();
    return super.invoiceListData;
  }

  @override
  set invoiceListData(ObservableList<Invoice> value) {
    _$invoiceListDataAtom.reportWrite(value, super.invoiceListData, () {
      super.invoiceListData = value;
    });
  }

  final _$listPaketAtom = Atom(name: '_InvoiceStoreBase.listPaket');

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

  final _$successAtom = Atom(name: '_InvoiceStoreBase.success');

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

  final _$getInvoicesAsyncAction = AsyncAction('_InvoiceStoreBase.getInvoices');

  @override
  Future<dynamic> getInvoices() {
    return _$getInvoicesAsyncAction.run(() => super.getInvoices());
  }

  final _$getInvoicesDetailAsyncAction =
      AsyncAction('_InvoiceStoreBase.getInvoicesDetail');

  @override
  Future<dynamic> getInvoicesDetail(String slug) {
    return _$getInvoicesDetailAsyncAction
        .run(() => super.getInvoicesDetail(slug));
  }

  @override
  String toString() {
    return '''
fetchInvoicesListFuture: ${fetchInvoicesListFuture},
fetchInvoicesFuture: ${fetchInvoicesFuture},
invoice: ${invoice},
invoiceListData: ${invoiceListData},
listPaket: ${listPaket},
success: ${success},
isInvoiceEmpty: ${isInvoiceEmpty},
loading: ${loading},
loadingDetail: ${loadingDetail}
    ''';
  }
}
