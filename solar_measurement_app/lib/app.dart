import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solar_measurement_app/cubit/latestsolarmeasurements_cubit.dart';
import 'package:solar_measurement_app/cubit/weatherdata_cubit.dart';
import 'package:solar_measurement_app/data/datasources/postgresdb.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_local_datasource.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/datasources/weatherdata_remote_datasouce.dart';
import 'package:solar_measurement_app/data/repositories/solar_measurements_repository.dart';
import 'package:solar_measurement_app/data/repositories/weatherdata_repository.dart';
import 'package:solar_measurement_app/pages/measurements_page.dart';
import 'package:solar_measurement_app/pages/prediction_page.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) {
          return HomePage();
        },
        '/measurements': (BuildContext context) {
          final MeasurementsDB measurementsDB = MeasurementsDB();
          final SolarMeasurementsRemoteDataSoruce remoteDataSoruce =
              SolarMeasurementsRemoteDataSoruceImpl(database: measurementsDB);
          final SolarMeasurementsLocalDataSource localDataSource =
              SolarMeasurementsLocalDataSource.instance;
          return BlocProvider(
              create: (_) =>
                  LatestSolarMeasurementsCubit(SolarMeasurementsRepository(
                    remoteDataSoruce: remoteDataSoruce,
                    localDataSource: localDataSource,
                  ))
                    ..getLastFiveDaysMeasurements(),
              child: MeasurementsPage());
        },
        '/predictions': (BuildContext context) {
          final lat = 49.19;
          final lon = 11.1886;
          final units = 'metric';
          final WeatherdataRemoteDataSource remoteDataSource =
              WeatherdataRemoteDataSourceImpl();
          return BlocProvider(
              create: (_) => WeatherdataCubit(
                  WeatherDataRepository(remoteDataSource: remoteDataSource))
                ..getWeatherOfNextSevenDays(lat, lon, units),
              child: PredictionPage(
                lat: lat,
                lon: lon,
                units: units,
              ));
        }
      },
    );
  }
}
