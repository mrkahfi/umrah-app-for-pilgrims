import 'package:app_jamaah_boilerplate/models/listing/city.dart';
import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Hotels {
  Hotel hotel;
  String checkinAt;
  String checkoutAt;

  Hotels({this.hotel, this.checkinAt, this.checkoutAt});

  Hotels.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    checkinAt = json['checkin_at'];
    checkoutAt = json['checkout_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
    data['checkin_at'] = this.checkinAt;
    data['checkout_at'] = this.checkoutAt;
    return data;
  }
}

class Hotel {
  City city;
  String slug;
  String name;
  String lat;
  String lon;
  int star;
  Pict photo;
  String description;

  Hotel(
      {this.city,
      this.slug,
      this.name,
      this.lat,
      this.lon,
      this.star,
      this.photo,
      this.description});

  Hotel.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    slug = json['slug'];
    name = json['name'];
    lat = json['lat'];
    lon = json['lon'];
    star = json['star'];
    photo = json['photo'] != null ? new Pict.fromJson(json['photo']) : null;
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['star'] = this.star;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    data['description'] = this.description;
    return data;
  }
}