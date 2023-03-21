class Addon {
    int amount;
    String currency;
    String note;
    String category;

    Addon._({this.amount, this.currency, this.note, this.category});

    factory Addon.fromJson(Map<String, dynamic> json) {
      return new Addon._(
          amount: json['amount'],
          currency: json["currency"],
          note: json['note'],
          category: json['category']
      );
    }
}