import 'package:app_jamaah_boilerplate/constants/db_constant.dart';
import 'package:app_jamaah_boilerplate/models/endpoint/endpoint.dart';
import 'package:sembast/sembast.dart';

class EndpointDataSource {
  final _endpointStore =
      intMapStoreFactory.store(DBConstants.STORE_ENDPOINT_NAME);

  // database instance
  final Future<Database> _db;

  // Constructor
  EndpointDataSource(this._db);

  // DB functions:--------------------------------------------------------------
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

  // DB Seesion Endpoint functions:--------------------------------------------------------------
  Future<int> delete(EndpointsAPI endpoint) async {
    var finderFirst = Finder(filter: Filter.equals('domain', endpoint.domain));

    return await _endpointStore.delete(
      await _db,
      finder: finderFirst,
    );
  }

  Future<int> checkEndpoint() async {
    return await _endpointStore.count(await _db);
  }

  Future deleteSession() async {
    await _endpointStore.drop(
      await _db,
    );
  }
}
