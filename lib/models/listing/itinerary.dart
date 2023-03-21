class Itineraries {
  String title;
  String description;
  int day;
  String at;

  Itineraries({this.title, this.description, this.day, this.at});

  Itineraries.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    day = json['day'];
    at = json['at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['day'] = this.day;
    data['at'] = this.at;
    return data;
  }
}