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

class ProfilesFormContactPage extends StatefulWidget {
  @override
  _ProfilesFormContactPageState createState() => _ProfilesFormContactPageState();
}

class _ProfilesFormContactPageState extends State<ProfilesFormContactPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  ProfileFormStore _profilesFormStore;
  ProfileStore _profilesStore;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _profilesStore = Provider.of<ProfileStore>(context);
    _profilesFormStore = Provider.of<ProfileFormStore>(context);
    setContact();
  }

  void setContact() {
    if (_profilesStore.profiles != null) {
      if (_profilesStore.profiles.address != null)
        _profilesFormStore.setAddress(_profilesStore.profiles.address);
      if (_profilesStore.profiles.email != null)
        _profilesFormStore.setEmail(_profilesStore.profiles.email);
      if (_profilesStore.profiles.phone != null)
        _profilesFormStore.setPhone(_profilesStore.profiles.phone);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _profilesFormStore.disposeInfoContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: true,
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text('Lengkapi Informasi Data Kontak'),
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
              Expanded(flex: 2, child: _buildFormContact()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormContact() {
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
            _buildEmailField(),
            SizedBox(height: 15),
            _buildPhoneField(),
            SizedBox(height: 15),
            _buildAddressField(),
            SizedBox(height: 15),
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
          _profilesFormStore.updateFormContact(_profilesStore.profiles.slug);
      },
    );
  }

  Widget _buildEmailField() {
    return FormBuilderTextField(
      attribute: "email",
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validators: [
        FormBuilderValidators.required()
      ],
      keyboardType: TextInputType.emailAddress,
      initialValue: _profilesFormStore.email,
      onChanged: (val) {
        _profilesFormStore.setEmail(val);
      },
    );
  }

  Widget _buildPhoneField() {
    return FormBuilderTextField(
      attribute: "phone",
      decoration: const InputDecoration(
        labelText: 'Nomor HP',
        border: OutlineInputBorder(),
      ),
      validators: [
        FormBuilderValidators.required()
      ],
      keyboardType: TextInputType.number,
      initialValue: _profilesFormStore.phone,
      onChanged: (val) => _profilesFormStore.setPhone(val),
    );
  }

  Widget _buildAddressField() {
    return FormBuilderTextField(
      attribute: "address",
      decoration: const InputDecoration(
        labelText: 'Alamat',
        border: OutlineInputBorder(),
      ),
      validators: [
        FormBuilderValidators.required()
      ],
      keyboardType: TextInputType.text,
      initialValue: _profilesFormStore.address,
      onChanged: (val) => _profilesFormStore.setAddress(val),
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