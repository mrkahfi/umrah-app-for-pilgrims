// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStoreBase, Store {
  Computed<bool> _$userIsEmptyComputed;

  @override
  bool get userIsEmpty =>
      (_$userIsEmptyComputed ??= Computed<bool>(() => super.userIsEmpty,
              name: '_UserStoreBase.userIsEmpty'))
          .value;

  final _$fetchUserFutureAtom = Atom(name: '_UserStoreBase.fetchUserFuture');

  @override
  ObservableFuture<Users> get fetchUserFuture {
    _$fetchUserFutureAtom.reportRead();
    return super.fetchUserFuture;
  }

  @override
  set fetchUserFuture(ObservableFuture<Users> value) {
    _$fetchUserFutureAtom.reportWrite(value, super.fetchUserFuture, () {
      super.fetchUserFuture = value;
    });
  }

  final _$userAtom = Atom(name: '_UserStoreBase.user');

  @override
  Users get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(Users value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStoreBase.success');

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

  final _$loadUserAtom = Atom(name: '_UserStoreBase.loadUser');

  @override
  bool get loadUser {
    _$loadUserAtom.reportRead();
    return super.loadUser;
  }

  @override
  set loadUser(bool value) {
    _$loadUserAtom.reportWrite(value, super.loadUser, () {
      super.loadUser = value;
    });
  }

  final _$deletedAtom = Atom(name: '_UserStoreBase.deleted');

  @override
  bool get deleted {
    _$deletedAtom.reportRead();
    return super.deleted;
  }

  @override
  set deleted(bool value) {
    _$deletedAtom.reportWrite(value, super.deleted, () {
      super.deleted = value;
    });
  }

  final _$isLoginAtom = Atom(name: '_UserStoreBase.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$isLoggedInAsyncAction = AsyncAction('_UserStoreBase.isLoggedIn');

  @override
  Future<dynamic> isLoggedIn() {
    return _$isLoggedInAsyncAction.run(() => super.isLoggedIn());
  }

  final _$getUserAsyncAction = AsyncAction('_UserStoreBase.getUser');

  @override
  Future<dynamic> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$logoutAsyncAction = AsyncAction('_UserStoreBase.logout');

  @override
  Future<dynamic> logout(Users user) {
    return _$logoutAsyncAction.run(() => super.logout(user));
  }

  @override
  String toString() {
    return '''
fetchUserFuture: ${fetchUserFuture},
user: ${user},
success: ${success},
loadUser: ${loadUser},
deleted: ${deleted},
isLogin: ${isLogin},
userIsEmpty: ${userIsEmpty}
    ''';
  }
}
