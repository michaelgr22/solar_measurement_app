import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:solar_measurement_app/cubit/latestsolarmeasurement_cubit.dart';
import 'package:solar_measurement_app/data/repositories/solar_measurements_repository.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (_) => LatestSolarMeasurementCubit(SolarMeasurementsRepository())
        ..getLatestSolarMeasurement(),
      child: HomePage(),
    ));
  }
}
