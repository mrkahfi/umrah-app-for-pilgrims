import 'dart:io';

import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:sentry/sentry.dart';
part 'profile_form_store.g.dart';

class ProfileFormStore = _ProfileFormStoreBase with _$ProfileFormStore;

abstract class _ProfileFormStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _ProfileFormStoreBase(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  // Form Info Diri:-----------------------------------------------------------
  @observable
  String nameKtp;

  @observable
  String placeBirth;

  @observable
  String gender;

  @observable
  String clothes;

  @observable
  DateTime dateBirth;

  @observable
  File imageFoto;

  @observable
  List<String> genderList = ["MALE", "FEMALE"];

  @observable
  List<String> clotchesList = [
    "XXXL",
    "XXL",
    "XL",
    "L",
    "M",
    "S",
    "XS",
    "CHILD XXL",
    "CHILD XL",
    "CHILD L",
    "CHILD M",
    "CHILD S",
    "CHILD XS"
  ];

  // actions:-------------------------------------------------------------------
  @action
  void setNameKtp(value) => nameKtp = value;

  @action
  void setPlaceBirth(value) => placeBirth = value;

  @action
  void setGender(value) => gender = value;

  @action
  void setClothes(value) => clothes = value;

  @action
  void setDateBirth(value) => dateBirth = value;

  @action
  void setImageFoto(value) => imageFoto = value;

  // Form Info Contact:-----------------------------------------------------------
  @observable
  String email;

  @observable
  String phone;

  @observable
  String address;

  @action
  void setEmail(value) => email = value;

  @action
  void setPhone(value) => phone = value;

  @action
  void setAddress(value) => address = value;

  // Form Info Family:-----------------------------------------------------------
  @observable
  String fatherName;

  @observable
  String motherName;

  @action
  void setFatherName(value) => fatherName = value;

  @action
  void setMotherName(value) => motherName = value;

  // Form Info Document:-----------------------------------------------------------
  @observable
  String numberPassport;

  @observable
  String namePassport;

  @observable
  String issuedInPassport;

  @observable
  DateTime issuedAtPassport;

  @observable
  DateTime lastUmrohAt;

  @observable
  String umroh;

  @observable
  List<String> umrohList = ["PERNAH", "BELUM"];

  @observable
  String note;

  @observable
  String officeImigration;

  @observable
  String officeKemenag;

  @observable
  File imagePassport;

  @observable
  File imageYellowCard;

  @action
  void setNumberPassport(value) => numberPassport = value;

  @action
  void setNamePassport(value) => namePassport = value;

  @action
  void setIssuedInPassport(value) => issuedInPassport = value;

  @action
  void setIssuedAtPassport(value) => issuedAtPassport = value;

  @action
  void setLastUmrohAt(value) => lastUmrohAt = value;

  @action
  void setUmroh(value) => umroh = value;

  @action
  void setNote(value) => note = value;

  @action
  void setOfficeImigration(value) => officeImigration = value;

  @action
  void setOfficeKemenag(value) => officeKemenag = value;

  @action
  void setImagePassport(value) => imagePassport = value;

  @action
  void setImageYellowCard(value) => imageYellowCard = value;

  // Form Info Status:-----------------------------------------------------------
  @observable
  String mariage;

  @observable
  String numberMariage;

  @observable
  String numberKK;

  @observable
  String numberKtp;

  @observable
  String education;

  @observable
  String job;

  @observable
  File imageMariage;

  @observable
  File imageKK;

  @observable
  File imageBorn;

  @observable
  List<String> educationList = [
    "SD/MI",
    "SMP/MTS",
    "SMA/MA",
    "D1",
    "D2",
    "D3",
    "D4/S1",
    "S2",
    "S3",
    "TIDAK SEKOLAH"
  ];

  @observable
  List<String> mariageList = ["MENIKAH", "BELUM MENIKAH", "JANDA/DUDA"];

  @observable
  List<String> jobList = [
    "DOKTER",
    "PNS",
    "WIRASWASTA",
    "WIRAUSAHA",
    "TNI/POLRI",
    "PETANI",
    "NELAYAN",
    "LAINNYA",
    "TIDAK BEKERJA"
  ];

  @action
  void setMariage(value) => mariage = value;

  @action
  void setNumberMariage(value) => numberMariage = value;

  @action
  void setNumberKK(value) => numberKK = value;

  @action
  void setNumberKtp(value) => numberKtp = value;

  @action
  void setEducation(value) => education = value;

  @action
  void setJob(value) => job = value;

  @action
  void setImageMariage(value) => imageMariage = value;

  @action
  void setImageKK(value) => imageKK = value;

  @action
  void setImageBorn(value) => imageBorn = value;

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  @observable
  bool loading = false;

  @observable
  bool success = false;

  static ObservableFuture<Profile> emptyProfileResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Profile> fetchProfileFuture =
      ObservableFuture<Profile>(emptyProfileResponse);

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @action
  Future updateFormSelf(String id) async {
    loading = true;
    var profileData = FormData.fromMap({
      "profile[name]": nameKtp,
      "profile[place_of_birth]": placeBirth,
      "profile[date_of_birth]":
          ConvertVar.dateToStringConvert(dateBirth, "yyyy-MM-dd"),
      "profile[gender]": gender,
      "profile[cloth_size]": clothes,
//      "profile[photo]": MultipartFile.fromFileSync(imageFoto.path,
//          filename: imageFoto.path.split('/').last,
//          contentType: MediaType("image", basename(imageFoto.path))),
    });

    if (imageFoto != null ) {
      profileData.files
        ..add(MapEntry(
          "profile[photo]",
          MultipartFile.fromFileSync(imageFoto.path,
              filename: imageFoto.path.split('/').last,
              contentType: MediaType("image", basename(imageFoto.path))),
        ));
    }

    final future = _repository.updateProfiles(id, profileData);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      loading = false;
      success = true;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future updateFormContact(String id) async {
    loading = true;
    var profileData = FormData.fromMap({
      "profile[email]": email,
      "profile[phone]": phone,
      "profile[address]": address,
    });

    final future = _repository.updateProfiles(id, profileData);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      loading = false;
      success = true;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future updateFormFamily(String id) async {
    loading = true;
    var profileData = FormData.fromMap({
      "profile[fathers_name]": fatherName,
      "profile[mothers_name]": motherName,
    });

    final future = _repository.updateProfiles(id, profileData);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      loading = false;
      success = true;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      // await sentry.captureException(
      //   exception: e,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future updateFormDocument(String id) async {
    loading = true;
    var profileData = FormData.fromMap({
      "profile[passport_number]": numberPassport,
      "profile[passport_name]": namePassport,
      "profile[passport_issued_in]": issuedInPassport,
      "profile[passport_issued_at]":
          ConvertVar.dateToStringConvert(issuedAtPassport, "yyyy-MM-dd"),
      "profile[last_umroh_at]":
          ConvertVar.dateToStringConvert(lastUmrohAt, "yyyy-MM-dd"),
      "profile[office_imigration]": officeImigration,
      "profile[office_kemenag]": officeKemenag,
      "profile[umroh]": umroh,
      "profile[note]": note,
    });

    if (imagePassport != null || imageYellowCard != null) {
      profileData
        ..files.addAll([
          MapEntry(
            "profile[scan_passport]",
            MultipartFile.fromFileSync(imagePassport.path,
                filename: imagePassport.path.split('/').last,
                contentType: MediaType("image", basename(imagePassport.path))),
          ),
          MapEntry(
            "profile[scan_yellow_card]",
            MultipartFile.fromFileSync(imageYellowCard.path,
                filename: imageYellowCard.path.split('/').last,
                contentType:
                    MediaType("image", basename(imageYellowCard.path))),
          ),
        ]);
    }

    final future = _repository.updateProfiles(id, profileData);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      loading = false;
      success = true;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      // await sentry.captureException(
      //   exception: e,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  Future updateFormStatus(String id) async {
    loading = true;
    var profileData = FormData.fromMap({
      "profile[marriage]": mariage,
      "profile[no_marriage]": numberMariage,
      "profile[no_kk]": numberKK,
      "profile[no_ktp]": numberKtp,
      "profile[education]": education,
      "profile[job]": job,
    });

    if (imageMariage != null || imageKK != null || imageBorn != null) {
      profileData
        ..files.addAll([
          MapEntry(
            "profile[scan_marriage_book]",
            MultipartFile.fromFileSync(imageMariage.path,
                filename: imageMariage.path.split('/').last,
                contentType: MediaType("image", basename(imageMariage.path))),
          ),
          MapEntry(
            "profile[scan_family_card]",
            MultipartFile.fromFileSync(imageKK.path,
                filename: imageKK.path.split('/').last,
                contentType: MediaType("image", basename(imageKK.path))),
          ),
          MapEntry(
            "profile[scan_birth_certificate]",
            MultipartFile.fromFileSync(imageBorn.path,
                filename: imageBorn.path.split('/').last,
                contentType: MediaType("image", basename(imageBorn.path))),
          ),
        ]);
    }

    final future = _repository.updateProfiles(id, profileData);
    fetchProfileFuture = ObservableFuture(future);

    future.then((profiles) {
      loading = false;
      success = true;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      // await sentry.captureException(
      //   exception: e,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  void disposeInfoSelf() {
    nameKtp = null;
    imageFoto = null;
    gender = null;
    placeBirth = null;
    dateBirth = null;
    clothes = null;
    loading = false;
    success = false;
  }

  void disposeInfoContact() {
    email = null;
    phone = null;
    address = null;
    loading = false;
    success = false;
  }

  void disposeInfoFamily() {
    fatherName = null;
    motherName = null;
    loading = false;
    success = false;
  }

  void disposeInfoDocument() {
    numberPassport = null;
    namePassport = null;
    issuedInPassport = null;
    issuedAtPassport = null;
    lastUmrohAt = null;
    umroh = null;
    note = null;
    officeImigration = null;
    officeKemenag = null;
    imagePassport = null;
    imageYellowCard = null;
    loading = false;
    success = false;
  }

  void disposeInfoStatus() {
    mariage = null;
    numberMariage = null;
    numberKK = null;
    numberKtp = null;
    education = null;
    job = null;
    imageMariage = null;
    imageKK = null;
    imageBorn = null;
    loading = false;
    success = false;
  }
}