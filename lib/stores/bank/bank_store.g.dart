// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BankStore on _BankStoreBase, Store {
  Computed<bool> _$isBankEmptyComputed;

  @override
  bool get isBankEmpty =>
      (_$isBankEmptyComputed ??= Computed<bool>(() => super.isBankEmpty,
              name: '_BankStoreBase.isBankEmpty'))
          .value;

  final _$fetchBanksFutureAtom = Atom(name: '_BankStoreBase.fetchBanksFuture');

  @override
  ObservableFuture<BankList> get fetchBanksFuture {
    _$fetchBanksFutureAtom.reportRead();
    return super.fetchBanksFuture;
  }

  @override
  set fetchBanksFuture(ObservableFuture<BankList> value) {
    _$fetchBanksFutureAtom.reportWrite(value, super.fetchBanksFuture, () {
      super.fetchBanksFuture = value;
    });
  }

  final _$bankAtom = Atom(name: '_BankStoreBase.bank');

  @override
  Bank get bank {
    _$bankAtom.reportRead();
    return super.bank;
  }

  @override
  set bank(Bank value) {
    _$bankAtom.reportWrite(value, super.bank, () {
      super.bank = value;
    });
  }

  final _$bankListDataAtom = Atom(name: '_BankStoreBase.bankListData');

  @override
  ObservableList<Bank> get bankListData {
    _$bankListDataAtom.reportRead();
    return super.bankListData;
  }

  @override
  set bankListData(ObservableList<Bank> value) {
    _$bankListDataAtom.reportWrite(value, super.bankListData, () {
      super.bankListData = value;
    });
  }

  final _$successAtom = Atom(name: '_BankStoreBase.success');

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

  final _$loadingAtom = Atom(name: '_BankStoreBase.loading');

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

  final _$getBanksAsyncAction = AsyncAction('_BankStoreBase.getBanks');

  @override
  Future<dynamic> getBanks() {
    return _$getBanksAsyncAction.run(() => super.getBanks());
  }

  @override
  String toString() {
    return '''
fetchBanksFuture: ${fetchBanksFuture},
bank: ${bank},
bankListData: ${bankListData},
success: ${success},
loading: ${loading},
isBankEmpty: ${isBankEmpty}
    ''';
  }
}
