import 'package:app_jamaah_boilerplate/models/addon/addon.dart';
import 'package:app_jamaah_boilerplate/models/payment/payment.dart';

import 'booking.dart';
import '../listing/listing.dart';

class InvoiceList {
  final List<Invoice> invoices;

  InvoiceList({
    this.invoices,
  });

  factory InvoiceList.fromJson(List<dynamic> json) {
    List<Invoice> invoices = List<Invoice>();
    invoices = json.map((invoice) => Invoice.fromJsonIndexShow(invoice)).toList();

    return InvoiceList(
      invoices: invoices,
    );
  }
}

class Invoice {
  int id;
  String slug;
  String number;
  String date;
  String description;
  String code;
  String currency;
  String status;
  int total;
  int totalPrice;
  int totalEquipment;
  int totalPayment;
  int completeness;
  int discount;
  int unpaid;
  Listing listing;
  List<Booking> bookings;
  List<Payment> payments;
  List<Addon> addons;
  String createdAt;
  String updatedAt;

  Invoice(
      {this.id,
      this.slug,
      this.number,
      this.date,
      this.description,
      this.code,
      this.currency,
      this.status,
      this.total,
      this.totalPrice,
      this.totalEquipment,
      this.totalPayment,
      this.completeness,
      this.discount,
      this.unpaid,
      this.listing,
      this.bookings,
      this.addons,
      this.payments});

  Invoice.fromJsonIndexShow(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    number = json['number'];
    date = json['date'];
    description = json['description'];
    code = json['code'];
    currency = json['currency'];
    unpaid = json['unpaid'];
    status = json['status'];
    total = json['total'];
    totalPrice = json['total_price'];
    totalEquipment = json['total_equipment'];
    totalPayment = json['total_payment'];
    completeness = json['completeness'];
    discount = json['discount'];
    if (json['bookings'] != null) {
      bookings = new List<Booking>();
      json['bookings'].forEach((v) {
        bookings.add(new Booking.fromJsonDetail(v));
      });
    }
     if (json['payments'] != null) {
      payments = new List<Payment>();
      json['payments'].forEach((v) {
        payments.add(new Payment.fromJson(v));
      });
    }
    if (json['addons'] != null) {
      addons = new List<Addon>();
      json['addons'].forEach((v) {
        addons.add(new Addon.fromJson(v));
      });
    }
    listing =
        json['listing'] != null ? new Listing.fromJsonInvoice(json['listing']) : null;
  }

  Invoice.fromJsonBookingPost(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    number = json['number'];
    date = json['date'];
    description = json['description'];
    code = json['code'];
    currency = json['currency'];
    status = json['status'];
    total = json['total'];
    totalPrice = json['total_price'];
    totalEquipment = json['total_equipment'];
    totalPayment = json['total_payment'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unpaid = json['unpaid'];
    listing =
        json['listing'] != null ? new Listing.fromJson(json['listing']) : null;
    if (json['bookings'] != null) {
      bookings = new List<Booking>();
      json['bookings'].forEach((v) {
        bookings.add(new Booking.fromJsonDetail(v));
      });
    }
    if (json['payments'] != null) {
      payments = new List<Payment>();
      json['payments'].forEach((v) {
        payments.add(new Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJsonBookingPost() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['number'] = this.number;
    data['date'] = this.date;
    data['description'] = this.description;
    data['code'] = this.code;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['total'] = this.total;
    data['total_price'] = this.totalPrice;
    data['total_equipment'] = this.totalEquipment;
    data['total_payment'] = this.totalPayment;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['unpaid'] = this.unpaid;
    if (this.listing != null) {
      data['listing'] = this.listing.toJson();
    }
    if (this.bookings != null) {
      data['bookings'] = this.bookings.map((v) => v.toJson()).toList();
    }
    if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toJsonIndex() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['number'] = this.number;
    data['date'] = this.date;
    data['description'] = this.description;
    data['code'] = this.code;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['total'] = this.total;
    data['total_price'] = this.totalPrice;
    data['total_equipment'] = this.totalEquipment;
    data['total_payment'] = this.totalPayment;
    data['completeness'] = this.completeness;
    data['discount'] = this.discount;
    if (this.listing != null) {
      data['listing'] = this.listing.toJsonInvoice();
    }
    return data;
  }

  String getStatus() {
    if (this.status.contains("NEW")) {
      return "Invoice Baru";
    }

    if (this.status.contains("PARTIAL")) {
      return "Belum Lunas";
    }

    if (this.status.contains("PAID")) {
      return "Lunas";
    }

    return "Error";
  }
}