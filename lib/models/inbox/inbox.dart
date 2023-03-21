class InboxList {
  final List<Inbox> inboxes;

  InboxList({
    this.inboxes,
  });

  factory InboxList.fromJson(List<dynamic> json) {
    List<Inbox> inboxes = List<Inbox>();
    inboxes = json.map((inbox) => Inbox.fromJson(inbox)).toList();

    return InboxList(
      inboxes: inboxes,
    );
  }
}
class Inbox {
  int id;
  bool read;
  String klass;
  String message;
  String createdAt;
  String updatedAt;

  Inbox(
      {this.id,
      this.read,
      this.klass,
      this.message,
      this.createdAt,
      this.updatedAt,
      });

  Inbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    read = json['read'];
    klass = json['klass'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['read'] = this.read;
    data['klass'] = this.klass;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}