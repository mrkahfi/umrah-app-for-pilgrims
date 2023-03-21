class Jamaah {
  String name;
  String paket;
  int paketId;
  int price;

  Jamaah._({ this.name, this.paket,this.paketId,this.price});
  
  Jamaah({this.name, this.paket,this.paketId,this.price});

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["paket"] = paket;
    map["name"] = name;
    map['paketId'] = paketId;
    map['price'] = price;

    return map;
  }

  factory Jamaah.fromJson(Map<String, dynamic> json) {
    return new Jamaah._(
      paket: json['paket'],
      name: json['name'],
      price: json['price'],
      paketId: json['paketId']
    );
  }
}
