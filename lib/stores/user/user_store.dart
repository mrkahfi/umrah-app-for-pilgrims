import 'package:app_jamaah_boilerplate/constants/strings.dart';
import 'package:app_jamaah_boilerplate/data/repository.dart';
import 'package:app_jamaah_boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:app_jamaah_boilerplate/stores/error/error_store.dart';
import 'package:app_jamaah_boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:sentry/sentry.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  final SentryClient sentry = new SentryClient(dsn: Strings.SENTRY_KEY);

  // constructor:---------------------------------------------------------------
  _UserStoreBase(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Users> emptyUserResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Users> fetchUserFuture =
      ObservableFuture<Users>(emptyUserResponse);

  @observable
  Users user;

  @observable
  bool success = false;

  @observable
  bool loadUser = false;

  @observable
  bool deleted = false;

  @computed
  bool get userIsEmpty => user == null;

  @observable
  bool isLogin = false;

  @action
  Future isLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Preferences.auth_token);

    if (token != null) {
      isLogin = true;
      print('isLogin User True.......');
    } else {
      isLogin = false;
      print('isLogin User False.......');
    }
  }

  @action
  Future getUser() async {
    loadUser = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(Preferences.auth_token);

    if (token != null) {
      final future = _repository.getUser();
      fetchUserFuture = ObservableFuture(future);
      future.then((user) {
        loadUser = false;
        success = true;
        this.user = user;
      }).catchError((error) async {
        this.user = null;
        loadUser = false;
        success = false;
        // await sentry.captureException(
        //   exception: error,
        // );
        errorStore.errorMessage = DioErrorUtil.handleError(error);
      });
    }
  }

  @action
  Future logout(Users user) async {
    final future = _repository.deleteUser(user);

    future.then((value) {
      this.deleted = true;
      print('Store........');
      print(value.toString());
      isLoggedIn();
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool(Preferences.isLoggedIn, false);
        prefs.remove(Preferences.auth_token);
      });
    }).catchError((onError) async {
      this.deleted = false;
      // await sentry.captureException(
      //   exception: onError,
      // );
      errorStore.errorMessage = DioErrorUtil.handleError(onError);
    });
  }

  void dispose() {
    success = false;
  }
}
