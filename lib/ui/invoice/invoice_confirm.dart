
import 'package:app_jamaah_boilerplate/constants/list_app_theme.dart';
import 'package:app_jamaah_boilerplate/widgets/custom_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class InvoiceConfirmPage extends StatefulWidget {
  @override
  _InvoiceConfirmPageState createState() => _InvoiceConfirmPageState();
}

class _InvoiceConfirmPageState extends State<InvoiceConfirmPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onDestroy.listen((_) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
        flutterWebViewPlugin.dispose();
        flutterWebViewPlugin.cleanCookies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String tokenArguments = ModalRoute.of(context).settings.arguments;
    return WebviewScaffold(
        url: "https://app.sandbox.midtrans.com/snap/v2/vtweb/$tokenArguments",
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
            backgroundColor: ListAppTheme.buildLightTheme().backgroundColor,
            elevation: 0,
            title: Text('Metode Pembayaran'),
            leading: new IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: ListAppTheme.buildLightTheme().backgroundColor,
          child: const Center(
            child: CustomProgressBar(),
          ),
        ));
  }
}
