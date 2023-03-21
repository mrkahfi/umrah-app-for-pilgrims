import 'app_components.dart' as _i1;
import '../modules/local_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import '../../data/network/dio_client.dart' as _i6;
import '../../data/network/apis/base_api.dart' as _i7;
import '../../data/local/datasources/user_datasource.dart' as _i8;
import '../../data/repository.dart' as _i9;
import 'dart:async' as _i10;
import '../modules/network_module.dart' as _i11;
import '../../main.dart' as _i12;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._localModule, this._preferenceModule);

  final _i2.LocalModule _localModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Dio _singletonDio;

  _i6.DioClient _singletonDioClient;

  _i7.BaseApi _singletonBaseApi;

  _i8.UserDataSource _singletonUserDataSource;

  _i9.Repository _singletonRepository;

  static _i10.Future<_i1.AppComponent> create(
      _i11.NetworkModule _,
      _i2.LocalModule localModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(localModule, preferenceModule);

    return injector;
  }

  _i12.MyApp _createMyApp() => _i12.MyApp();
  _i9.Repository _createRepository() =>
      _singletonRepository ??= _localModule.provideRepository(_createBaseApi(),
          _createSharedPreferenceHelper(), _createUserDataSource());
  _i7.BaseApi _createBaseApi() =>
      _singletonBaseApi ??= _localModule.provideListingApi(_createDioClient());
  _i6.DioClient _createDioClient() =>
      _singletonDioClient ??= _localModule.provideDioClient(_createDio());
  _i5.Dio _createDio() => _singletonDio ??=
      _localModule.provideDio(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  _i8.UserDataSource _createUserDataSource() =>
      _singletonUserDataSource ??= _localModule.provideUserDataSource();
  @override
  _i12.MyApp get app => _createMyApp();
  @override
  _i9.Repository getRepository() => _createRepository();
}
