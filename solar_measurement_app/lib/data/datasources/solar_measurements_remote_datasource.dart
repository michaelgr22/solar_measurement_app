import 'package:solar_measurement_app/data/datasources/postgresdb.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import '.datasources_credentails.dart';

abstract class SolarMeasurementsRemoteDataSoruce {
  Future<SolarMeasurementModel> getLatestMeasurement();
}

class SolarMeasurementsRemoteDataSoruceImpl
    implements SolarMeasurementsRemoteDataSoruce {
  final measurementsdb = PostgresDB(
    PostgresDBMeasurementsCredentails.ip,
    PostgresDBMeasurementsCredentails.port,
    PostgresDBMeasurementsCredentails.database,
    PostgresDBMeasurementsCredentails.username,
    PostgresDBMeasurementsCredentails.password,
  );

  Future<SolarMeasurementModel> getLatestMeasurement() async {
    final postgresquery =
        """select id, cast(resistor_voltage as float), cast(opencircuit_voltage as float),created_on 
from solarpanels_2_resistor220_opencircuit
order by created_on desc
limit 1""";

    await measurementsdb.connect();
    List<List<dynamic>> result = await measurementsdb.query(postgresquery);
    var row = result[0];

    int id = row[0];
    double resistorvoltage = row[1];
    double opencircuitvoltage = row[2];
    DateTime createdon = DateTime.parse(row[3].toString().split('.')[0]);

    return SolarMeasurementModel(
        id: id,
        resistorvoltage: resistorvoltage,
        opencircuitvoltage: opencircuitvoltage,
        createdon: createdon);
  }
}
