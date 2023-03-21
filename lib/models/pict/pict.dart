import 'medium.dart';

class Pict {
  String url;
  Medium medium;
  Medium small;

  Pict({this.url, this.medium, this.small});

  Pict.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    medium =
        json['medium'] != null ? new Medium.fromJson(json['medium']) : null;
    small = json['small'] != null ? new Medium.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    return data;
  }
}