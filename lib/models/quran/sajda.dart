
class SajdaTrue {
  int id;
  bool recommended;
  bool obligatory;

  SajdaTrue({this.id, this.recommended, this.obligatory});

  SajdaTrue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recommended = json['recommended'];
    obligatory = json['obligatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recommended'] = this.recommended;
    data['obligatory'] = this.obligatory;
    return data;
  }
}
