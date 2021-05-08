import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/datasources/weatherdata_remote_datasouce.dart';
import 'package:solar_measurement_app/data/models/weatherdata_model.dart';

class WeatherDataRepository {
  final WeatherdataRemoteDataSource remoteDataSource;

  WeatherDataRepository({@required this.remoteDataSource});

  Future<List<WeatherdataModel>> getWeatherOfNextSevenDays(
      double lat, double lon, String units) {
    return remoteDataSource.getWeatherOfNextSevenDays(lat, lon, units);
  }
}
