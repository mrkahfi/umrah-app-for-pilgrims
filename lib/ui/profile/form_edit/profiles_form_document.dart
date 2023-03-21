import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_form_store.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/utils/device_utils.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfilesFormDocumentPage extends StatefulWidget {
  @override
  _ProfilesFormDocumentPageState createState() => _ProfilesFormDocumentPageState();
}

class _ProfilesFormDocumentPageState extends State<ProfilesFormDocumentPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfileFormStore _profilesFormStore;
  ProfileStore _profilesStore;
  DateTime _issuedAtDateTime;
  DateTime _lastUmrohAtDateTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _profilesStore = Provider.of<ProfileStore>(context);
    _profilesFormStore = Provider.of<ProfileFormStore>(context);
    setDocument();
  }

  void setDocument() {
    if (_profilesStore.profiles != null) {
      if (_profilesStore.profiles.passportName != null)
        _profilesFormStore
            .setNamePassport(_profilesStore.profiles.passportName);
      if (_profilesStore.profiles.passportNumber != null)
        _profilesFormStore
            .setNumberPassport(_profilesStore.profiles.passportNumber);
      if (_profilesStore.profiles.passportIssuedIn != null)
        _profilesFormStore
            .setIssuedInPassport(_profilesStore.profiles.passportIssuedIn);
      if (_profilesStore.profiles.umroh != null)
        _profilesFormStore.setUmroh(_profilesStore.profiles.umroh);
      if (_profilesStore.profiles.note != null)
        _profilesFormStore.setNote(_profilesStore.profiles.note);
      if (_profilesStore.profiles.officeImigration != null)
        _profilesFormStore
            .setOfficeImigration(_profilesStore.profiles.officeImigration);
      if (_profilesStore.profiles.officeKemenag != null)
        _profilesFormStore
            .setOfficeKemenag(_profilesStore.profiles.officeKemenag);
      if (_profilesStore.profiles.passportIssuedAt != null) {
        _issuedAtDateTime = DateTime.parse(ConvertVar.dateToConvert(
                _profilesStore.profiles.dateOfBirth, "yyyy-MM-dd")
            .split('.')
            .reversed
            .join());
        _profilesFormStore.setIssuedAtPassport(_issuedAtDateTime);
      }
      if (_profilesStore.profiles.lastUmrohAt != null) {
        _lastUmrohAtDateTime = DateTime.parse(ConvertVar.dateToConvert(
                _profilesStore.profiles.dateOfBirth, "yyyy-MM-dd")
            .split('.')
            .reversed
            .join());
        _profilesFormStore.setLastUmrohAt(_lastUmrohAtDateTime);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _profilesFormStore.disposeInfoDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: true,
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text('Lengkapi Informasi Data Dokumen'),
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
              Expanded(flex: 2, child: _buildFormDocument()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormDocument() {
    return Material(
      color: ListAppTheme.buildLightTheme().backgroundColor,
      child: Stack(
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(0.0), child: _buildForm()),
          Observer(
            builder: (context) {
              return _profilesFormStore.success
                  ? navigate(context)
                  : _showErrorMessage(
                      _profilesFormStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _profilesFormStore.loading,
                child: CustomProgressBar(),
              );
            },
          )
        ],
      ),
    );
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
            _buildNamePassportField(),
            _buildNumberPassportField(),
            _buildIssuedInPassportField(),
            _buildIssuedAtPassportField(),
            _buildUmrohField(),
            _buildLastUmrohAtField(),
            _buildOfficeImigrationField(),
            _buildOfficeKemenagField(),
            _buildNoteField(),
            _buildImagePassportField(),
            _buildImageYellowPassportField(),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: 'Simpan',
      buttonColor: Colors.blue,
      textColor: Colors.white,
      onPressed: () async {
          DeviceUtils.hideKeyboard(context);
          _profilesFormStore.updateFormDocument(_profilesStore.profiles.slug);
      },
    );
  }

  Widget _buildNamePassportField() {
    return FormBuilderTextField(
      attribute: "name_passport",
      decoration: const InputDecoration(
        labelText: 'Nama Di Passport',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.namePassport,
      onChanged: (val) {
        _profilesFormStore.setNamePassport(val);
      },
    );
  }

  Widget _buildNumberPassportField() {
    return FormBuilderTextField(
      attribute: "number_passport",
      decoration: const InputDecoration(
        labelText: 'Nomor Passport',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.numberPassport,
      onChanged: (val) {
        _profilesFormStore.setNumberPassport(val);
      },
    );
  }

  Widget _buildIssuedInPassportField() {
    return FormBuilderTextField(
      attribute: "issued_in_passport",
      decoration: const InputDecoration(
        labelText: 'Dicetak di',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.issuedInPassport,
      onChanged: (val) {
        _profilesFormStore.setIssuedInPassport(val);
      },
    );
  }

  Widget _buildIssuedAtPassportField() {
    return FormBuilderDateTimePicker(
      attribute: 'issued_at_passport',
      onChanged: (value) => _profilesFormStore.setIssuedAtPassport(value),
      inputType: InputType.date,
      decoration: const InputDecoration(
        labelText: 'Tanggal Cetak (Passport Issued)',
      ),
      validators: [FormBuilderValidators.required()],
      locale: Locale('id'),
      initialValue: _issuedAtDateTime,
    );
  }

  Widget _buildUmrohField() {
    return FormBuilderChoiceChip(
        attribute: 'umroh',
        decoration: const InputDecoration(
          labelText: 'Sudah Pernah Umroh?',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.umroh,
        onChanged: (val) => _profilesFormStore.setUmroh(val),
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.umrohList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildLastUmrohAtField() {
    return FormBuilderDateTimePicker(
      attribute: 'last_umroh_at',
      onChanged: (value) => _profilesFormStore.setLastUmrohAt(value),
      inputType: InputType.date,
      decoration: const InputDecoration(
        labelText: 'Berangkat Terakhir Pada (Bila Pernah Umroh)',
      ),
      validators: [FormBuilderValidators.required()],
      locale: Locale('id'),
      initialValue: _lastUmrohAtDateTime,
    );
  }

  Widget _buildOfficeImigrationField() {
    return FormBuilderTextField(
      attribute: "office_imigration",
      decoration: const InputDecoration(
        labelText: 'Kantor Imigrasi',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.officeImigration,
      onChanged: (val) => _profilesFormStore.setOfficeImigration(val),
    );
  }

  Widget _buildOfficeKemenagField() {
    return FormBuilderTextField(
      attribute: "office_kemenag",
      decoration: const InputDecoration(
        labelText: 'Kantor Kemenag',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.officeKemenag,
      onChanged: (val) => _profilesFormStore.setOfficeKemenag(val),
    );
  }

  Widget _buildNoteField() {
    return FormBuilderTextField(
      attribute: "note",
      decoration: const InputDecoration(
        labelText: 'Catatan',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.note,
      onChanged: (val) => _profilesFormStore.setNote(val),
    );
  }

  Widget _buildImagePassportField() {
    List urlPhoto = _profilesStore.profiles.scanPassport.url
        .contains("/image-not-found.png")
        ? []
        : [_profilesStore.profiles.scanPassport.medium.url];
    return FormBuilderImagePicker(
      attribute: 'image_passport',
      decoration: const InputDecoration(
        labelText: 'Foto Passport',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.scanPassport.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImagePassport(val[0])
          : print(val.toString().length),
    );
  }

  Widget _buildImageYellowPassportField() {
    List urlPhoto = _profilesStore.profiles.scanYellowCard.url
            .contains("/image-not-found.png")
        ? []
        : [_profilesStore.profiles.scanYellowCard.medium.url];
    return FormBuilderImagePicker(
      attribute: 'image_yellow_passport',
      decoration: const InputDecoration(
        labelText: 'Foto Kartu Kuning',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.scanYellowCard.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImageYellowCard(val[0])
          : print(val.toString().length),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.pop(context, true);
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
}