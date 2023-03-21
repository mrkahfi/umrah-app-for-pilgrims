import 'package:app_jamaah_boilerplate/models/listing/bus.dart';
import 'package:app_jamaah_boilerplate/models/listing/flight.dart';
import 'package:app_jamaah_boilerplate/models/listing/hotel.dart';
import 'package:app_jamaah_boilerplate/models/listing/itinerary.dart';
import 'package:app_jamaah_boilerplate/models/listing/tag.dart';
import 'package:app_jamaah_boilerplate/models/listing/variant.dart';
import 'package:app_jamaah_boilerplate/models/pict/pict.dart';

class ListingList {
  final List<Listing> listings;

  ListingList({
    this.listings,
  });

  factory ListingList.fromJson(List<dynamic> json) {
    List<Listing> listings = List<Listing>();
    listings = json.map((listing) => Listing.fromJson(listing)).toList();

    return ListingList(
      listings: listings,
    );
  }
}

class Listing {
  int id;
  String slug;
  String name;
  Null channel;
  String description;
  Pict pict;
  String closeAt;
  String status;
  int totalPax;
  String category;
  String departureAt;
  int days;
  int priceStart;
  int hotelStar;
  int totalBooking;
  String departureFrom;
  int availableSeats;
  String createdAt;
  String updatedAt;
  String currency;
  String arrivalAt;
  List<Buses> buses;
  List<Flights> flights;
  List<Hotels> hotels;
  List<Itineraries> itineraries;
  List<Variants> variants;
  List<Tags> tags;

  Listing(
      {this.id,
      this.slug,
      this.name,
      this.channel,
      this.description,
      this.pict,
      this.closeAt,
      this.status,
      this.totalPax,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.departureAt,
      this.days,
      this.priceStart,
      this.currency,
      this.arrivalAt,
      this.hotelStar,
      this.totalBooking,
      this.departureFrom,
      this.availableSeats});

  Listing._show(
      {this.id,
      this.slug,
      this.name,
      this.description,
      this.pict,
      this.closeAt,
      this.status,
      this.totalPax,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.departureAt,
      this.days,
      this.priceStart,
      this.hotelStar,
      this.totalBooking,
      this.departureFrom,
      this.availableSeats,
      this.buses,
      this.flights,
      this.hotels,
      this.itineraries,
      this.variants,
      this.tags,
      this.arrivalAt,
      this.currency});

  Listing._showBooking(
      {this.id,
      this.slug,
      this.name,
      this.pict,
      this.departureAt,
      this.days,
      this.arrivalAt});

  factory Listing.fromJsonBooking(Map<String, dynamic> json) {
    return new Listing._showBooking(
        id: json['id'],
        slug: json['slug'],
        name: json['name'],
        pict: json['pict'] != null ? new Pict.fromJson(json['pict']) : null,
        departureAt: json['departure_at'],
        days: json['days'],
        arrivalAt: json['arrival_at']);
  }

  factory Listing.fromJsonShow(Map<String, dynamic> json) {
    var listBus = json['buses'] as List;
    List<Buses> listBuses = listBus.map((i) => Buses.fromJson(i)).toList();

    var listFlight = json['flights'] as List;
    List<Flights> listFlights =
        listFlight.map((i) => Flights.fromJson(i)).toList();

    var listHotel = json['hotels'] as List;
    List<Hotels> listHotels = listHotel.map((i) => Hotels.fromJson(i)).toList();

    var listVariant = json['variants'] as List;
    List<Variants> listVariants =
        listVariant.map((i) => Variants.fromJson(i)).toList();

    var listItineraries = json['itineraries'] as List;
    List<Itineraries> listItineraris =
        listItineraries.map((i) => Itineraries.fromJson(i)).toList();

    var listTags = json['tags'] as List;
    List<Tags> listTag = listTags.map((i) => Tags.fromJson(i)).toList();

    return new Listing._show(
        id: json['id'],
        slug: json['slug'],
        name: json['name'],
        description: json['description'],
        pict: json['pict'] != null ? new Pict.fromJson(json['pict']) : null,
        closeAt: json['close_at'],
        status: json['status'],
        totalPax: json['total_pax'],
        departureAt: json['departure_at'],
        days: json['days'],
        priceStart: json['price_start'],
        hotelStar: json['hotel_star'],
        totalBooking: json['total_booking'],
        departureFrom: json['departure_from'],
        availableSeats: json['available_seats'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        category: json['category'],
        buses: listBuses,
        flights: listFlights,
        hotels: listHotels,
        itineraries: listItineraris,
        variants: listVariants,
        tags: listTag,
        currency: json['currency']);
  }

  Map<String, dynamic> toJsonShow() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['channel'] = this.channel;
    data['description'] = this.description;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    data['close_at'] = this.closeAt;
    data['status'] = this.status;
    data['total_pax'] = this.totalPax;
    data['category'] = this.category;
    data['departure_at'] = this.departureAt;
    data['days'] = this.days;
    data['price_start'] = this.priceStart;
    data['hotel_star'] = this.hotelStar;
    data['total_booking'] = this.totalBooking;
    data['departure_from'] = this.departureFrom;
    data['available_seats'] = this.availableSeats;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.buses != null) {
      data['buses'] = this.buses.map((v) => v.toJson()).toList();
    }
    if (this.flights != null) {
      data['flights'] = this.flights.map((v) => v.toJson()).toList();
    }
    if (this.hotels != null) {
      data['hotels'] = this.hotels.map((v) => v.toJson()).toList();
    }
    if (this.itineraries != null) {
      data['itineraries'] = this.itineraries.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Listing.fromJsonInvoice(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    pict = json['pict'] != null ? new Pict.fromJson(json['pict']) : null;
    departureAt = json['departure_at'];
    days = json['days'];
    arrivalAt = json['arrival_at'];
  }

  Map<String, dynamic> toJsonInvoice() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    data['departure_at'] = this.departureAt;
    data['days'] = this.days;
    data['arrival_at'] = this.arrivalAt;
    return data;
  }

  Listing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    channel = json['channel'];
    description = json['description'];
    pict = json['pict'] != null ? new Pict.fromJson(json['pict']) : null;
    closeAt = json['close_at'];
    status = json['status'];
    totalPax = json['total_pax'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
    departureAt = json['departure_at'];
    days = json['days'];
    priceStart = json['price_start'];
    currency = json['currency'];
    hotelStar = json['hotel_star'];
    totalBooking = json['total_booking'];
    departureFrom = json['departure_from'];
    availableSeats = json['available_seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['channel'] = this.channel;
    data['description'] = this.description;
    if (this.pict != null) {
      data['pict'] = this.pict.toJson();
    }
    data['close_at'] = this.closeAt;
    data['status'] = this.status;
    data['total_pax'] = this.totalPax;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    data['departure_at'] = this.departureAt;
    data['days'] = this.days;
    data['price_start'] = this.priceStart;
    data['currency'] = this.currency;
    data['hotel_star'] = this.hotelStar;
    data['total_booking'] = this.totalBooking;
    data['departure_from'] = this.departureFrom;
    data['available_seats'] = this.availableSeats;
    return data;
  }
}
