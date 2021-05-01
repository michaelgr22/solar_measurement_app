import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurements_cubit.dart';
import 'package:solar_measurement_app/widgets/last_five_days_measurements_chart.dart';
import 'package:solar_measurement_app/widgets/last_five_days_power_chart.dart';
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
                    state.lastFiveDaysMeasurements.last.opencircuitvoltage,
                resistorvoltage:
                    state.lastFiveDaysMeasurements.last.resistorvoltage,
                createdon: state.lastFiveDaysMeasurements.last.createdon,
              ),
              TextDivider(
                text: "Leerlaufspannung [V] heute",
              ),
              ThisDayMeasurementsChart(
                data: state.lastFiveDaysMeasurements,
              ),
              TextDivider(
                text: "Leerlaufspannung [V] letzte 5 Tage",
              ),
              LastFiveDaysMeasurementsChart(
                data: state.lastFiveDaysMeasurements,
              ),
              TextDivider(
                text: "Energie [mWh] letzte 5 Tage",
              ),
              LastFiveDaysPowerChart(
                data: state.lastFiveDaysMeasurements,
              )
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
