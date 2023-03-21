import 'package:app_jamaah_boilerplate/models/quran/ayah.dart';
import 'package:app_jamaah_boilerplate/models/quran/sajda.dart';

class AyahTrans {
  int code;
  String status;
  Data data;

  AyahTrans({this.code, this.status, this.data});

  AyahTrans.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  int numberOfAyahs;
  List<AyahsT> ayahs;
  Edition edition;

  Data(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.numberOfAyahs,
      this.ayahs,
      this.edition});

  Data.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
    if (json['ayahs'] != null) {
      ayahs = new List<AyahsT>();
      json['ayahs'].forEach((v) {
        ayahs.add(new AyahsT.fromJson(v));
      });
    }
    edition =
        json['edition'] != null ? new Edition.fromJson(json['edition']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['englishNameTranslation'] = this.englishNameTranslation;
    data['revelationType'] = this.revelationType;
    data['numberOfAyahs'] = this.numberOfAyahs;
    if (this.ayahs != null) {
      data['ayahs'] = this.ayahs.map((v) => v.toJson()).toList();
    }
    if (this.edition != null) {
      data['edition'] = this.edition.toJson();
    }
    return data;
  }
}

class AyahsT {
  int number;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  bool sajda;
  SajdaTrue sajdaTrue;

  AyahsT(
      {this.number,
      this.text,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda,
      this.sajdaTrue});

  AyahsT.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    if (json['sajda'] == false) {
      sajda = json['sajda'];
    } else {
      sajdaTrue = new SajdaTrue.fromJson(json['sajda']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['text'] = this.text;
    data['numberInSurah'] = this.numberInSurah;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    if (this.sajda == false) {
      data['sajda'] = this.sajda;
    } else {
      data['sajda'] = this.sajdaTrue.toJson();
    }
    return data;
  }
}
