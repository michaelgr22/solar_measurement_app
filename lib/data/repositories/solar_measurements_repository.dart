import 'package:tcp_scanner/tcp_scanner.dart';
import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_local_datasource.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class SolarMeasurementsRepository {
  final SolarMeasurementsRemoteDataSource remoteDataSoruce;
  final SolarMeasurementsLocalDataSource localDataSource;

  SolarMeasurementsRepository(
      {@required this.remoteDataSoruce, @required this.localDataSource});

  Future<List<SolarMeasurementModel>> getLastFiveDaysMeasurements() async {
    if (await _isRemoteDatabaseAvailable()) {
      final List<SolarMeasurementModel> lastFiveDaysMeasurements =
          await remoteDataSoruce.queryLastFiveDaysMeasurements();
      localDataSource.insertMany(lastFiveDaysMeasurements);
      localDataSource.deleteRowsOlderThanXDays(10);
      return lastFiveDaysMeasurements;
    }
    final List<SolarMeasurementModel> lastFiveDaysMeasurements =
        await localDataSource.queryLastFiveDaysMeasurements();
    return lastFiveDaysMeasurements;
  }

  Future<bool> _isRemoteDatabaseAvailable() async {
    String ip = remoteDataSoruce.database.ip;
    int port = remoteDataSoruce.database.port;
    ScanResult scan = await TCPScanner(ip, [port]).scan();
    if (scan.open.isEmpty) {
      return false;
    }
    return true;
  }
}
