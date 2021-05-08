import 'package:flutter/cupertino.dart';

class WeatherdataModel {
  final DateTime dt;
  final DateTime sunrise;
  final DateTime sunset;
  final double tempmax;
  final double tempmin;
  final int clouds;
  final String weathermain;

  WeatherdataModel({
    @required this.dt,
    @required this.sunrise,
    @required this.sunset,
    @required this.tempmax,
    @required this.tempmin,
    @required this.clouds,
    @required this.weathermain,
  });

  WeatherdataModel.fromJson(Map<String, dynamic> json)
      : dt = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        sunrise = DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000),
        sunset = DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000),
        tempmax = json['temp']['max'] as double,
        tempmin = json['temp']['min'] as double,
        clouds = json['clouds'] as int,
        weathermain = json['weather'][0]['main'] as String;
}
