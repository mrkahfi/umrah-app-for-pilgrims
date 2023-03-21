import 'package:app_jamaah_boilerplate/constants/db_constant.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:app_jamaah_boilerplate/models/quran/surah.dart';
import 'package:app_jamaah_boilerplate/models/user/users.dart';
import 'package:sembast/sembast.dart';

class UserDataSource {
  final _userStore = intMapStoreFactory.store(DBConstants.STORE_USER_NAME);
  final _endpointStore =
      intMapStoreFactory.store(DBConstants.STORE_ENDPOINT_NAME);
  final _quranStore = intMapStoreFactory.store(DBConstants.STORE_QURANS_NAME);

  // database instance
  final Future<Database> _db;

  // Constructor
  UserDataSource(this._db);

  // DB Users functions:--------------------------------------------------------
  Future<int> insert(Users user) async {
    return await _userStore.add(await _db, user.toJson());
  }

  Future<int> count() async {
    return await _userStore.count(await _db);
  }

  Future<Users> getUserFromDb() async {
    print('Loading user from database');

    // post list
    var user;

    // fetching data
    final recordSnapshots = await _userStore.findFirst(
      await _db,
    );

    user = Users.fromJson(recordSnapshots.value);

    print('Database........');
    print(recordSnapshots.value);
    return user;
  }

  Future<int> insertSession(Users user) async {
    return await _userStore.add(await _db, user.toJson());
  }

  Future<int> delete(Users user) async {
    var finderFirst = Finder(filter: Filter.equals('email', user.email));

    return await _userStore.delete(
      await _db,
      finder: finderFirst,
    );
  }

  Future deleteSession() async {
    await _userStore.drop(
      await _db,
    );
  }

  // DB Endpoint functions:-----------------------------------------------------
  Future<int> insertEndpoint(EndpointsAPI endpoint) async {
    return await _endpointStore.add(await _db, endpoint.toMap());
  }

  Future<EndpointsAPI> getEndpointFromDb() async {
    print('Loading endpoint from database');

    // endpoints list
    var endpoint;

    // fetching data
    final recordSnapshots = await _endpointStore.findFirst(
      await _db,
    );

    endpoint = EndpointsAPI.fromDb(recordSnapshots.value);

    print('Database Endpoint........');
    print(recordSnapshots.value);
    return endpoint;
  }

  Future<int> deleteEndpoint(EndpointsAPI endpoint) async {
    var finderFirst = Finder(filter: Filter.equals('domain', endpoint.domain));

    return await _endpointStore.delete(
      await _db,
      finder: finderFirst,
    );
  }

  Future<int> checkEndpoint() async {
    return await _endpointStore.count(await _db);
  }

  Future deleteSessionEndpoint() async {
    await _endpointStore.drop(
      await _db,
    );
  }

  // DB Qur'an functions:-----------------------------------------------------
  Future<int> insertSurah(DataSurah surah) async {
    return await _quranStore.add(await _db, surah.toDbMap());
  }

  Future<DataSurah> getSurahFromDb() async {
    print('Loading Surah from database');

    // surah quran
    var surah;

    // fetching data
    final recordSnapshots = await _quranStore.findFirst(
      await _db,
    );

    surah = DataSurah.fromDb(recordSnapshots.value);

    print('Database Surah........');
    print(recordSnapshots.value);
    return surah;
  }

  Future<List<DataSurah>> getSurahListFromDb() async {
    print('Loading List Surah from database');

    // surah list quran
    var surahsList;

    // fetching data
    final recordSnapshots = await _quranStore.find(
      await _db,
    );

    // Making a List<DataSurah> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      surahsList = recordSnapshots.map((snapshot) {
        final surah = DataSurah.fromDb(snapshot.value);
        // An ID is a key of a record from the database.
        // surah.numberAyahId = snapshot.key;
        return surah;
      }).toList();
    }
    return surahsList;
  }

  Future<int> deleteSurah(DataSurah surah) async {
    var finderFirst = Finder(filter: Filter.equals('numberAyahId', surah.numberAyahId));
    print('Loading Delete Surah from database');
    return await _quranStore.delete(
      await _db,
      finder: finderFirst,
    );
  }

  Future<int> checkSurah() async {
    return await _quranStore.count(await _db);
  }

  Future deleteAllSurah() async {
    await _quranStore.drop(
      await _db,
    );
  }
}
