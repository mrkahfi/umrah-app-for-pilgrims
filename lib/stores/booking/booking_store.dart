import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/invoice/invoice.dart';
import 'package:app_jamaah_boilerplate/models/jamaah/jamaah.dart';
import 'package:app_jamaah_boilerplate/models/listing/variant.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
part 'booking_store.g.dart';

class BookingStore = _BookingStoreBase with _$BookingStore;

abstract class _BookingStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _BookingStoreBase(Repository repository) {
    this._repository = repository;
  }

  static ObservableFuture<Invoice> emptyBookingResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Invoice> fetchBookingFuture =
      ObservableFuture<Invoice>(emptyBookingResponse);

  @observable
  String nameJamaah;

  @observable
  String dropdownVariant;

  @observable
  Variants variant;

  @observable
  Jamaah jamaah;

  @observable
  Invoice invoice;

  @observable
  int total;

  @observable
  int totalFee = 0;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool loadingVariantFees = false;

  @observable
  bool switchIsJamaah = false;

  @observable
  ObservableList<Jamaah> listJamaah = ObservableList<Jamaah>();

  @observable
  Map listPaket = new Map();

  @computed
  int get totalAmount => total != null ? total : null;

  @computed
  bool get canBooking =>
      listJamaah != null ? listJamaah.isNotEmpty : listJamaah.isEmpty;

  // actions:-------------------------------------------------------------------
  @action
  Future bookingNow(String listingId, String userName, String userEmail,
      String userPhone) async {
    loading = true;
    var bookingData = FormData.fromMap({
      "invoice[listing_id]": listingId,
      "invoice[user][name]": userName,
      "invoice[user][email]": userEmail,
      "invoice[user][phone]": userPhone
    });
    for (int i = 0; i < listJamaah.length; i++) {
      bookingData.fields
        ..add(
            MapEntry("invoice[bookings][$i][profile_name]", listJamaah[i].name))
        ..add(MapEntry("invoice[bookings][$i][variant_id]",
            listJamaah[i].paketId.toString()));
    }
    print(bookingData.fields.toString());
    final future = _repository.bookingNow(bookingData);
    fetchBookingFuture = ObservableFuture(future);
    future.then((invoice) {
      loading = false;
      success = true;
      this.invoice = invoice;
      print('Success.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  @action
  void addJamaah() {
    if (this.variant != null) {
      final jamaah = Jamaah(
          name: nameJamaah,
          paket: variant.name,
          paketId: variant.id,
          price: variant.price);
      listJamaah.add(jamaah);
      listPaket.clear();
      recalculateCost(jamaah);
    }
  }

  void recalculateCost(Jamaah jamaah) {
    total = 0;
    var map = Map();
    listJamaah.forEach((element) {
      if (!map.containsKey(element.paket)) {
        listPaket.addAll({
          element.paket: {
            "paket": element.paket,
            "price": !listPaket.containsKey(element.paket)
                ? (element.price)
                : (listPaket[element.paket]['price'] + 1 * element.price),
            "count": !listPaket.containsKey(element.paket)
                ? (1)
                : (listPaket[element.paket]['count'] + 1)
          }
        });
      } else {
        listPaket.addAll({
          element.paket: {
            "paket": element.paket,
            "price": !listPaket.containsKey(element.paket)
                ? (element.price)
                : (listPaket[element.paket]['price'] + 1 * element.price),
            "count": !listPaket.containsKey(element.paket)
                ? (1)
                : (listPaket[element.paket]['count'] + 1)
          }
        });
      }
      total = total + element.price;
    });
    print(listPaket);
  }

  @action
  void removeJamaah(Jamaah jamaah) {
    listJamaah.removeWhere((x) => x == jamaah);
    listPaket.clear();
    recalculateCost(jamaah);
  }

  @action
  void setVariant(value) => variant = value;

  @action
  void setJamaah(value) => jamaah = value;

  @action
  void setNameJamaah(value) => nameJamaah = value;

  @action
  void setSwitchJamaah(value) => switchIsJamaah = value;

  @action
  void setDropdownVariant(value) => dropdownVariant = value;

  void dispose() {
    if (listJamaah.isNotEmpty) listJamaah.clear();
  }
}
