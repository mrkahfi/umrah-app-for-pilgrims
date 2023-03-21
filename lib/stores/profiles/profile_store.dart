import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _ProfileStoreBase(Repository repository) {
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<ProfileList> emptyProfilesResponse =
      ObservableFuture.value(null);

  static ObservableFuture<Users> emptyUserResponse =
      ObservableFuture.value(null);

  static ObservableFuture<Profile> emptyProfileResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Profile> fetchProfileFuture =
      ObservableFuture<Profile>(emptyProfileResponse);

  @observable
  ObservableFuture<ProfileList> fetchProfilesFuture =
      ObservableFuture<ProfileList>(emptyProfilesResponse);

  @observable
  ObservableFuture<Users> fetchUserFuture =
      ObservableFuture<Users>(emptyUserResponse);

  @observable
  ObservableList<Profile> profileListData = ObservableList<Profile>();

  @observable
  Profile profiles;

  @observable
  int selectedProfile = 1;

  @observable
  Users user;

  @observable
  bool success = false;

  @observable
  bool profileLoaded = false;

  @observable
  ObservableList infoSelf = new ObservableList();

  @observable
  ObservableList infoContact = new ObservableList();

  @observable
  ObservableList infoDocument = new ObservableList();

  @observable
  ObservableList infoFamily = new ObservableList();

  @observable
  ObservableList infoStatus = new ObservableList();

  @computed
  bool get isProfileEmpty => profileListData.isEmpty;

  @computed
  bool get loading => fetchProfilesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  void setProfileLoaded(value) => profileLoaded = value;

  @action
  void setSelectedProfile(value) => selectedProfile = value;

  @action
  Future getProfiles() async {
    if (profileListData.isNotEmpty) {
      profileListData.clear();
    }

    final future = _repository.getProfiles();
    fetchProfilesFuture = ObservableFuture(future);

    future.then((profileList) {
      profileListData.addAll(profileList.profiles);
    }).catchError((error) async {
      // await sentry.captureException(
      //   exception: error,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getProfile(String slug) async {
    if (infoSelf.isNotEmpty ||
        infoContact.isNotEmpty ||
        infoDocument.isNotEmpty ||
        infoFamily.isNotEmpty ||
        infoStatus.isNotEmpty) {
      infoContact.clear();
      infoDocument.clear();
      infoFamily.clear();
      infoSelf.clear();
      infoStatus.clear();
    }

    final future = _repository.getProfile(slug);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      this.profiles = profiles;
      this.success = true;
      fetchInfoContact(profiles);
      fetchInfoDiri(profiles);
      fetchInfoDocument(profiles);
      fetchInfoFamily(profiles);
      fetchInfoStatus(profiles);
    }).catchError((error) async {
      this.success = false;
      // await sentry.captureException(
      //   exception: error,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getUser() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Preferences.auth_token);

    if (token != null) {
      final future = _repository.getUser();
      fetchUserFuture = ObservableFuture(future);
      future.then((user) {
        this.user = user;
      }).catchError((error) async {
        this.user = null;
        // await sentry.captureException(
        //   exception: error,
        // );
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  void fetchInfoDiri(Profile profiles) {
    cekData(infoSelf, profiles.name, false);
    cekData(infoSelf, profiles.photo.medium.url, true);
    cekData(infoSelf, profiles.placeOfBirth, false);
    cekData(infoSelf, profiles.dateOfBirth, false);
    cekData(infoSelf, profiles.gender, false);
    cekData(infoSelf, profiles.clothSize, false);
  }

  void fetchInfoStatus(Profile profiles) {
    cekData(infoStatus, profiles.marriage, false);
    cekData(infoStatus, profiles.noMarriage, false);
    cekData(infoStatus, profiles.education, false);
    cekData(infoStatus, profiles.job, false);
    cekData(infoStatus, profiles.noKk, false);
    cekData(infoStatus, profiles.noKtp, false);
    cekData(infoStatus, profiles.scanMarriageBook.medium.url, true);
    cekData(infoStatus, profiles.scanFamilyCard.medium.url, true);
    cekData(infoStatus, profiles.scanBirthCertificate.medium.url, true);
  }

  void fetchInfoDocument(Profile profiles) {
    cekData(infoDocument, profiles.passportName, false);
    cekData(infoDocument, profiles.passportNumber, false);
    cekData(infoDocument, profiles.passportExpiredAt, false);
    cekData(infoDocument, profiles.passportIssuedAt, false);
    cekData(infoDocument, profiles.passportIssuedIn, false);
    cekData(infoDocument, profiles.lastUmrohAt, false);
    cekData(infoDocument, profiles.umroh, false);
    cekData(infoDocument, profiles.note, false);
    cekData(infoDocument, profiles.officeImigration, false);
    cekData(infoDocument, profiles.officeKemenag, false);
    cekData(infoDocument, profiles.scanPassport.medium.url, true);
    cekData(infoDocument, profiles.scanYellowCard.medium.url, true);
  }

  void fetchInfoContact(Profile profiles) {
    cekData(infoContact, profiles.phone, false);
    cekData(infoContact, profiles.email, false);
    cekData(infoContact, profiles.address, false);
  }

  void fetchInfoFamily(Profile profiles) {
    cekData(infoFamily, profiles.fathersName, false);
    cekData(infoFamily, profiles.mothersName, false);
  }

  void cekData(ObservableList list, String val, bool img) {
    if (img == true) {
      if (!val.contains("image-not-found")) {
        list.add(val);
        print(
            "CEK DATA, $img, IMAGE NOT CONATAINS 'image-not-found' , ${profiles.photo.medium.url}");
      }
    } else {
      if (val != null) {
        list.add(val);
        print("CEK DATA, $img, IMAGE NOT NULL ,${profiles.photo.medium.url}");
      }
    }
  }
}
