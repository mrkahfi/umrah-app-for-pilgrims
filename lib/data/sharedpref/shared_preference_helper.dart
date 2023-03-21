import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const String isLoggedIn = "isLoggedIn";
  static const String auth_token = "authToken";
  static const String phoneSite = "phone_site";
  static const String profileName = "profile_name";
  static const String profileSlug = "profile_slug";
  static const String profileId = "profile_id";
  static const String dbUser = "users";
  static const String dbProfile = "profiles";
  static const String is_dark_mode = "is_dark_mode";
  static const String current_language = "current_language";
  static const String firebase_token = "firebaseToken";
  static const String firebase_token_is_input = "isInput";
}

class SharedPreferenceHelper {
  // shared pref instance
  final Future<SharedPreferences> _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token);
    });
  }

  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

  Future<void> savePhoneSite(String phoneSite) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.phoneSite, phoneSite);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }

  Future<void> removeProfileName() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.profileName);
    });
  }

  Future<void> removeProfileSlug() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.profileSlug);
    });
  }

  Future<void> removeProfileId() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.profileId);
    });
  }

  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token) ?? false;
    });
  }

  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(Preferences.is_dark_mode) ?? false;
    });
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(Preferences.is_dark_mode, value);
    });
  }

  // Language:---------------------------------------------------
  Future<String> get currentLanguage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.current_language);
    });
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(Preferences.current_language, language);
    });
  }

  Future<void> saveFirebaseToken(String firebaseToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, firebaseToken);
    });
  }
}
