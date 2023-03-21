import 'package:app_jamaah_boilerplate/models/listing/variant.dart';
import 'package:app_jamaah_boilerplate/models/profile/profile.dart';

class Booking {
  int id;
  Profile profile;
  Variants variant;
  String sequence;
  String status;
  String updatedAt;
  String createdAt;
  int price;
  String currency;
  int equipment;
  int invoiceId;
  int adminId;

  Booking._(
      {this.id, 
      this.profile,
      this.variant,
      this.sequence,
      this.adminId,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.price,
      this.currency,
      this.invoiceId,
      this.equipment});

  factory Booking.fromJsonDetail(Map<String, dynamic> json) {
    return new Booking._(
      profile: Profile.fromJsonBookingPost(json['profile']),
      variant: Variants.fromJson(json['variant']),
      id: json['id'],
      sequence: json['sequence'],
      status: json['status'],
      price: json['price'],
      currency: json['currency'],
      equipment: json['equipment'],
      invoiceId: json['invoice_id'],
      adminId: json['admin_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequence'] = this.sequence;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['equipment'] = this.equipment;
    data['invoice_id'] = this.invoiceId;
    data['admin_id'] = this.adminId;
    if (this.variant != null) {
      data['variant'] = this.variant.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }

  // factory Booking.fromJsonInvoice(Map<String, dynamic> json) {
  //   return new Booking._(
  //     profile: Profile.fromJsonInvoice(json['profile']),
  //     variant: Variants.fromJsonInvoice(json['variant']),
  //     sequence: json['sequence'],
  //     status: json['status'],
  //     price: json['price'],
  //     currency: json['currency'],
  //     equipment: json['equipment'],
  //     invoiceId: json['invoice_id'],
  //   );
  // }

}
