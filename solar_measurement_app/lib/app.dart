import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solar_measurement_app/cubit/latestsolarmeasurement_cubit.dart';
import 'package:solar_measurement_app/data/datasources/solar_measurements_remote_datasource.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (context) =>
          LatestSolarMeasurementCubit(SolarMeasurementsRemoteDataSoruceImpl()),
      child: HomePage(),
    ));
  }
}
