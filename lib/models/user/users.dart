import 'package:app_jamaah_boilerplate/models/pict/pict.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';
import 'package:app_jamaah_boilerplate/models/site/site.dart';

class Users {
  String email;
  String name;
  String slug;
  String status;
  String phone;
  String authToken;
  Pict photo;
  String jwt;
  String resetPasswordToken;
  int signInCount;
  String currentSignInIp;
  String lastSignInIp;
  int familyDevices;
  Site site;
  String resetPasswordSentAt;
  String rememberCreatedAt;
  String currentSignInAt;
  String lastSignInAt;
  Profile profiles;
  String createdAt;
  String updatedAt;

  Users(
      {this.email,
      this.name,
      this.slug,
      this.status,
      this.phone,
      this.authToken,
      this.photo,
      this.jwt,
      this.resetPasswordToken,
      this.signInCount,
      this.currentSignInIp,
      this.lastSignInIp,
      this.familyDevices,
      this.site,
      this.resetPasswordSentAt,
      this.rememberCreatedAt,
      this.currentSignInAt,
      this.lastSignInAt,
      this.profiles,
      this.createdAt,
      this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    slug = json['slug'];
    status = json['status'];
    phone = json['phone'];
    authToken = json['auth_token'];
    photo = json['photo'] != null ? new Pict.fromJson(json['photo']) : null;
    jwt = json['jwt'];
    resetPasswordToken = json['reset_password_token'];
    signInCount = json['sign_in_count'];
    currentSignInIp = json['current_sign_in_ip'];
    lastSignInIp = json['last_sign_in_ip'];
    familyDevices = json['family_devices'];
    site = json['site'] != null ? new Site.fromJsonUser(json['site']) : null;
    resetPasswordSentAt = json['reset_password_sent_at'];
    rememberCreatedAt = json['remember_created_at'];
    currentSignInAt = json['current_sign_in_at'];
    lastSignInAt = json['last_sign_in_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['auth_token'] = this.authToken;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    data['jwt'] = this.jwt;
    data['reset_password_token'] = this.resetPasswordToken;
    data['sign_in_count'] = this.signInCount;
    data['current_sign_in_ip'] = this.currentSignInIp;
    data['last_sign_in_ip'] = this.lastSignInIp;
    data['family_devices'] = this.familyDevices;
    if (this.site != null) {
      data['site'] = this.site.toJsonUser();
    }
    data['reset_password_sent_at'] = this.resetPasswordSentAt;
    data['remember_created_at'] = this.rememberCreatedAt;
    data['current_sign_in_at'] = this.currentSignInAt;
    data['last_sign_in_at'] = this.lastSignInAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}