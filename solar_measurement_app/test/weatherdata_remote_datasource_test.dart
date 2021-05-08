import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:solar_measurement_app/data/datasources/weatherdata_remote_datasouce.dart';
import 'package:solar_measurement_app/data/models/weatherdata_model.dart';

void main() {
  test(
      'should return List of WeatherdataModels when getWeatherOfNextSevenDays is called',
      () async {
    //arrange
    final lat = 49.19;
    final lon = 11.1886;
    final units = 'metric';
    final remoteDataSoruce = WeatherdataRemoteDataSourceImpl();
    //act
    final weatherdatalist =
        await remoteDataSoruce.getWeatherOfNextSevenDays(lat, lon, units);
    //assert
    expect(weatherdatalist, isA<List<WeatherdataModel>>());
  });
}
