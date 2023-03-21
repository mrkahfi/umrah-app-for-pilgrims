import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/signup/signup_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/utils/device_utils.dart';
import 'package:app_jamaah_boilerplate/widgets/app_icon_widget.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  SignUpStore _signUpStore;
  SiteStore _siteStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _signUpStore = Provider.of<SignUpStore>(context);
    _siteStore = Provider.of<SiteStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _signUpStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        primary: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 2, child: _buildFormSignUp(context)),
              ],
            ),
          ),
        ));
  }

  Widget _buildFormSignUp(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(0.0),
              child: Center(child: _buildForm(context))),
          Observer(
            builder: (context) {
              return _signUpStore.success
                  ? navigate(context)
                  : _showErrorMessage(_signUpStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _signUpStore.loading,
                child: CustomProgressBar(),
              );
            },
          )
        ],
      ),
    );
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

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.isLoggedIn, true);
      print('Login..........');
      print(prefs.getBool(Preferences.isLoggedIn));
    });
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });
    return Container();
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            SizedBox(height: 24.0),
            (_siteStore.branch != null) ? _buildBranchTravel() : Container(),
            SizedBox(height: 10),
            _buildNameField(),
            SizedBox(height: 15),
            _buildEmailField(),
            SizedBox(height: 15),
            _buildPhoneField(),
            SizedBox(height: 15),
            _buildSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchTravel() {
    return FormBuilderDropdown(
      attribute: "branch",
      decoration: InputDecoration(
        labelText: "Pilih Cabang Anda Bergabung",
        border: OutlineInputBorder(),
      ),
      // initialValue: 'Male',
      onChanged: (val) {
        EndpointsAPI endpointsAPI = _siteStore.site.branchs
            .firstWhere((element) => element.domain == val);
        _signUpStore.setBranch(endpointsAPI);
      },

      hint: Text('Pilih Cabang'),
      validators: [FormBuilderValidators.required()],
      items: _siteStore.site.branchs
          .map((branch) => DropdownMenuItem(
              value: branch.domain, child: Text("${branch.name}")))
          .toList(),
    );
  }

  Widget _buildEmailField() {
    return FormBuilderTextField(
      attribute: "email",
      decoration: const InputDecoration(
        labelText: 'Email Aktif',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.email()
      ],
      keyboardType: TextInputType.emailAddress,
      // initialValue: _formStore.email,
      onChanged: (val) {
        _signUpStore.setEmail(val);
      },
    );
  }

  Widget _buildNameField() {
    return FormBuilderTextField(
      attribute: "name",
      decoration: const InputDecoration(
        labelText: 'Nama Lengkap',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
      validators: [
        FormBuilderValidators.required(),
      ],
      keyboardType: TextInputType.name,
      // initialValue: _formStore.password,
      onChanged: (val) => _signUpStore.setFullname(val),
    );
  }

  Widget _buildPhoneField() {
    return FormBuilderTextField(
      attribute: "phone",
      decoration: const InputDecoration(
        labelText: 'Nomor HP Aktif',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
      validators: [
        FormBuilderValidators.required(),
      ],
      keyboardType: TextInputType.number,
      // initialValue: _formStore.password,
      onChanged: (val) => _signUpStore.setPhone(val),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return RoundedButtonWidget(
      buttonText: 'DAFTAR',
      buttonColor: _signUpStore.canSignUp ? Colors.blue : Colors.grey,
      textColor: Colors.white,
      onPressed: () async {
        if (_fbKey.currentState.saveAndValidate()) {
          DeviceUtils.hideKeyboard(context);
          _signUpStore.signUp();
        }
      },
    );
  }
}
