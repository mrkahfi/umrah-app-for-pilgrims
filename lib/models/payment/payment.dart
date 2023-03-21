

import 'package:app_jamaah_boilerplate/models/invoice/bank.dart';
import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Midtrans {
  String token;

  Midtrans({this.token});

  Midtrans.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class Payment{
 Bank bank;
 String slug;
 String at;
 int amount;
 String status;
 String tipe;
 Pict pict;
 String note;
 String currency;
//  Admin admin;

 Payment._({this.bank, this.slug, this.at, this.amount, this.status, this.tipe,
     this.pict, this.note, this.currency});

 factory Payment.fromJson(Map<String, dynamic> json) {
   return new Payment._(
      //  bank: Bank.fromJsonShowPayment(json['bank']),
       bank: json['bank'] != null ? new Bank.fromJsonShowPayment(json['bank']) : null,
       slug: json["slug"],
       at: json["at"],
       amount: json["amount"],
       status: json["status"],
       tipe: json["tipe"],
       currency: json["currency"],
       note: json["note"],
       pict: Pict.fromJson(json['pict']),
//       admin: Admin.fromJson(json['admin'])
   );
 }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['at'] = this.at;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['tipe'] = this.tipe;
    data['currency'] = this.currency;
    data['note'] = this.note;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    if (this.bank != null) {
      data['bank'] = this.bank.toJson();
    }
    return data;
  }

 String getPayStatus(){
   if(this.status.toLowerCase() == "new"){
     return "Menunggu Verifikasi";
   }
   if(this.status.toLowerCase() == "valid"){
     return "Verifikasi";
   }
   if(this.status.toLowerCase() == "spam"){
     return "Spam";
   }
   if(this.status.toLowerCase() == "reject"){
     return "Ditolak";
   }

   return "";
 }

}