import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class SolarMeasurementsLocalDataSource {
  static final SolarMeasurementsLocalDataSource instance =
      SolarMeasurementsLocalDataSource._init();

  static Database _database;

  SolarMeasurementsLocalDataSource._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB('measurements.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final doubleType = 'DOUBLE NOT NULL';
    final datetimeType = 'DATETIME NOT NULL';

    await db.execute('''
    CREATE TABLE $localDatasourceSolarMeasurementsTable (
      ${LocalDatasourceSolarMeasurementsTableFields.id} $idType,
      ${LocalDatasourceSolarMeasurementsTableFields.resistorvoltage} $doubleType,
      ${LocalDatasourceSolarMeasurementsTableFields.opencircuitvoltage} $doubleType,
      ${LocalDatasourceSolarMeasurementsTableFields.createdon} $datetimeType
      )
    ''');
  }

  Future<int> insertOne(SolarMeasurementModel model) async {
    final db = await instance.database;
    final id = await db.insert(
      localDatasourceSolarMeasurementsTable,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return id;
  }

  Future<SolarMeasurementModel> queryOneById(int id) async {
    final db = await instance.database;

    final maps = await db.query(localDatasourceSolarMeasurementsTable,
        columns: LocalDatasourceSolarMeasurementsTableFields.values,
        where: '${LocalDatasourceSolarMeasurementsTableFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return SolarMeasurementModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SolarMeasurementModel>> queryLastFiveDaysMeasurements() async {
    final db = await instance.database;
    String dateMinusXDays = _getDayXDaysOlderThanNow(5).toIso8601String();
    final orderBy = '${LocalDatasourceSolarMeasurementsTableFields.id} ASC';
    final where =
        '${LocalDatasourceSolarMeasurementsTableFields.createdon} > \'$dateMinusXDays\'';

    final result = await db.query(localDatasourceSolarMeasurementsTable,
        where: where, orderBy: orderBy);

    return result.map((json) => SolarMeasurementModel.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  void insertMany(List<SolarMeasurementModel> models) async {
    final db = await instance.database;

    Batch batch = db.batch();

    models.forEach((model) async {
      batch.insert(
        localDatasourceSolarMeasurementsTable,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      await batch.commit(noResult: true);
    });
  }

  void deleteRowsOlderThanXDays(int days) async {
    final db = await instance.database;

    String dateMinusXDays = _getDayXDaysOlderThanNow(days).toIso8601String();

    Batch batch = db.batch();
    batch.delete(localDatasourceSolarMeasurementsTable,
        where:
            '${LocalDatasourceSolarMeasurementsTableFields.createdon} < \'$dateMinusXDays\'');
    await batch.commit(noResult: true);
  }

  DateTime _getDayXDaysOlderThanNow(days) {
    var date = DateTime.now().subtract(Duration(days: days));
    return DateTime(date.year, date.month, date.day);
  }
}
