import 'package:app_jamaah_boilerplate/models/quran/sajda.dart';

class Ayah {
  int code;
  String status;
  DataAyah data;

  Ayah({this.code, this.status, this.data});

  Ayah.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new DataAyah.fromJson(json['data']) : null;
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

class DataAyah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  int numberOfAyahs;
  List<Ayahs> ayahs;
  Edition edition;

  DataAyah(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.numberOfAyahs,
      this.ayahs,
      this.edition});

  DataAyah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
    if (json['ayahs'] != null) {
      ayahs = new List<Ayahs>();
      json['ayahs'].forEach((v) {
        ayahs.add(new Ayahs.fromJson(v));
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

class PlayAyah {
  int position;
  bool isPlay;
  PlayAyah({this.position, this.isPlay});
}

class Ayahs {
  int number;
  String audio;
  List<String> audioSecondary;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  bool sajda;
  SajdaTrue sajdaTrue;

  Ayahs(
      {this.number,
      this.audio,
      this.audioSecondary,
      this.text,
      this.numberInSurah,
      this.juz,
      this.manzil,
      this.page,
      this.ruku,
      this.hizbQuarter,
      this.sajda,
      this.sajdaTrue});

  Ayahs.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    audio = json['audio'];
    audioSecondary = json['audioSecondary'].cast<String>();
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
    data['audio'] = this.audio;
    data['audioSecondary'] = this.audioSecondary;
    data['text'] = this.text;
    data['numberInSurah'] = this.numberInSurah;
    data['juz'] = this.juz;
    data['manzil'] = this.manzil;
    data['page'] = this.page;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    data['sajda'] = this.sajda;
    if (this.sajda != false) {
      data['sajda'] = this.sajdaTrue.toJson();
    } else {
      data['sajda'] = this.sajda;
    }
    return data;
  }
}

class Sajda {
  int id;
  bool recommended;
  bool obligatory;

  Sajda({this.id, this.recommended, this.obligatory});

  Sajda.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recommended = json['recommended'];
    obligatory = json['obligatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recommended'] = this.recommended;
    data['obligatory'] = this.obligatory;
    return data;
  }
}

class Edition {
  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;
  String direction;

  Edition(
      {this.identifier,
      this.language,
      this.name,
      this.englishName,
      this.format,
      this.type,
      this.direction});

  Edition.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    language = json['language'];
    name = json['name'];
    englishName = json['englishName'];
    format = json['format'];
    type = json['type'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['language'] = this.language;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['format'] = this.format;
    data['type'] = this.type;
    data['direction'] = this.direction;
    return data;
  }
}
