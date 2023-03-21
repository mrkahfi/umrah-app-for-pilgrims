import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/bank/bank_store.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_confirm_store.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_form_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class InvoiceArguments {
  final String invoiceId;
  final bool isMidtrans;

  InvoiceArguments({this.invoiceId, this.isMidtrans});
}

class InvoiceFormPage extends StatefulWidget {
  @override
  _InvoiceFormPageState createState() => _InvoiceFormPageState();
}

class _InvoiceFormPageState extends State<InvoiceFormPage> {
  // static const KEY_NATIVE_MIDTRANS = "showMidtrans";
  // static const platform =
  //     const MethodChannel("com.example.app_jamaah_boilerplate.channel");
  InvoiceFormStore _invoiceFormStore;
  InvoiceConfirmStore _invoiceConfirmStore;
  SiteStore _siteStore;
  bool isMidtrans;
  String invoiceId;
  BankStore _bankStore;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final FocusNode myFocusNodetotal = FocusNode();
  final TextEditingController totalController = new TextEditingController();
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.', thousandSeparator: ',');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    InvoiceArguments arguments = ModalRoute.of(context).settings.arguments;
    // String arguments = ModalRoute.of(context).settings.arguments;
    isMidtrans = arguments.isMidtrans;
    invoiceId = arguments.invoiceId;
    // initializing stores
    _invoiceFormStore = Provider.of<InvoiceFormStore>(context);
    _invoiceConfirmStore = Provider.of<InvoiceConfirmStore>(context);
    _siteStore = Provider.of<SiteStore>(context);
    _bankStore = Provider.of<BankStore>(context);
    if (!_bankStore.success) _bankStore.getBanks();
    if (_siteStore.isSiteEmpty) {
      _siteStore.getSites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        primary: true,
        appBar: AppBar(
          backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
          elevation: 0,
          title: Text('Konfirmasi Pembayaran'),
          leading: IconButton(
            icon: Icon(
              Icons.close,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
        _loadingFormSubmit(),
        _loadingFormMidtransSubmit()
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_bankStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_bankStore.errorStore.errorMessage);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_bankStore.isBankEmpty) {
          _invoiceFormStore.setDropdownValue(_bankStore.bankListData);
        }
        return _bankStore.loading ? CustomProgressBar() : _buildFormBuilder();
      },
    );
  }

  Widget _loadingFormSubmit() {
    return Observer(
      builder: (context) {
        return _invoiceFormStore.loading
            ? CustomProgressBar()
            : _showErrorMessage(_invoiceFormStore.errorStore.errorMessage);
      },
    );
  }

  Widget _loadingFormMidtransSubmit() {
    return Observer(
      builder: (context) {
        return _invoiceConfirmStore.loading
            ? CustomProgressBar()
            : _showErrorMessage(_invoiceConfirmStore.errorStore.errorMessage);
      },
    );
  }

  Widget _buildFormBuilder() {
    return FormBuilder(
      key: _fbKey,
      child: Container(
        color: const Color(0xFFffffff),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(flex: 2, child: _buildFormInvoice()),
          ],
        ),
      ),
    );
  }

  Widget _buildFormInvoice() {
    return Material(
      color: ListAppTheme.buildLightTheme().backgroundColor,
      child: Stack(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(0.0), child: _buildForm()),
          Observer(
            builder: (context) {
              return _invoiceFormStore.success
                  ? navigate(context)
                  : _showErrorMessage(
                      _invoiceFormStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return _invoiceConfirmStore.success
                  ? navigateToMidtrans(context)
                  : _showErrorMessage(
                      _invoiceConfirmStore.errorStore.errorMessage);
            },
          ),
        ],
      ),
    );
  }

  Widget navigateToMidtrans(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.invoiceConfirm, arguments: _invoiceConfirmStore.midtrans.token);
    });
    return Container();
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (!isMidtrans) {
        Navigator.pop(context, true);
      } else {
        _invoiceConfirmStore
            .getPaymentMidtrans(_invoiceFormStore.invoicePayment.slug);
      }
    });
    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: "Error",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 24.0),
            (!isMidtrans) ? _buildDropdownBankField() : Container(),
            (!isMidtrans) ? _buildDropdownCurrencyField() : Container(),
            (!isMidtrans) ? _buildDropdownChannelField() : Container(),
            _buildDropdownTypeField(),
            _buildTotalField(),
            _buildNoteField(),
            (!isMidtrans) ? _buildImageStrukField() : Container(),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  // Future<Null> _showMidtransNativeView() async {
  //   await platform.invokeMethod(KEY_NATIVE_MIDTRANS, {
  //     'id': _invoiceStore.invoice.number,
  //     'name': _invoiceStore.invoice.listing.name,
  //     'price': _invoiceFormStore.total,
  //     'qty': 1
  //   });
  // }

  Widget _buildTotalField() {
    return FormBuilderTextField(
      maxLines: 1,
      attribute: "total",
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Total Pembayaran',
      ),
      // initialValue: 'Male',
      validators: [FormBuilderValidators.required()],
      onChanged: (val) =>
          _invoiceFormStore.setTotal(controller.numberValue.round().toString()),
    );
  }

  Widget _buildNoteField() {
    return FormBuilderTextField(
      attribute: "note",
      decoration: const InputDecoration(
        labelText: 'Catatan',
      ),
      validators: [FormBuilderValidators.required()],
      // initialValue: 'Male',
      onChanged: (val) => _invoiceFormStore.setNote(val),
    );
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: 'Submit',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPressed: () async {
        if (_fbKey.currentState.saveAndValidate()) {
          _invoiceFormStore.konfirmasi(invoiceId, isMidtrans);
        }
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    totalController.dispose();
    myFocusNodetotal.dispose();
    _invoiceFormStore.dispose();
    _invoiceConfirmStore.dispose();
    super.dispose();
  }

  Widget _buildDropdownBankField() {
    return Observer(builder: (context) {
      return FormBuilderDropdown(
        attribute: 'bank',
        decoration: const InputDecoration(
          labelText: 'Bank Tujuan',
        ),
        // initialValue: 'Male',
        hint: Text('Pilih No. Rek Tujuan'),
        onChanged: (val) {
          _invoiceFormStore.setRekBank(val);
          var rekArr = val.split(' ');
          var rekName = rekArr[0];
          var rekNumb = rekArr[1].replaceAll("(", '');
          rekNumb = rekNumb.replaceAll(")", '');
          _bankStore.bankListData.forEach((data) {
            if (data.bank.contains(rekName) && data.number.contains(rekNumb)) {
              _invoiceFormStore.setBankId(data.id);
            }
          });
        },
        validators: [FormBuilderValidators.required()],
        items: _invoiceFormStore.dropdownBank
            .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text('$value'),
                ))
            .toList(),
        // isExpanded: false,
        allowClear: true,
      );
    });
  }

  Widget _buildDropdownCurrencyField() {
    return FormBuilderChoiceChip(
        attribute: 'currency',
        decoration: const InputDecoration(
          labelText: 'Mata Uang',
        ),
        spacing: 10,
        onChanged: (val) => _invoiceFormStore.setCurrency(val),
        validators: [FormBuilderValidators.required()],
        options: _invoiceFormStore.dropdownCurrency.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildDropdownChannelField() {
    return FormBuilderChoiceChip(
        attribute: 'channel',
        decoration: const InputDecoration(
          labelText: 'Channel Pembayaran',
        ),
        spacing: 10,
        onChanged: (val) => _invoiceFormStore.setChannel(val),
        validators: [FormBuilderValidators.required()],
        options: _invoiceFormStore.dropdownChannel.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildDropdownTypeField() {
    return FormBuilderChoiceChip(
        attribute: 'jenis_pembayaran',
        decoration: const InputDecoration(
          labelText: 'Jenis Pembayaran',
        ),
        spacing: 10,
        validators: [FormBuilderValidators.required()],
        onChanged: (val) => _invoiceFormStore.setType(val),
        options: _invoiceFormStore.dropdownType.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildImageStrukField() {
    return FormBuilderImagePicker(
      attribute: 'struk',
      decoration: const InputDecoration(
        labelText: 'Upload Bukti Pembayaran',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images.length < 1) {
            return 'Silahkan masukan bukti transfer';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 2)
          ? _invoiceFormStore.setStruk(val[0])
          : print(val.toString().length),
    );
  }
}
