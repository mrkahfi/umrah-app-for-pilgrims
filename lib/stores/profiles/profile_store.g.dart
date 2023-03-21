// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<bool> _$isProfileEmptyComputed;

  @override
  bool get isProfileEmpty =>
      (_$isProfileEmptyComputed ??= Computed<bool>(() => super.isProfileEmpty,
              name: '_ProfileStoreBase.isProfileEmpty'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ProfileStoreBase.loading'))
      .value;

  final _$fetchProfileFutureAtom =
      Atom(name: '_ProfileStoreBase.fetchProfileFuture');

  @override
  ObservableFuture<Profile> get fetchProfileFuture {
    _$fetchProfileFutureAtom.reportRead();
    return super.fetchProfileFuture;
  }

  @override
  set fetchProfileFuture(ObservableFuture<Profile> value) {
    _$fetchProfileFutureAtom.reportWrite(value, super.fetchProfileFuture, () {
      super.fetchProfileFuture = value;
    });
  }

  final _$fetchProfilesFutureAtom =
      Atom(name: '_ProfileStoreBase.fetchProfilesFuture');

  @override
  ObservableFuture<ProfileList> get fetchProfilesFuture {
    _$fetchProfilesFutureAtom.reportRead();
    return super.fetchProfilesFuture;
  }

  @override
  set fetchProfilesFuture(ObservableFuture<ProfileList> value) {
    _$fetchProfilesFutureAtom.reportWrite(value, super.fetchProfilesFuture, () {
      super.fetchProfilesFuture = value;
    });
  }

  final _$fetchUserFutureAtom = Atom(name: '_ProfileStoreBase.fetchUserFuture');

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

  final _$profileListDataAtom = Atom(name: '_ProfileStoreBase.profileListData');

  @override
  ObservableList<Profile> get profileListData {
    _$profileListDataAtom.reportRead();
    return super.profileListData;
  }

  @override
  set profileListData(ObservableList<Profile> value) {
    _$profileListDataAtom.reportWrite(value, super.profileListData, () {
      super.profileListData = value;
    });
  }

  final _$profilesAtom = Atom(name: '_ProfileStoreBase.profiles');

  @override
  Profile get profiles {
    _$profilesAtom.reportRead();
    return super.profiles;
  }

  @override
  set profiles(Profile value) {
    _$profilesAtom.reportWrite(value, super.profiles, () {
      super.profiles = value;
    });
  }

  final _$selectedProfileAtom = Atom(name: '_ProfileStoreBase.selectedProfile');

  @override
  int get selectedProfile {
    _$selectedProfileAtom.reportRead();
    return super.selectedProfile;
  }

  @override
  set selectedProfile(int value) {
    _$selectedProfileAtom.reportWrite(value, super.selectedProfile, () {
      super.selectedProfile = value;
    });
  }

  final _$userAtom = Atom(name: '_ProfileStoreBase.user');

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

  final _$successAtom = Atom(name: '_ProfileStoreBase.success');

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

  final _$profileLoadedAtom = Atom(name: '_ProfileStoreBase.profileLoaded');

  @override
  bool get profileLoaded {
    _$profileLoadedAtom.reportRead();
    return super.profileLoaded;
  }

  @override
  set profileLoaded(bool value) {
    _$profileLoadedAtom.reportWrite(value, super.profileLoaded, () {
      super.profileLoaded = value;
    });
  }

  final _$infoSelfAtom = Atom(name: '_ProfileStoreBase.infoSelf');

  @override
  ObservableList<dynamic> get infoSelf {
    _$infoSelfAtom.reportRead();
    return super.infoSelf;
  }

  @override
  set infoSelf(ObservableList<dynamic> value) {
    _$infoSelfAtom.reportWrite(value, super.infoSelf, () {
      super.infoSelf = value;
    });
  }

  final _$infoContactAtom = Atom(name: '_ProfileStoreBase.infoContact');

  @override
  ObservableList<dynamic> get infoContact {
    _$infoContactAtom.reportRead();
    return super.infoContact;
  }

  @override
  set infoContact(ObservableList<dynamic> value) {
    _$infoContactAtom.reportWrite(value, super.infoContact, () {
      super.infoContact = value;
    });
  }

  final _$infoDocumentAtom = Atom(name: '_ProfileStoreBase.infoDocument');

  @override
  ObservableList<dynamic> get infoDocument {
    _$infoDocumentAtom.reportRead();
    return super.infoDocument;
  }

  @override
  set infoDocument(ObservableList<dynamic> value) {
    _$infoDocumentAtom.reportWrite(value, super.infoDocument, () {
      super.infoDocument = value;
    });
  }

  final _$infoFamilyAtom = Atom(name: '_ProfileStoreBase.infoFamily');

  @override
  ObservableList<dynamic> get infoFamily {
    _$infoFamilyAtom.reportRead();
    return super.infoFamily;
  }

  @override
  set infoFamily(ObservableList<dynamic> value) {
    _$infoFamilyAtom.reportWrite(value, super.infoFamily, () {
      super.infoFamily = value;
    });
  }

  final _$infoStatusAtom = Atom(name: '_ProfileStoreBase.infoStatus');

  @override
  ObservableList<dynamic> get infoStatus {
    _$infoStatusAtom.reportRead();
    return super.infoStatus;
  }

  @override
  set infoStatus(ObservableList<dynamic> value) {
    _$infoStatusAtom.reportWrite(value, super.infoStatus, () {
      super.infoStatus = value;
    });
  }

  final _$getProfilesAsyncAction = AsyncAction('_ProfileStoreBase.getProfiles');

  @override
  Future<dynamic> getProfiles() {
    return _$getProfilesAsyncAction.run(() => super.getProfiles());
  }

  final _$getProfileAsyncAction = AsyncAction('_ProfileStoreBase.getProfile');

  @override
  Future<dynamic> getProfile(String slug) {
    return _$getProfileAsyncAction.run(() => super.getProfile(slug));
  }

  final _$getUserAsyncAction = AsyncAction('_ProfileStoreBase.getUser');

  @override
  Future<dynamic> getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  final _$_ProfileStoreBaseActionController =
      ActionController(name: '_ProfileStoreBase');

  @override
  void setProfileLoaded(dynamic value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setProfileLoaded');
    try {
      return super.setProfileLoaded(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedProfile(dynamic value) {
    final _$actionInfo = _$_ProfileStoreBaseActionController.startAction(
        name: '_ProfileStoreBase.setSelectedProfile');
    try {
      return super.setSelectedProfile(value);
    } finally {
      _$_ProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchProfileFuture: ${fetchProfileFuture},
fetchProfilesFuture: ${fetchProfilesFuture},
fetchUserFuture: ${fetchUserFuture},
profileListData: ${profileListData},
profiles: ${profiles},
selectedProfile: ${selectedProfile},
user: ${user},
success: ${success},
profileLoaded: ${profileLoaded},
infoSelf: ${infoSelf},
infoContact: ${infoContact},
infoDocument: ${infoDocument},
infoFamily: ${infoFamily},
infoStatus: ${infoStatus},
isProfileEmpty: ${isProfileEmpty},
loading: ${loading}
    ''';
  }
}
