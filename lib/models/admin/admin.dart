import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Admin {
  String name;
  Pict photo;

  Admin({this.name, this.photo});

  Admin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'] != null ? new Pict.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    return data;
  }
}