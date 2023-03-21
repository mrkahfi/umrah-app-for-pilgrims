import 'dart:io';

import 'package:app_jamaah_boilerplate/routes.dart';
import 'package:app_jamaah_boilerplate/stores/article/article_store.dart';
import 'package:app_jamaah_boilerplate/stores/bank/bank_store.dart';
import 'package:app_jamaah_boilerplate/stores/booking/booking_store.dart';
import 'package:app_jamaah_boilerplate/stores/endpoint/endpoint_store.dart';
import 'package:app_jamaah_boilerplate/stores/gallery/gallery_store.dart';
import 'package:app_jamaah_boilerplate/stores/inbox/inbox_store.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_confirm_store.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_form_store.dart';
import 'package:app_jamaah_boilerplate/stores/invoice/invoice_store.dart';
import 'package:app_jamaah_boilerplate/stores/language/language_store.dart';
import 'package:app_jamaah_boilerplate/stores/listing/listing_store.dart';
import 'package:app_jamaah_boilerplate/stores/login/login_store.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_form_store.dart';
import 'package:app_jamaah_boilerplate/stores/profiles/profile_store.dart';
import 'package:app_jamaah_boilerplate/stores/quran/quran_store.dart';
import 'package:app_jamaah_boilerplate/stores/signup/signup_store.dart';
import 'package:app_jamaah_boilerplate/stores/site/site_store.dart';
import 'package:app_jamaah_boilerplate/stores/theme/theme_store.dart';
import 'package:app_jamaah_boilerplate/stores/user/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';
import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'di/components/app_components.dart';
import 'di/modules/local_module.dart';
import 'di/modules/network_module.dart';
import 'di/modules/preference_module.dart';
import 'ui/splash/splash.dart';
import 'utils/locale/app_localization.dart';

// global instance for app component
AppComponent appComponent;

void main() async {
  // await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) async {
    appComponent = await AppComponent.create(
      NetworkModule(),
      LocalModule(),
      PreferenceModule(),
    );

    await GlobalConfiguration().loadFromAsset("app_settings");
    runApp(appComponent.app);
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final LanguageStore _languageStore =
      LanguageStore(appComponent.getRepository());
  final ThemeStore _themeStore = ThemeStore(appComponent.getRepository());
  final EndpointStore _endpointStore = EndpointStore(appComponent.getRepository());
  final ListingStore _listingStore = ListingStore(appComponent.getRepository());
  final GalleryStore _galleryStore = GalleryStore(appComponent.getRepository());
  final ArticleStore _articleStore = ArticleStore(appComponent.getRepository());
  final QuranStore _quranStore = QuranStore(appComponent.getRepository());
  final InvoiceStore _invoiceStore = InvoiceStore(appComponent.getRepository());
  final InvoiceConfirmStore _invoiceConfirmStore = InvoiceConfirmStore(appComponent.getRepository());
  final InboxStore _inboxStore = InboxStore(appComponent.getRepository());
  final SiteStore _siteStore = SiteStore(appComponent.getRepository());
  final InvoiceFormStore _invoiceFormStore = InvoiceFormStore(appComponent.getRepository());
  final ProfileStore _profileStore = ProfileStore(appComponent.getRepository());
  final ProfileFormStore _profileFormStore = ProfileFormStore(appComponent.getRepository());
  final BookingStore _bookingStore = BookingStore(appComponent.getRepository());
  final BankStore _bankStore = BankStore(appComponent.getRepository());
  final UserStore _userStore = UserStore(appComponent.getRepository());
  final LoginStore _loginStore = LoginStore(appComponent.getRepository());
  final SignUpStore _signUpStore = SignUpStore(appComponent.getRepository());
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<EndpointStore>(create: (_) => _endpointStore),
        Provider<ListingStore>(create: (_) => _listingStore),
        Provider<GalleryStore>(create: (_) => _galleryStore),
        Provider<ArticleStore>(create: (_) => _articleStore),
        Provider<InvoiceStore>(create: (_) => _invoiceStore),
        Provider<QuranStore>(create: (_) => _quranStore),
        Provider<InvoiceConfirmStore>(create: (_) => _invoiceConfirmStore),
        Provider<InboxStore>(create: (_) => _inboxStore),
        Provider<SiteStore>(create: (_) => _siteStore),
        Provider<InvoiceFormStore>(create: (_) => _invoiceFormStore),
        Provider<ProfileStore>(create: (_) => _profileStore),
        Provider<ProfileFormStore>(create: (_) => _profileFormStore),
        Provider<BookingStore>(create: (_) => _bookingStore),
        Provider<BankStore>(create: (_) => _bankStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<LoginStore>(create: (_) => _loginStore),
        Provider<SignUpStore>(create: (_) => _signUpStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home:  SplashPage(),
          );
        },
      ),
    );
  }
}
