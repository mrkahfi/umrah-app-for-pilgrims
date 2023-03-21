import 'package:app_jamaah_boilerplate/models/listing/airline.dart';
import 'package:app_jamaah_boilerplate/models/listing/airport.dart';

class Flights {
  Airline airline;
  Airport from;
  Airport to;
  String terminal;
  String gate;
  String boardingAt;
  String klass;
  String etdAt;
  String etaAt;
  String code;
  String createdAt;
  String updatedAt;
  String slug;

  Flights(
      {this.airline,
      this.from,
      this.to,
      this.terminal,
      this.gate,
      this.boardingAt,
      this.klass,
      this.etdAt,
      this.etaAt,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.slug});

  Flights.fromJson(Map<String, dynamic> json) {
    airline =
        json['airline'] != null ? new Airline.fromJson(json['airline']) : null;
    from = json['from'] != null ? new Airport.fromJson(json['from']) : null;
    to = json['to'] != null ? new Airport.fromJson(json['to']) : null;
    terminal = json['terminal'];
    gate = json['gate'];
    boardingAt = json['boarding_at'];
    klass = json['klass'];
    etdAt = json['etd_at'];
    etaAt = json['eta_at'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.airline != null) {
      data['airline'] = this.airline.toJson();
    }
    if (this.from != null) {
      data['from'] = this.from.toJson();
    }
    if (this.to != null) {
      data['to'] = this.to.toJson();
    }
    data['terminal'] = this.terminal;
    data['gate'] = this.gate;
    data['boarding_at'] = this.boardingAt;
    data['klass'] = this.klass;
    data['etd_at'] = this.etdAt;
    data['eta_at'] = this.etaAt;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['slug'] = this.slug;
    return data;
  }
}