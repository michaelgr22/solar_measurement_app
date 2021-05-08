import 'package:flutter/material.dart';

import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

abstract class SolarMeasurementsRemoteDataSoruce {
  final database;
  SolarMeasurementsRemoteDataSoruce({@required this.database});
  Future<List<SolarMeasurementModel>> queryLastFiveDaysMeasurements();
}

class SolarMeasurementsRemoteDataSoruceImpl
    implements SolarMeasurementsRemoteDataSoruce {
  final database;

  SolarMeasurementsRemoteDataSoruceImpl({@required this.database});

  Future<List<SolarMeasurementModel>> queryLastFiveDaysMeasurements() async {
    //TODO: Rename Query
    final query =
        """SELECT id, cast(resistor_voltage as float), cast(opencircuit_voltage as float), created_on
FROM
	solarpanels_2_resistor220_opencircuit
WHERE
	created_on BETWEEN '2021-04-08 00:00:00' AND '2021-04-12 23:59:59'
order by created_on desc;""";

    List<SolarMeasurementModel> models = [];

    try {
      List<List<dynamic>> result = await queryDatabase(query);
      result.forEach((row) {
        models.add(parseRowToSolarMeasurementModel(row));
      });
      return models.reversed.toList();
    } on Exception {
      throw NetworkException();
    }
  } //TODO: correct time

  SolarMeasurementModel parseRowToSolarMeasurementModel(List<dynamic> row) {
    return SolarMeasurementModel(
      id: row[0],
      resistorvoltage: row[1],
      opencircuitvoltage: row[2],
      createdon: DateTime.parse(row[3].toString().split('.')[0]),
    );
  }

  Future<List<List<dynamic>>> queryDatabase(query) async {
    await database.connect();
    List<List<dynamic>> result = await database.query(query);
    await database.close();
    return result;
  }
}
