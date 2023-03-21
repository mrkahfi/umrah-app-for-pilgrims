import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:app_jamaah_boilerplate/stores/booking/booking_store.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddJamaahPage extends StatefulWidget {
  @override
  _AddJamaahPageState createState() => _AddJamaahPageState();
}

class _AddJamaahPageState extends State<AddJamaahPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameController = new TextEditingController();
  BookingStore _bookingStore;
  ListingStore _listingStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bookingStore = Provider.of<BookingStore>(context);
    _listingStore = Provider.of<ListingStore>(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Users user = ModalRoute.of(context).settings.arguments;
    if (user != null) {
      _bookingStore.setNameJamaah(user.name);
      nameController.text = _bookingStore.nameJamaah;
      nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: nameController.text.length));
    }
    if (_bookingStore.jamaah != null) {
      nameController.text = _bookingStore.jamaah.name;
      nameController.selection = TextSelection.fromPosition(
          TextPosition(offset: nameController.text.length));
      _bookingStore.dropdownVariant = '${_bookingStore.jamaah.paket}';
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: true,
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text(
          "Data Jama'ah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FormBuilder(
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
              Expanded(flex: 2, child: _buildFormJamaah()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormJamaah() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(padding: const EdgeInsets.all(20), child: _buildNameField()),
        Padding(
            padding: const EdgeInsets.all(20),
            child: _buildDropdownVariantField()),
        Padding(padding: const EdgeInsets.all(20), child: _buildSubmitButton()),
      ],
    );
  }

  Widget _buildDropdownVariantField() {
    return Observer(builder: (context) {
      return FormBuilderDropdown(
        attribute: 'variant',
        decoration: const InputDecoration(
          labelText: 'Jenis Paket',
        ),
        hint: Text('Pilih Variant'),
        onChanged: (val) {
          _bookingStore.setDropdownVariant(val);
        },
        initialValue: _bookingStore.dropdownVariant,
        validators: [FormBuilderValidators.required()],
        items: _listingStore.listing.variants
            .map((value) => DropdownMenuItem(
                  value: value.name,
                  child: Text('${value.name} (${value.price})'),
                ))
            .toList(),
        allowClear: true,
      );
    });
  }

  Widget _buildNameField() {
    // return Observer(builder: (_) {
    return FormBuilderTextField(
      maxLines: 1,
      attribute: "name",
      controller: nameController,
      cursorColor: Colors.blueAccent,
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nama Lengkap',
      ),
      onChanged: (value) {
        _bookingStore.setNameJamaah(value);
      },
      onSaved: (newValue) {
        _bookingStore.setNameJamaah(newValue);
      },
      validators: [FormBuilderValidators.required()],
    );
    // });
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: 'Simpan',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPressed: () async {
        if (_fbKey.currentState.saveAndValidate()) {
          _listingStore.listing.variants.forEach((element) {
            if (_bookingStore.dropdownVariant.contains(element.name)) {
              _bookingStore.setVariant(element);
              if (_bookingStore.jamaah != null) {
                _bookingStore.removeJamaah(_bookingStore.jamaah);
                _bookingStore.addJamaah();
              } else {
                _bookingStore.addJamaah();
              }
            }
          });
          Navigator.pop(context);
        }
      },
    );
  }
}
