class Surahs {
  int code;
  String status;
  List<DataSurah> data;

  Surahs({this.code, this.status, this.data});

  Surahs.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<DataSurah>();
      json['data'].forEach((v) {
        data.add(new DataSurah.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSurah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  String revelationType;
  int numberAyahId;
  int indexAyah;

  DataSurah(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.numberOfAyahs,
      this.revelationType,
      this.numberAyahId,
      this.indexAyah});

  DataSurah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    numberOfAyahs = json['numberOfAyahs'];
    revelationType = json['revelationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['englishName'] = this.englishName;
    data['englishNameTranslation'] = this.englishNameTranslation;
    data['numberOfAyahs'] = this.numberOfAyahs;
    data['revelationType'] = this.revelationType;
    return data;
  }

  Map<String, dynamic> toDbMap() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
        "numberAyahId": numberAyahId,
        "indexAyah": indexAyah,
      };

  DataSurah.fromDb(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    numberOfAyahs = json['numberOfAyahs'];
    revelationType = json['revelationType'];
    numberAyahId = json['numberAyahId'];
    indexAyah = json['indexAyah'];
  }
}

class DataSurahList {
  final List<DataSurah> surahSaveList;

  DataSurahList({
    this.surahSaveList,
  });

  factory DataSurahList.fromJson(List<dynamic> json) {
    List<DataSurah> surahSaveList = List<DataSurah>();
    surahSaveList = json.map((listing) => DataSurah.fromDb(listing)).toList();

    return DataSurahList(
      surahSaveList: surahSaveList,
    );
  }
}
