import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class Site {
  int id;
  String name;
  String nickname;
  String domain;
  Pict logo;
  Pict logo2;
  Pict background;
  Pict background2;
  String email;
  String phone;
  String facebook;
  String instagram;
  String payment;
  String createdAt;
  String updatedAt;
  List<EndpointsAPI> branchs;
  bool midtrans;

  Site(
      {this.id,
      this.name,
      this.nickname,
      this.domain,
      this.logo,
      this.logo2,
      this.background,
      this.background2,
      this.email,
      this.phone,
      this.facebook,
      this.instagram,
      this.payment,
      this.createdAt,
      this.updatedAt,
      this.branchs,
      this.midtrans});

  Site.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nickname = json['nickname'];
    domain = json['domain'];
    logo = json['logo'] != null ? new Pict.fromJson(json['logo']) : null;
    logo2 = json['logo2'] != null ? new Pict.fromJson(json['logo2']) : null;
    background = json['background'] != null
        ? new Pict.fromJson(json['background'])
        : null;
    background2 = json['background2'] != null
        ? new Pict.fromJson(json['background2'])
        : null;
    email = json['email'];
    phone = json['phone'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    payment = json['payment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    var listBranch = json['branchs'] as List;
    List<EndpointsAPI> listBranchs =
        listBranch.map((i) => EndpointsAPI.fromDb(i)).toList();
    branchs = (listBranchs.length > 0) ? listBranchs : null;
    midtrans = json['midtrans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['domain'] = this.domain;
    if (this.logo != null) {
      data['logo'] = this.logo.toJson();
    }
    if (this.logo2 != null) {
      data['logo2'] = this.logo2.toJson();
    }
    if (this.background != null) {
      data['background'] = this.background.toJson();
    }
    if (this.background2 != null) {
      data['background2'] = this.background2.toJson();
    }
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['payment'] = this.payment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    if (this.branchs != null) {
      data['branchs'] = this.branchs;
    }

    data['midtrans'] = this.midtrans;
    return data;
  }

  Site.fromJsonUser(Map<String, dynamic> json) {
    id = json['id'];
    domain = json['domain'];
    name = json['name'];
  }

  Map<String, dynamic> toJsonUser() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['domain'] = this.domain;
    data['name'] = this.name;
    return data;
  }
}
