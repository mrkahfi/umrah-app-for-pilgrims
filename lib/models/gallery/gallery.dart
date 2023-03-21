import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class GalleryList {
  final List<Gallery> galleries;

  GalleryList({
    this.galleries,
  });

  factory GalleryList.fromJson(List<dynamic> json) {
    List<Gallery> galleries = List<Gallery>();
    galleries = json.map((gallery) => Gallery.fromJson(gallery)).toList();

    return GalleryList(
      galleries: galleries,
    );
  }
}

class Gallery {
  int id;
  String tipeId;
  String tipe;
  String caption;
  Pict pict;

  Gallery({this.id, this.tipeId, this.tipe, this.caption, this.pict});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipeId = json['tipe_id'];
    tipe = json['tipe'];
    caption = json['caption'];
    pict = json['pict'] != null ? new Pict.fromJson(json['pict']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipe_id'] = this.tipeId;
    data['tipe'] = this.tipe;
    data['caption'] = this.caption;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    return data;
  }
}