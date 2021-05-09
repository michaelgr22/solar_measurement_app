import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurements_cubit.dart';
import 'package:solar_measurement_app/widgets/measurements_page/last_five_days_measurements_chart.dart';
import 'package:solar_measurement_app/widgets/measurements_page/last_five_days_power_chart.dart';
import 'package:solar_measurement_app/widgets/measurements_page/last_measurement_table.dart';
import 'package:solar_measurement_app/widgets/loading_progress_indicator.dart';
import 'package:solar_measurement_app/widgets/measurements_page/text_divider.dart';
import 'package:solar_measurement_app/widgets/measurements_page/this_day_measurements_chart.dart';

class MeasurementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messungen"),
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
                data: state.lastFiveDaysMeasurements,
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
    );
  }
}
