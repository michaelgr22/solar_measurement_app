import 'package:postgres/postgres.dart';
import '.datasources_credentails.dart';

class PostgresDB {
  final String _ip;
  final int _port;
  final String _database;
  final String _username;
  final String _password;

  var _connection;

  PostgresDB(
      this._ip, this._port, this._database, this._username, this._password);

  Future<void> connect() async {
    _connection = PostgreSQLConnection(_ip, _port, _database,
        username: _username, password: _password, timeoutInSeconds: 1);
    await _connection.open();
  }

  Future<void> close() async {
    await _connection.close();
  }

  Future<dynamic> query(String query) async {
    return await _connection.query(query);
  }

  String get ip {
    return _ip;
  }

  int get port {
    return _port;
  }
}

class MeasurementsDB extends PostgresDB {
  MeasurementsDB()
      : super(
            PostgresDBSolarMeasurementsCredentails.ip,
            PostgresDBSolarMeasurementsCredentails.port,
            PostgresDBSolarMeasurementsCredentails.database,
            PostgresDBSolarMeasurementsCredentails.username,
            PostgresDBSolarMeasurementsCredentails.password);
}
