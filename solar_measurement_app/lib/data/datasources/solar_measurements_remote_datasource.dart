import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';
import 'package:solar_measurement_app/core/error/exceptions.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

abstract class SolarMeasurementsRemoteDataSoruce {
  Future<SolarMeasurementModel> getLatestMeasurement();
}

class SolarMeasurementsRemoteDataSoruceImpl
    implements SolarMeasurementsRemoteDataSoruce {
  final database;

  SolarMeasurementsRemoteDataSoruceImpl({@required this.database});

  Future<SolarMeasurementModel> getLatestMeasurement() async {
    final postgresquery =
        """select id, cast(resistor_voltage as float), cast(opencircuit_voltage as float),created_on 
from solarpanels_2_resistor220_opencircuit
order by created_on desc
limit 1""";

    try {
      await database.connect();
      List<List<dynamic>> result = await database.query(postgresquery);
      await database.close();
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
    } on PostgreSQLException {
      throw NetworkException();
    } on TimeoutException {
      throw NetworkException();
    }
  }
}
