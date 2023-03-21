import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class BankList {
  final List<Bank> banks;

  BankList({
    this.banks,
  });

  factory BankList.fromJson(List<dynamic> json) {
    List<Bank> banks = List<Bank>();
    banks = json.map((bank) => Bank.fromJson(bank)).toList();

    return BankList(
      banks: banks,
    );
  }
}

class Bank{
  int id;
  int siteId;
  String slug;
  String bank;
  String name;
  String number;
  String currency;
  Pict logo;
  bool public;

  Bank._({this.id, this.siteId, this.slug, this.bank, this.name, this.number,
      this.currency, this.logo, this.public});

  factory Bank.fromJson(Map<String, dynamic> json) {
    return new Bank._(
        id: json['id'],
//        site_id: json["site_id"],
//        slug: json["slug"],
        bank: json["bank"],
        name: json["name"],
        number: json["number"],
        currency: json["currency"],
//        public: json["public"],
        logo: Pict.fromJson(json['logo'])
    );
  }

  factory Bank.fromJsonShowPayment(Map<String, dynamic> json) {
    return new Bank._(
        siteId: json["site_id"],
        slug: json["slug"],
        bank: json["bank"],
        name: json["name"],
        number: json["number"],
        currency: json["currency"],
        public: json["public"],
        logo: Pict.fromJson(json['logo'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['site_id'] = this.siteId;
    data['slug'] = this.slug;
    data['bank'] = this.bank;
    data['name'] = this.name;
    data['currency'] = this.currency;
    data['public'] = this.public;
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    return data;
  }

}