import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurements_cubit.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import 'package:solar_measurement_app/widgets/last_five_days_measurements_chart.dart';
import 'package:solar_measurement_app/widgets/last_measurement_table.dart';
import 'package:solar_measurement_app/widgets/last_measurement_text.dart';
import 'package:solar_measurement_app/widgets/this_day_measurements_chart.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solar Measurement"),
        backgroundColor: Color.fromRGBO(204, 154, 16, 1),
      ),
      body: BlocBuilder<LatestSolarMeasurementsCubit,
          LatestSolarMeasurementsState>(builder: (context, state) {
        var widgetToReturn;
        if (state is LatestSolarMeasurementsInitial ||
            state is LatestSolarMeasurementsLoading) {
          return LoadingTableProgressIndicator();
        } else if (state is LatestSolarMeasurementsError) {
          widgetToReturn = Text(state.message);
        } else if (state is LatestSolarMeasurementsLoaded) {
          widgetToReturn = Column(
            children: [
              TextDivider(
                text: "Letzte Messung",
              ),
              LastMeasurementTable(
                opencircuitvoltage:
                    state.lastFiveDaysMeasurements.first.opencircuitvoltage,
                resistorvoltage:
                    state.lastFiveDaysMeasurements.first.resistorvoltage,
                createdon: state.lastFiveDaysMeasurements.first.createdon,
              ),
              TextDivider(
                text: "Leerlaufspannungsverlauf heute",
              ),
              ThisDayMeasurementsChart(
                  data: measurementsThisDay(state.lastFiveDaysMeasurements)),
              TextDivider(
                text: "Leerlaufspannungsverlauf letzte 5 Tage",
              ),
              LastFiveDaysMeasurementsChart(
                  data: state.lastFiveDaysMeasurements)
            ],
          );
        }
        return RefreshIndicator(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                widgetToReturn,
              ],
            ),
            onRefresh: () => context
                .read<LatestSolarMeasurementsCubit>()
                .getLastFiveDaysMeasurements());
      }),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: () => context
                  .read<LatestSolarMeasurementsCubit>()
                  .getLastFiveDaysMeasurements())
        ],
      ),
    );
  }

  List<SolarMeasurementModel> measurementsThisDay(
      List<SolarMeasurementModel> measurements) {
    DateTime today = DateTime.parse("2021-04-10 12:18:04Z");

    return List.from(
        measurements.where((element) => element.createdon.isSameDate(today)));
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class LoadingTableProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.orange,
    ));
  }
}
