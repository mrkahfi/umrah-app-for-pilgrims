// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_confirm_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InvoiceConfirmStore on _InvoiceConfirmStoreBase, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_InvoiceConfirmStoreBase.loading'))
      .value;

  final _$fetchMidtransFutureAtom =
      Atom(name: '_InvoiceConfirmStoreBase.fetchMidtransFuture');

  @override
  ObservableFuture<Midtrans> get fetchMidtransFuture {
    _$fetchMidtransFutureAtom.reportRead();
    return super.fetchMidtransFuture;
  }

  @override
  set fetchMidtransFuture(ObservableFuture<Midtrans> value) {
    _$fetchMidtransFutureAtom.reportWrite(value, super.fetchMidtransFuture, () {
      super.fetchMidtransFuture = value;
    });
  }

  final _$midtransAtom = Atom(name: '_InvoiceConfirmStoreBase.midtrans');

  @override
  Midtrans get midtrans {
    _$midtransAtom.reportRead();
    return super.midtrans;
  }

  @override
  set midtrans(Midtrans value) {
    _$midtransAtom.reportWrite(value, super.midtrans, () {
      super.midtrans = value;
    });
  }

  final _$successAtom = Atom(name: '_InvoiceConfirmStoreBase.success');

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

  final _$getPaymentMidtransAsyncAction =
      AsyncAction('_InvoiceConfirmStoreBase.getPaymentMidtrans');

  @override
  Future<dynamic> getPaymentMidtrans(String slug) {
    return _$getPaymentMidtransAsyncAction
        .run(() => super.getPaymentMidtrans(slug));
  }

  @override
  String toString() {
    return '''
fetchMidtransFuture: ${fetchMidtransFuture},
midtrans: ${midtrans},
success: ${success},
loading: ${loading}
    ''';
  }
}
