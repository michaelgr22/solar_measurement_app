import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class SolarMeasurementsRepository {
  final SolarMeasurementsRemoteDataSoruce remoteDataSoruce;

  SolarMeasurementsRepository({@required this.remoteDataSoruce});

  Future<List<SolarMeasurementModel>> getLastFiveDaysMeasurements() async {
    final List<SolarMeasurementModel> lastFiveDaysMeasurements =
        await remoteDataSoruce.getLastFiveDaysMeasurements();
    return lastFiveDaysMeasurements;
  }
}
