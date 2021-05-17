import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class LastFiveDaysMeasurementsChart extends StatelessWidget {
  final List<SolarMeasurementModel> data;

  LastFiveDaysMeasurementsChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300.0,
      child: TimeSeriesChart(
        createSeries(),
        domainAxis: DateTimeAxisSpec(
          tickProviderSpec: DayTickProviderSpec(increments: [1]),
        ),
      ),
    );
  }

  List<Series<SolarMeasurementModel, DateTime>> createSeries() {
    return [
      Series(
          id: "FiveDaysMeasurements",
          colorFn: (_, __) => MaterialPalette.deepOrange.shadeDefault,
          domainFn: (SolarMeasurementModel model, _) => model.createdon,
          measureFn: (SolarMeasurementModel model, _) =>
              model.opencircuitvoltage,
          data: data)
    ];
  }
}
