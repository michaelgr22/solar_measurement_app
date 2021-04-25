import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/datasources/postgresdb.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class MockMeasurementsDB extends Mock implements MeasurementsDB {}

void main() {
  test(
      'should return List of SolarMeasurementModels when getLastWeeksMeasurements is called',
      () async {
    //arrange
    final measurementsDB = MeasurementsDB();
    final remoteDataSoruce =
        SolarMeasurementsRemoteDataSoruceImpl(database: measurementsDB);
    //act
    final solarmeasurmentmodellist =
        await remoteDataSoruce.getLastFiveDaysMeasurements();
    //assert
    expect(solarmeasurmentmodellist, isA<List<SolarMeasurementModel>>());
  });

  test('should return NetworkException when loading Data from Postgres fails',
      () async {
    //arrange
    final MockMeasurementsDB measurementsDB = MockMeasurementsDB();
    final remoteDataSoruce =
        SolarMeasurementsRemoteDataSoruceImpl(database: measurementsDB);
    //act
    when(await measurementsDB.connect()).thenThrow(TimeoutException("Test"));
    //assert
    expect(remoteDataSoruce.getLastFiveDaysMeasurements(),
        throwsA(isA<NetworkException>()));
  });
}
