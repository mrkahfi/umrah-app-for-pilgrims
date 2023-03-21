class Airport{
  String name;
  String code;
  String lat;
  String lon;
  String city;
  String country;
  String web;

  Airport._({this.name, this.code, this.lat, this.lon, this.city,
      this.country, this.web});

  factory Airport.fromJson(Map<String, dynamic> json) {
    return new Airport._(
        name: json['name'],
        code: json["code"],
        lat: json["lat"],
        lon: json["lon"],
        city: json["city"],
        country: json["country"],
        web: json["web"],

    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['city'] = this.city;
    data['country'] = this.country;
    data['web'] = this.web;
    return data;
  }
}