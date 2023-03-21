import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Buses {
  String bus;
  String transport;
  Pict logo;

  Buses({this.bus, this.transport, this.logo});

  Buses.fromJson(Map<String, dynamic> json) {
    bus = json['bus'];
    transport = json['transport'];
    logo = json['logo'] != null ? new Pict.fromJson(json['logo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bus'] = this.bus;
    data['transport'] = this.transport;
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    return data;
  }
}