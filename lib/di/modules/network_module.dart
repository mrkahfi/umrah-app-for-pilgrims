
import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/data/network/apis/base_api.dart';
import 'package:app_jamaah_boilerplate/data/network/dio_client.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
            var prefs = await SharedPreferences.getInstance();

            // getting token
            var token = prefs.getString(Preferences.auth_token);
            print('Auth token is $token');

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => "Token token="+token);
            } else {
              print('Auth token is null');
            }
          },
        ),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton http_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  // @provide
  // @singleton
  // RestClient provideRestClient() => RestClient();

  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton listing_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  BaseApi provideListingApi(DioClient dioClient) =>
      BaseApi(dioClient);
// Api Providers End:---------------------------------------------------------

// Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton admin_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  // @provide
  // @singleton
  // AdminApi provideAdminApi(DioClient dioClient) =>
  //     AdminApi(dioClient);
// Api Providers End:---------------------------------------------------------

// Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton admin_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  // @provide
  // @singleton
  // SiteApi provideSiteApi(DioClient dioClient) =>
  //     SiteApi(dioClient);
// Api Providers End:---------------------------------------------------------

}
