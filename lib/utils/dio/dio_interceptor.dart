import 'package:app_jamaah_boilerplate/constants/endpoints.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class DioInterceptor{
  static Dio provideDio(Dio dio) {
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
            // var prefs = await SharedPreferences.getInstance();
            var isAuth = GetStorage().read(Preferences.auth_token);

            // getting token
            // var token = prefs.getString(Preferences.auth_token);
            // print('Auth token is $token');

            if (isAuth != null) {
              print('Auth token is $isAuth');
              options.headers.putIfAbsent('Authorization', () => "Token token="+isAuth);
            } else {
              print('Auth token is null');
            }
          },
        ),
      );
    return dio;
  }
}