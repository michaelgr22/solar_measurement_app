import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurement_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solar Measurement"),
      ),
      body: Container(
        child: BlocBuilder<LatestSolarMeasurementCubit,
            LatestSolarMeasurementState>(
          builder: (context, state) {
            if (state is LatestSolarMeasurementInitial) {
              return Center(
                child: Text("Inital"),
              );
            } else if (state is LatestSolarMeasurementLoaded) {
              String id = state.latestmeasurement.id.toString();
              return Center(child: Text("Id: $id"));
            } else {
              return Center(
                child: Text("nothing"),
              );
            }
          },
        ),
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
