import 'dart:io';

import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/models/invoice/bank.dart';
import 'package:app_jamaah_boilerplate/models/payment/payment.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import "package:intl/intl.dart";
import 'package:sentry/sentry.dart';
part 'invoice_form_store.g.dart';

class InvoiceFormStore = _InvoiceFormStoreBase with _$InvoiceFormStore;

abstract class _InvoiceFormStoreBase with Store {
  Repository _repository;

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  @observable
  int bankId = 0;

  @observable
  String tipe = '';

  @observable
  String note = '';

  @observable
  String currency = '';

  @observable
  String channelBank = '';

  @observable
  File struk;

  @observable
  Payment invoicePayment;

  @observable
  bool success = false;

  @observable
  bool loading = false;

  static ObservableFuture<Payment> emptyPaymentResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Payment> fetchPaymentFuture =
      ObservableFuture<Payment>(emptyPaymentResponse);

  _InvoiceFormStoreBase(Repository repository) {
    this._repository = repository;
  }

  @action
  Future konfirmasi(String id, bool isMidtrans) async {
    loading = true;
    final date2 = DateTime.now();
    var formatterr = new DateFormat('yyyy-MM-dd hh:mm');
    String tglarr = formatterr.format(date2);
    var confirmData;

    if (struk != null) {
      confirmData = FormData.fromMap({
        "invoices_payment[invoice_id]": id,
        "invoices_payment[bank_id]": bankId,
        "invoices_payment[amount]": total,
        "invoices_payment[tipe]": type.toLowerCase(),
        "invoices_payment[note]": note,
        "invoices_payment[currency]": currency.toLowerCase(),
        "invoices_payment[channel]":
            !isMidtrans ? channelBank.toLowerCase() : "midtrans",
        "invoices_payment[at]": tglarr,
        "invoices_payment[status]": "NEW",
        "invoices_payment[pict]": MultipartFile.fromFileSync(struk.path,
            filename: struk.path.split('/').last,
            contentType: MediaType("image", basename(struk.path))),
      });
    } else {
      confirmData = FormData.fromMap({
        "invoices_payment[invoice_id]": id,
        "invoices_payment[amount]": total,
        "invoices_payment[tipe]": type.toLowerCase(),
        "invoices_payment[note]": note,
        "invoices_payment[channel]":
            !isMidtrans ? channelBank.toLowerCase() : "midtrans",
        "invoices_payment[at]": tglarr,
        "invoices_payment[status]": "NEW",
      });
    }
    // var confirmData = FormData.fromMap({
    //   "invoices_payment[invoice_id]": id,
    //   "invoices_payment[bank_id]": bankId,
    //   "invoices_payment[amount]": total,
    //   "invoices_payment[tipe]": type.toLowerCase(),
    //   "invoices_payment[note]": note,
    //   "invoices_payment[currency]": currency.toLowerCase(),
    //   "invoices_payment[channel]":
    //       !isMidtrans ? channelBank.toLowerCase() : "midtrans",
    //   "invoices_payment[at]": tglarr,
    //   "invoices_payment[status]": "NEW",
    //   "invoices_payment[pict]": MultipartFile.fromFileSync(struk.path,
    //       filename: struk.path.split('/').last,
    //       contentType: MediaType("image", basename(struk.path))),
    // });

    final future = _repository.postInvoice(confirmData);
    fetchPaymentFuture = ObservableFuture(future);

    future.then((invoice) {
      loading = false;
      success = true;
      invoicePayment = invoice;
      print('Success Bayar.......');
    }).catchError((e) async {
      loading = false;
      success = false;
      print('Error Bayar.......');
      await sentry.captureException(
        exception: e,
      );
      errorStore.errorMessage = DioErrorUtil.handleError(e);
    });
  }

  // store variables:-----------------------------------------------------------
  @observable
  String rekBank;

  @observable
  String total;

  @observable
  String type;

  @observable
  List<String> dropdownBank = new List<String>();

  @observable
  List<String> dropdownType = ["DP", "CICILAN", "PERLENGKAPAN"];

  @observable
  List<String> dropdownChannel = ["BANK", "DEBIT", "CASH"];

  @observable
  List<String> dropdownCurrency = ["IDR", "USD"];

  @computed
  ObservableList<String> get listDropdownBank =>
      ObservableList.of(dropdownBank);

  @computed
  bool get haslistDropdownBank => listDropdownBank.isNotEmpty;

  @action
  void setRekBank(String value) {
    rekBank = value;
  }

  @action
  void setCurrency(String value) {
    currency = value;
  }

  @action
  void setChannel(String value) {
    channelBank = value;
  }

  @action
  void setBankId(int value) {
    bankId = value;
  }

  @action
  void setTotal(String value) {
    total = value;
  }

  @action
  void setType(String value) {
    type = value;
  }

  @action
  void setNote(String value) {
    note = value;
  }

  // actions:-------------------------------------------------------------------
  @action
  void setStruk(File value) {
    struk = value;
  }

  @action
  void setDropdownValue(ObservableList<Bank> bankList) {
    if (this.dropdownBank.length > 0) {
      this.dropdownBank.clear();
    }
    bankList.asMap().forEach((index, value) {
      this.dropdownBank.add("${value.bank} (${value.number})");
      if (index == 0) {
        this.rekBank = "${value.bank} (${value.number})";
      }
    });
  }

  void dispose() {
    success = false;
  }
}
