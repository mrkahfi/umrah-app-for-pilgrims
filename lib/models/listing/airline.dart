import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Airline {
  String name;
  String code;
  Pict logo;
  String web;

  Airline({this.name, this.code, this.logo, this.web});

  Airline.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    logo = json['logo'] != null ? new Pict.fromJson(json['logo']) : null;
    web = json['web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    data['web'] = this.web;
    return data;
  }
}