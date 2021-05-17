import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import 'package:solar_measurement_app/core/extensions/datetime_extensions.dart';

class ThisDayMeasurementsChart extends StatelessWidget {
  final List<SolarMeasurementModel> data;

  ThisDayMeasurementsChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300.0,
      child: TimeSeriesChart(
        createSeries(),
      ),
    );
  }

  List<Series<SolarMeasurementModel, DateTime>> createSeries() {
    return [
      Series(
          id: "ThisDayMeasurements",
          colorFn: (_, __) => MaterialPalette.deepOrange.shadeDefault,
          domainFn: (SolarMeasurementModel model, _) => model.createdon,
          measureFn: (SolarMeasurementModel model, _) =>
              model.opencircuitvoltage,
          data: measurementsThisDay(data))
    ];
  }

  List<SolarMeasurementModel> measurementsThisDay(
      List<SolarMeasurementModel> measurements) {
    DateTime today = DateTime.now();

    return List.from(
        measurements.where((element) => element.createdon.isSameDate(today)));
  }
}
