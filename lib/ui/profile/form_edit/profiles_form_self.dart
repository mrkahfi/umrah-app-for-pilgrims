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

class ProfilesFormSelfPage extends StatefulWidget {
  @override
  _ProfilesFormSelfPageState createState() => _ProfilesFormSelfPageState();
}

class _ProfilesFormSelfPageState extends State<ProfilesFormSelfPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfileFormStore _profilesFormStore;
  ProfileStore _profilesStore;
  DateTime _dateTime;
  final TextEditingController placeOfBirthController =
      new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _profilesStore = Provider.of<ProfileStore>(context);
    _profilesFormStore = Provider.of<ProfileFormStore>(context);
    setProfiles();
  }

  void setProfiles() {
    if (_profilesStore.profiles != null) {
      _profilesFormStore.setNameKtp(_profilesStore.profiles.name);
      if (_profilesStore.profiles.gender != null)
        _profilesFormStore.setGender(_profilesStore.profiles.gender);
      if (_profilesStore.profiles.placeOfBirth != null)
        _profilesFormStore.setPlaceBirth(_profilesStore.profiles.placeOfBirth);
      if (_profilesStore.profiles.dateOfBirth != null) {
        _dateTime = DateTime.parse(ConvertVar.dateToConvert(
                _profilesStore.profiles.dateOfBirth, "yyyy-MM-dd")
            .split('.')
            .reversed
            .join());
        _profilesFormStore.setDateBirth(_dateTime);
      }
      _profilesFormStore.setClothes(_profilesStore.profiles.clothSize);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _profilesFormStore.disposeInfoSelf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: true,
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text('Lengkapi Informasi Data Diri'),
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
              Expanded(flex: 2, child: _buildFormSelf()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSelf() {
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
                  child: CustomProgressBar());
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
            _buildImageField(),
            _buildNameKtpField(),
            _buildGenderField(),
            _buildPlaceBirthField(),
            _buildBirthField(),
            _buildClothesField(),
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
        _profilesFormStore.updateFormSelf(_profilesStore.profiles.slug);
      },
    );
  }

  Widget _buildPlaceBirthField() {
    return FormBuilderTextField(
      attribute: "places",
      decoration: const InputDecoration(
        labelText: 'Tempat Lahir',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.placeBirth,
      onChanged: (val) {
        _profilesFormStore.setPlaceBirth(val);
      },
    );
  }

  Widget _buildBirthField() {
    return FormBuilderDateTimePicker(
      attribute: 'date',
      onChanged: (value) => _profilesFormStore.setDateBirth(value),
      inputType: InputType.date,
      decoration: const InputDecoration(
        labelText: 'Tanggal lahir',
      ),
      validators: [FormBuilderValidators.required()],
      locale: Locale('id'),
      initialValue: _dateTime,
    );
  }

  Widget _buildClothesField() {
    return FormBuilderChoiceChip(
        attribute: 'clotches',
        decoration: const InputDecoration(
          labelText: 'Ukuran Baju',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.clothes,
        onChanged: (val) => _profilesFormStore.setClothes(val),
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.clotchesList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildGenderField() {
    return FormBuilderChoiceChip(
        attribute: 'genders',
        decoration: const InputDecoration(
          labelText: 'Jenis Kelamin',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.gender,
        onChanged: (val) {
          _profilesFormStore.setGender(val);
        },
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.genderList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildNameKtpField() {
    return FormBuilderTextField(
      attribute: "name",
      decoration: const InputDecoration(
        labelText: 'Nama di KTP',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.nameKtp,
      onChanged: (val) => _profilesFormStore.setNameKtp(val),
    );
  }

  Widget _buildImageField() {
    List urlPhoto =
        _profilesStore.profiles.photo.url.contains("/image-not-found.png")
            ? []
            : [_profilesStore.profiles.photo.medium.url];

    return FormBuilderImagePicker(
      attribute: 'image',
      decoration: const InputDecoration(
        labelText: 'Upload Foto',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.photo.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImageFoto(val[0])
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
