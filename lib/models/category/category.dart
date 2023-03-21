import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Category {
  int id;
  String title;
  Pict pict;

  Category({this.id, this.title, this.pict});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    pict = json['pict'] != null ? new Pict.fromJson(json['pict']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    return data;
  }
}