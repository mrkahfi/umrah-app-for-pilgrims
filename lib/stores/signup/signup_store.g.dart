// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStoreBase, Store {
  Computed<bool> _$canSignUpComputed;

  @override
  bool get canSignUp =>
      (_$canSignUpComputed ??= Computed<bool>(() => super.canSignUp,
              name: '_SignUpStoreBase.canSignUp'))
          .value;

  final _$fetchUserFutureAtom = Atom(name: '_SignUpStoreBase.fetchUserFuture');

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

  final _$emailAtom = Atom(name: '_SignUpStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$fullnameAtom = Atom(name: '_SignUpStoreBase.fullname');

  @override
  String get fullname {
    _$fullnameAtom.reportRead();
    return super.fullname;
  }

  @override
  set fullname(String value) {
    _$fullnameAtom.reportWrite(value, super.fullname, () {
      super.fullname = value;
    });
  }

  final _$phoneAtom = Atom(name: '_SignUpStoreBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$successAtom = Atom(name: '_SignUpStoreBase.success');

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

  final _$loadingAtom = Atom(name: '_SignUpStoreBase.loading');

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

  final _$userAtom = Atom(name: '_SignUpStoreBase.user');

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

  final _$branchAtom = Atom(name: '_SignUpStoreBase.branch');

  @override
  EndpointsAPI get branch {
    _$branchAtom.reportRead();
    return super.branch;
  }

  @override
  set branch(EndpointsAPI value) {
    _$branchAtom.reportWrite(value, super.branch, () {
      super.branch = value;
    });
  }

  final _$signUpAsyncAction = AsyncAction('_SignUpStoreBase.signUp');

  @override
  Future<dynamic> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  final _$_SignUpStoreBaseActionController =
      ActionController(name: '_SignUpStoreBase');

  @override
  void setBranch(dynamic value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setBranch');
    try {
      return super.setBranch(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFullname(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setFullname');
    try {
      return super.setFullname(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchUserFuture: ${fetchUserFuture},
email: ${email},
fullname: ${fullname},
phone: ${phone},
success: ${success},
loading: ${loading},
user: ${user},
branch: ${branch},
canSignUp: ${canSignUp}
    ''';
  }
}
