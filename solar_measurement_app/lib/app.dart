import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solar_measurement_app/cubit/latestsolarmeasurement_cubit.dart';
import 'package:solar_measurement_app/data/datasources/postgresdb.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'package:solar_measurement_app/data/repositories/solar_measurements_repository.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MeasurementsDB measurementsDB = MeasurementsDB();
    final SolarMeasurementsRemoteDataSoruce remoteDataSoruce =
        SolarMeasurementsRemoteDataSoruceImpl(database: measurementsDB);
    return MaterialApp(
        home: BlocProvider(
      create: (_) => LatestSolarMeasurementCubit(
          SolarMeasurementsRepository(remoteDataSoruce: remoteDataSoruce))
        ..getLatestSolarMeasurement(),
      child: HomePage(),
    ));
  }
}
