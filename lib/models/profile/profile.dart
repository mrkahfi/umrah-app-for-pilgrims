import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class ProfileList {
  final List<Profile> profiles;

  ProfileList({
    this.profiles,
  });

  factory ProfileList.fromJson(List<dynamic> json) {
    List<Profile> profiles = List<Profile>();
    profiles = json.map((profile) => Profile.fromJson(profile)).toList();

    return ProfileList(
      profiles: profiles,
    );
  }
}

class Profile {
  int id;
  String slug;
  String address;
  String ageGroup;
  String clothSize;
  int completeness;
  String createdAt;
  String dateOfBirth;
  String education;
  String email;
  bool familyShare;
  String fathersName;
  String firebaseToken;
  String gender;
  String job;
  String lastUmrohAt;
  String marriage;
  String mothersName;
  String name;
  String noKk;
  String noKtp;
  String noMarriage;
  String note;
  String passportExpiredAt;
  String passportIssuedAt;
  String passportIssuedIn;
  String passportName;
  String passportNumber;
  String phone;
  Pict photo;
  String placeOfBirth;
  String relation;
  Pict scanBirthCertificate;
  Pict scanFamilyCard;
  Pict scanMarriageBook;
  Pict scanPassport;
  Pict scanYellowCard;
  String umroh;
  String updatedAt;
  String officeImigration;
  String officeKemenag;

  Profile(
      {this.id,
      this.slug,
      this.address,
      this.ageGroup,
      this.clothSize,
      this.completeness,
      this.createdAt,
      this.dateOfBirth,
      this.education,
      this.email,
      this.familyShare,
      this.fathersName,
      this.firebaseToken,
      this.gender,
      this.job,
      this.lastUmrohAt,
      this.marriage,
      this.mothersName,
      this.name,
      this.noKk,
      this.noKtp,
      this.noMarriage,
      this.note,
      this.passportExpiredAt,
      this.passportIssuedAt,
      this.passportIssuedIn,
      this.passportName,
      this.passportNumber,
      this.phone,
      this.photo,
      this.placeOfBirth,
      this.relation,
      this.scanBirthCertificate,
      this.scanFamilyCard,
      this.scanMarriageBook,
      this.scanPassport,
      this.scanYellowCard,
      this.officeImigration,
      this.officeKemenag,
      this.umroh,
      this.updatedAt});

  Profile._showJsonBookingPost({this.slug, this.name});

  factory Profile.fromJsonBookingPost(Map<String, dynamic> json) {
    return Profile._showJsonBookingPost(
      slug: json["slug"],
      name: json['name'],
    );
  }

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    address = json['address'];
    ageGroup = json['age_group'];
    clothSize = json['cloth_size'];
    completeness = json['completeness'];
    createdAt = json['created_at'];
    dateOfBirth = json['date_of_birth'];
    education = json['education'];
    email = json['email'];
    familyShare = json['family_share'];
    fathersName = json['fathers_name'];
    firebaseToken = json['firebase_token'];
    gender = json['gender'];
    job = json['job'];
    lastUmrohAt = json['last_umroh_at'];
    marriage = json['marriage'];
    mothersName = json['mothers_name'];
    name = json['name'];
    noKk = json['no_kk'];
    noKtp = json['no_ktp'];
    noMarriage = json['no_marriage'];
    note = json['note'];
    passportExpiredAt = json['passport_expired_at'];
    passportIssuedAt = json['passport_issued_at'];
    passportIssuedIn = json['passport_issued_in'];
    passportName = json['passport_name'];
    passportNumber = json['passport_number'];
    officeKemenag = json['office_kemenag'];
    officeImigration = json['office_imigration'];
    phone = json['phone'];
    photo = json['photo'] != null ? new Pict.fromJson(json['photo']) : null;
    placeOfBirth = json['place_of_birth'];
    relation = json['relation'];
    scanBirthCertificate = json['scan_birth_certificate'] != null
        ? new Pict.fromJson(json['scan_birth_certificate'])
        : null;
    scanFamilyCard = json['scan_family_card'] != null
        ? new Pict.fromJson(json['scan_family_card'])
        : null;
    scanMarriageBook = json['scan_marriage_book'] != null
        ? new Pict.fromJson(json['scan_marriage_book'])
        : null;
    scanPassport = json['scan_passport'] != null
        ? new Pict.fromJson(json['scan_passport'])
        : null;
    scanYellowCard = json['scan_yellow_card'] != null
        ? new Pict.fromJson(json['scan_yellow_card'])
        : null;
    umroh = json['umroh'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['address'] = this.address;
    data['age_group'] = this.ageGroup;
    data['cloth_size'] = this.clothSize;
    data['completeness'] = this.completeness;
    data['created_at'] = this.createdAt;
    data['date_of_birth'] = this.dateOfBirth;
    data['education'] = this.education;
    data['email'] = this.email;
    data['family_share'] = this.familyShare;
    data['fathers_name'] = this.fathersName;
    data['firebase_token'] = this.firebaseToken;
    data['gender'] = this.gender;
    data['job'] = this.job;
    data['last_umroh_at'] = this.lastUmrohAt;
    data['marriage'] = this.marriage;
    data['mothers_name'] = this.mothersName;
    data['name'] = this.name;
    data['no_kk'] = this.noKk;
    data['no_ktp'] = this.noKtp;
    data['no_marriage'] = this.noMarriage;
    data['note'] = this.note;
    data['passport_expired_at'] = this.passportExpiredAt;
    data['passport_issued_at'] = this.passportIssuedAt;
    data['passport_issued_in'] = this.passportIssuedIn;
    data['passport_name'] = this.passportName;
    data['passport_number'] = this.passportNumber;
    data['office_kemenag'] = this.officeKemenag;
    data['office_imigration'] = this.officeImigration;
    data['phone'] = this.phone;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    data['place_of_birth'] = this.placeOfBirth;
    data['relation'] = this.relation;
    if (this.scanBirthCertificate != null) {
      data['scan_birth_certificate'] = this.scanBirthCertificate.toJson();
    }
    if (this.scanFamilyCard != null) {
      data['scan_family_card'] = this.scanFamilyCard.toJson();
    }
    if (this.scanMarriageBook != null) {
      data['scan_marriage_book'] = this.scanMarriageBook.toJson();
    }
    if (this.scanPassport != null) {
      data['scan_passport'] = this.scanPassport.toJson();
    }
    if (this.scanYellowCard != null) {
      data['scan_yellow_card'] = this.scanYellowCard.toJson();
    }
    data['umroh'] = this.umroh;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
