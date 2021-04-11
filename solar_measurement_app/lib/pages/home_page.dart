import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurement_cubit.dart';
import 'package:solar_measurement_app/widgets/last_measurement_table.dart';
import 'package:solar_measurement_app/widgets/last_measurement_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solar Measurement"),
        backgroundColor: Color.fromRGBO(204, 154, 16, 1),
      ),
      body: Column(
        children: [
          LastMeasurementText(),
          LastMeasurementTable(),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () => context
                  .read<LatestSolarMeasurementCubit>()
                  .getLatestSolarMeasurement())
        ],
      ),
    );
  }
}
