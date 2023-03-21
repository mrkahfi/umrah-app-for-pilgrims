class City {
  String name;
  String country;
  int timezone;

  City({this.name, this.country, this.timezone});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['timezone'] = this.timezone;
    return data;
  }
}