import 'package:postgres/postgres.dart';

class PostgresDB {
  final String _ip;
  final int _port;
  final String _database;
  final String _username;
  final String _password;

  var _connection;

  PostgresDB(
    this._ip,
    this._port,
    this._database,
    this._username,
    this._password,
  ) {
    connect();
  }

  void connect() async {
    _connection = PostgreSQLConnection(_ip, _port, _database,
        username: _username, password: _password);
    await _connection.open();
  }

  Future<dynamic> query(String query) async {
    return await _connection.query(query);
  }
}
