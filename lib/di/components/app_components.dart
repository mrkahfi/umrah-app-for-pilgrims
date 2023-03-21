import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/di/modules/local_module.dart';
import 'package:app_jamaah_boilerplate/di/modules/network_module.dart';
import 'package:app_jamaah_boilerplate/di/modules/preference_module.dart';
import 'package:app_jamaah_boilerplate/main.dart';
import 'package:inject/inject.dart';

import 'app_components.inject.dart' as g;


/// The top level injector that stitches together multiple app features into
/// a complete app.
@Injector(const [NetworkModule, LocalModule, PreferenceModule])
abstract class AppComponent {
  @provide
  MyApp get app;

  static Future<AppComponent> create(
      NetworkModule networkModule,
      LocalModule localModule,
      PreferenceModule preferenceModule,
      ) async {
    return await g.AppComponent$Injector.create(
      networkModule,
      localModule,
      preferenceModule,
    );
  }

  /// An accessor to RestClient object that an application may use.
  @provide
  Repository getRepository();

}