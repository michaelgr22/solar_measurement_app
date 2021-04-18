import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class SolarMeasurementsRepository {
  final SolarMeasurementsRemoteDataSoruce remoteDataSoruce =
      SolarMeasurementsRemoteDataSoruceImpl();

  SolarMeasurementsRepository();

  Future<SolarMeasurementModel> getLatestMeasurement() async {
    final SolarMeasurementModel latestMeasurement =
        await remoteDataSoruce.getLatestMeasurement();
    return latestMeasurement;
  }
}
