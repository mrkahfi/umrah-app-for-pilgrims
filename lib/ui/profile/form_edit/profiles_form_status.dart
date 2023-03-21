import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_form_store.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_store.dart';
import 'package:app_jamaah_boilerplate/utils/device_utils.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfilesFormStatusPage extends StatefulWidget {
  @override
  _ProfilesFormStatusPageState createState() => _ProfilesFormStatusPageState();
}

class _ProfilesFormStatusPageState extends State<ProfilesFormStatusPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfileFormStore _profilesFormStore;
  ProfileStore _profilesStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _profilesStore = Provider.of<ProfileStore>(context);
    _profilesFormStore = Provider.of<ProfileFormStore>(context);
    setStatus();
  }

  void setStatus() {
    if (_profilesStore.profiles != null) {
      if (_profilesStore.profiles.marriage != null)
        _profilesFormStore.setMariage(_profilesStore.profiles.marriage);
      if (_profilesStore.profiles.noMarriage != null)
        _profilesFormStore.setNumberMariage(_profilesStore.profiles.noMarriage);
      if (_profilesStore.profiles.noKk != null)
        _profilesFormStore.setNumberKK(_profilesStore.profiles.noKk);
      if (_profilesStore.profiles.noKtp != null)
        _profilesFormStore.setNumberKtp(_profilesStore.profiles.noKtp);
      if (_profilesStore.profiles.education != null)
        _profilesFormStore.setEducation(_profilesStore.profiles.education);
      if (_profilesStore.profiles.job != null)
        _profilesFormStore.setJob(_profilesStore.profiles.job);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _profilesFormStore.disposeInfoStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: true,
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text('Lengkapi Informasi Data Status'),
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
              Expanded(flex: 2, child: _buildFormStatus()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormStatus() {
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
            _buildStatusField(),
            _buildNumberMariageField(),
            _buildNumberKKField(),
            _buildNumberKtpField(),
            _buildEducationField(),
            _buildJobField(),
            _buildImageMariageField(),
            _buildImageKKField(),
            _buildImageBornField(),
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
        _profilesFormStore.updateFormStatus(_profilesStore.profiles.slug);
      },
    );
  }

  Widget _buildStatusField() {
    return FormBuilderChoiceChip(
        attribute: 'mariage',
        decoration: const InputDecoration(
          labelText: 'Status',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.mariage,
        onChanged: (val) => _profilesFormStore.setMariage(val),
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.mariageList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildNumberMariageField() {
    return FormBuilderTextField(
      attribute: "number_mariage",
      decoration: const InputDecoration(
        labelText: 'Nomor Akta Nikah (Wajib diisi bila status Menikah)',
      ),
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.numberMariage,
      onChanged: (val) {
        _profilesFormStore.setNumberMariage(val);
      },
    );
  }

  Widget _buildNumberKKField() {
    return FormBuilderTextField(
      attribute: "number_kk",
      decoration: const InputDecoration(
        labelText: 'Nomor Kartu Keluarga (KK)',
      ),
      keyboardType: TextInputType.number,
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.numberKK,
      onChanged: (val) {
        _profilesFormStore.setNumberKK(val);
      },
    );
  }

  Widget _buildNumberKtpField() {
    return FormBuilderTextField(
      attribute: "number_ktp",
      decoration: const InputDecoration(
        labelText: 'Nomor KTP',
      ),
      keyboardType: TextInputType.number,
      validators: [FormBuilderValidators.required()],
      initialValue: _profilesFormStore.numberKtp,
      onChanged: (val) {
        _profilesFormStore.setNumberKtp(val);
      },
    );
  }

  Widget _buildEducationField() {
    return FormBuilderChoiceChip(
        attribute: 'education',
        decoration: const InputDecoration(
          labelText: 'Pendidikan',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.education,
        onChanged: (val) => _profilesFormStore.setEducation(val),
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.educationList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildJobField() {
    return FormBuilderChoiceChip(
        attribute: 'job',
        decoration: const InputDecoration(
          labelText: 'Pekerjaan',
        ),
        spacing: 10,
        initialValue: _profilesFormStore.job,
        onChanged: (val) => _profilesFormStore.setJob(val),
        validators: [FormBuilderValidators.required()],
        options: _profilesFormStore.jobList.map((String value) {
          return new FormBuilderFieldOption(
            child: new Text(value),
            value: value,
          );
        }).toList());
  }

  Widget _buildImageMariageField() {
    List urlPhoto = _profilesStore.profiles.scanMarriageBook.url
            .contains("/image-not-found.png")
        ? []
        : [_profilesStore.profiles.scanMarriageBook.medium.url];
    return FormBuilderImagePicker(
      attribute: 'image_mariage',
      decoration: const InputDecoration(
        labelText: 'Foto Akta Nikah',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.scanMarriageBook.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImageMariage(val[0])
          : print(val.toString().length),
    );
  }

  Widget _buildImageKKField() {
    List urlPhoto = _profilesStore.profiles.scanFamilyCard.url
            .contains("/image-not-found.png")
        ? []
        : [_profilesStore.profiles.scanFamilyCard.medium.url];
    return FormBuilderImagePicker(
      attribute: 'image_family_card',
      decoration: const InputDecoration(
        labelText: 'Foto Kartu Keluarga (KK)',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.scanFamilyCard.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImageKK(val[0])
          : print(val.toString().length),
    );
  }

  Widget _buildImageBornField() {
    List urlPhoto = _profilesStore.profiles.scanBirthCertificate.url
            .contains("/image-not-found.png")
        ? []
        : [_profilesStore.profiles.scanBirthCertificate.medium.url];
    return FormBuilderImagePicker(
      attribute: 'image_family_card',
      decoration: const InputDecoration(
        labelText: 'Foto Kartu Keluarga (KK)',
      ),
      defaultImage: AssetImage("assets/images/add-photo.png"),
      maxImages: 1,
      iconColor: Colors.red,
      initialValue: urlPhoto,
      validators: [
        FormBuilderValidators.required(),
        (images) {
          if (images[0].toString().contains(
              "${Endpoints.baseUrl}${_profilesStore.profiles.scanBirthCertificate.medium.url}")) {
            return 'Silahkan masukan foto';
          }
          return null;
        }
      ],
      onChanged: (val) => (val.toString().length > 0)
          ? _profilesFormStore.setImageBorn(val[0])
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
