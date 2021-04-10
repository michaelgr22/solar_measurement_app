import 'package:flutter/material.dart';

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
}
