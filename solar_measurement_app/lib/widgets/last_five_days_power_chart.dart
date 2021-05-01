import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';
import 'package:solar_measurement_app/core/extensions/datetime_extensions.dart';

class LastFiveDaysPowerChart extends StatelessWidget {
  final List<SolarMeasurementModel> data;

  LastFiveDaysPowerChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300.0,
      child: TimeSeriesChart(
        createSeries(
          createSeriesData(),
        ),
        defaultRenderer: BarRendererConfig<DateTime>(),
      ),
    );
  }

  List<Series<TimeSeriesPower, DateTime>> createSeries(
      List<TimeSeriesPower> seriesdata) {
    return [
      Series(
          id: "FiveDaysMeasurements",
          colorFn: (_, __) => MaterialPalette.deepOrange.shadeDefault,
          domainFn: (TimeSeriesPower timeSeriesPower, _) => timeSeriesPower.day,
          measureFn: (TimeSeriesPower timeSeriesPower, _) =>
              timeSeriesPower.power,
          data: seriesdata)
    ];
  }

  List<TimeSeriesPower> createSeriesData() {
    final daysToGenerate =
        data.last.createdon.difference(data.first.createdon).inDays + 1;
    List<TimeSeriesPower> seriesdata = List.generate(
        daysToGenerate,
        (index) => TimeSeriesPower(
            DateTime(data.first.createdon.year, data.first.createdon.month,
                    data.first.createdon.day)
                .add(Duration(days: index)),
            0.0));

    seriesdata.forEach((element) {
      element.power = data
          .where((measurement) => element.day.isSameDate(measurement.createdon))
          .toList()
          .fold(0.0, (value, element) => value + calculateEnergiemWh(element));
    });

    seriesdata.forEach((element) {
      print("Day: ${element.day} Power: ${element.power}");
    });
    return seriesdata;
  }

  double calculateEnergiemWh(SolarMeasurementModel measurementModel) {
    final int usedResistor = 220;
    final int delayBetweenMeasurements = 15;
    double internalresistancevoltage =
        measurementModel.opencircuitvoltage - measurementModel.resistorvoltage;
    double internalresistancecurrent =
        measurementModel.resistorvoltage / usedResistor;
    if (internalresistancecurrent != 0 && internalresistancevoltage != 0) {
      double power = (measurementModel.opencircuitvoltage *
              measurementModel.opencircuitvoltage) /
          (internalresistancevoltage / internalresistancecurrent);
      return power * 1000 * (delayBetweenMeasurements / 60);
    } else {
      return 0.0;
    }
  }
}

class TimeSeriesPower {
  DateTime day;
  double power;

  TimeSeriesPower(this.day, this.power);
}
