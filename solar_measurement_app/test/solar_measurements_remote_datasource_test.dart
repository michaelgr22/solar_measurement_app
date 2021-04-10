import 'package:flutter_test/flutter_test.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

void main() {
  SolarMeasurementsRemoteDataSoruce remoteDataSoruce;
  remoteDataSoruce = SolarMeasurementsRemoteDataSoruceImpl();

  test(
      'should return SolarMeasurementModel when getLatestMeasurement is called',
      () async {
    //arrange
    //act
    final solarmeasurmentmodel = await remoteDataSoruce.getLatestMeasurement();
    //assert
    expect(solarmeasurmentmodel, isA<SolarMeasurementModel>());
  });
}
