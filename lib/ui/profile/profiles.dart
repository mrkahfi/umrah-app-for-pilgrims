import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_store.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:app_jamaah_boilerplate/widgets/linear_percent_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  ProfileStore _profilesStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profilesStore = Provider.of<ProfileStore>(context);

    var slug = ModalRoute.of(context).settings.arguments;
    if (!_profilesStore.loading) {
      _profilesStore.getProfile(slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        elevation: 0,
        title: Text('Lengkapi Informasi Jamaah'),
        leading: IconButton(
          icon: Icon(
            Icons.close,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: ListAppTheme.buildLightTheme().backgroundColor,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_profilesStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_profilesStore.errorStore.errorMessage);
        }
        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: "Profiles",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _profilesStore.loading
            ? CustomProgressBar()
            : Material(child: _buildMainContentView());
      },
    );
  }

  Widget _buildMainContentView() {
    return Padding(padding: EdgeInsets.only(top: 20), child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [_buildProfileList()],
    ));
  }

  navigate(String routes) async {
    var result = await Navigator.of(context).pushNamed(routes);
    if (result == null) {
      result = false;
    } else {
      var slug = ModalRoute.of(context).settings.arguments;
      _profilesStore.getProfile(slug);
    }
  }

  Widget _buildProfileList() {
    List<Widget> list = new List<Widget>();
    list.add(LinearPercentWidget(
      textTitle: "Informasi Data Diri",
      textPercent: "${((_profilesStore.infoSelf.length / 6) * 100).round()}%",
      percent: ((_profilesStore.infoSelf.length / 6) * 100) / 100,
      callback: () {
        navigate(Routes.profilesFormSelf);
      },
    ));
    list.add(LinearPercentWidget(
      textTitle: "Informasi Kontak",
      textPercent:
          "${((_profilesStore.infoContact.length / 3) * 100).round()}%",
      percent: ((_profilesStore.infoContact.length / 3) * 100) / 100,
      callback: () {
        navigate(Routes.profilesFormContact);
      },
    ));
    list.add(LinearPercentWidget(
      textTitle: "Informasi Keluarga",
      textPercent: "${((_profilesStore.infoFamily.length / 2) * 100).round()}%",
      percent: ((_profilesStore.infoFamily.length / 2) * 100) / 100,
      callback: () {
        navigate(Routes.profilesFormFamily);
      },
    ));
    list.add(LinearPercentWidget(
      textTitle: "Informasi Passport",
      textPercent:
          "${((_profilesStore.infoDocument.length / 12) * 100).round()}%",
      percent: ((_profilesStore.infoDocument.length / 12) * 100) / 100,
      callback: () {
        navigate(Routes.profilesFormDocument);
      },
    ));
    list.add(LinearPercentWidget(
      textTitle: "Informasi Status",
      textPercent: "${((_profilesStore.infoStatus.length / 9) * 100).round()}%",
      percent: ((_profilesStore.infoStatus.length / 9) * 100) / 100,
      callback: () {
        navigate(Routes.profilesFormStatus);
      },
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: list,
    );
  }
}
