class Variants {
  int id;
  String name;
  String tipe;
  String currency;
  int price;
  int equipment;
  bool basePrice;
  int sequence;
  bool public;

  Variants(
      {this.id,
      this.name,
      this.tipe,
      this.currency,
      this.price,
      this.equipment,
      this.basePrice,
      this.sequence,
      this.public});

  Variants._showBookingPost({this.id, this.name, this.price});

  factory Variants.fromJsonBookingPost(Map<String, dynamic> json) {
    return Variants._showBookingPost(
      id: json["id"],
      name: json['name'],
      price: json['price'],
    );
  }

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tipe = json['tipe'];
    currency = json['currency'];
    price = json['price'];
    equipment = json['equipment'];
    basePrice = json['base_price'];
    sequence = json['sequence'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tipe'] = this.tipe;
    data['currency'] = this.currency;
    data['price'] = this.price;
    data['equipment'] = this.equipment;
    data['base_price'] = this.basePrice;
    data['sequence'] = this.sequence;
    data['public'] = this.public;
    return data;
  }
}