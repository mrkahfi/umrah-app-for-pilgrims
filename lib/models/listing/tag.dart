class Tags {
  String title;
  String category;

  Tags({this.title, this.category});

  Tags.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    return data;
  }
}