import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/stores/inbox/inbox_store.dart';
import 'package:app_jamaah_boilerplate/utils/convert/convert.dart';
import 'package:app_jamaah_boilerplate/widgets/card_widget.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> with TickerProviderStateMixin {
  AnimationController animationController;
  InboxStore _inboxStore;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _inboxStore = Provider.of<InboxStore>(context);

    if (_inboxStore.isInboxEmpty) {
      _inboxStore.getInboxes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
        title: Text("Inbox"),
      ),
      body: Stack(
        children: <Widget>[
          _buildInboxError(),
          _handleErrorMessage(),
          Padding(
              padding: EdgeInsets.only(top: 16), child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_inboxStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_inboxStore.errorStore.errorMessage);
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
          title: "Error",
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
    return SizedBox.shrink();
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _inboxStore.loading || !_inboxStore.success
            ? CustomProgressBar()
            : RefreshIndicator(
                onRefresh: refreshData, child: _buildListContent());
      },
    );
  }

  Widget _buildListContent() {
    return !_inboxStore.isInboxEmpty
        ? ListView.builder(
            itemCount: _inboxStore.inboxListData.length,
            itemBuilder: (_, position) {
              final int count = _inboxStore.inboxListData.length > 10
                  ? 10
                  : _inboxStore.inboxListData.length;
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * position, 1.0,
                          curve: Curves.fastOutSlowIn)));
              animationController.forward();
              return CardWidget(
                animation: animation,
                animationController: animationController,
                callback: () {
                  _showDialog(
                      ConvertVar.parseHtmlString(
                          _inboxStore.inboxListData[position].message),
                      _inboxStore.inboxListData[position].id.toString(),
                      _inboxStore.inboxListData[position].read);
                },
                column: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _inboxStore.inboxListData[position].read
                          ? ListAppTheme.buildLightTheme().splashColor
                          : ListAppTheme.buildLightTheme().backgroundColor,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("User"),
                            Text(ConvertVar.dateTimeToConvert(
                                _inboxStore.inboxListData[position].createdAt))
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                              "${ConvertVar.parseHtmlString(_inboxStore.inboxListData[position].message[lastString(ConvertVar.parseHtmlString(_inboxStore.inboxListData[position].message))].toUpperCase())}"),
                        ),
                        subtitle: Text(
                            "${ConvertVar.parseHtmlString(_inboxStore.inboxListData[position].message)}",
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              );
            })
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image.asset(
                "assets/images/blank_file.png",
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                "Belum ada item",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )
            ]),
          );
  }

  void _showDialog(String content, String id, bool read) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: [
            Icon(Icons.info),
            Text('  Inbox Detail '),
          ]),
          content: new Text("$content"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("TUTUP"),
              onPressed: () {
                if (!read) {
                  _inboxStore.updateReadInbox(id);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
    });
    return Container();
  }

  Widget _buildInboxError() {
    return Observer(
      builder: (context) {
        return Visibility(
          visible: _inboxStore.loading || _inboxStore.progress,
          child: CustomProgressBar(),
        );
      },
    );
  }

  int lastString(String oldString) {
    return oldString.length - 5;
  }

  Future refreshData() async {
    _inboxStore.getInboxes();
  }
}
