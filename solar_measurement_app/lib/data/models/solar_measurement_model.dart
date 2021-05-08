import 'package:flutter/material.dart';

final String localDatasourceSolarMeasurementsTable = 'solarmeasurements';

class LocalDatasourceSolarMeasurementsTableFields {
  static final List<String> values = [
    '_id',
    'resistorvoltage',
    'opencircuitvoltage',
    'createdon'
  ];

  static final String id = '_id';
  static final String resistorvoltage = 'resistorvoltage';
  static final String opencircuitvoltage = 'opencircuitvoltage';
  static final String createdon = 'createdon';
}

class SolarMeasurementModel {
  final int id;
  final double resistorvoltage;
  final double opencircuitvoltage;
  final DateTime createdon;

  SolarMeasurementModel(
      {@required this.id,
      @required this.resistorvoltage,
      @required this.opencircuitvoltage,
      @required this.createdon});

  SolarMeasurementModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as int,
        resistorvoltage = json['resistorvoltage'] as double,
        opencircuitvoltage = json['opencircuitvoltage'] as double,
        createdon = DateTime.parse(json['createdon'] as String);

  Map<String, dynamic> toJson() {
    return {
      LocalDatasourceSolarMeasurementsTableFields.id: id,
      LocalDatasourceSolarMeasurementsTableFields.resistorvoltage:
          resistorvoltage,
      LocalDatasourceSolarMeasurementsTableFields.opencircuitvoltage:
          opencircuitvoltage,
      LocalDatasourceSolarMeasurementsTableFields.createdon:
          createdon.toIso8601String(),
    };
  }
}
