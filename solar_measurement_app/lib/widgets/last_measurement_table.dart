import 'package:flutter/material.dart';
import 'package:solar_measurement_app/cubit/latestsolarmeasurements_cubit.dart';

class LastMeasurementTable extends StatelessWidget {
  final state;

  LastMeasurementTable({@required this.state});
  @override
  Widget build(BuildContext context) {
    double opencircuitvoltage;
    double resistorvoltage;
    DateTime createdon;

    if (state is LatestSolarMeasurementsInitial ||
        state is LatestSolarMeasurementsLoading) {
      return LoadingTableProgressIndicator();
    } else if (state is LatestSolarMeasurementsError) {
      return Text(state.message);
    } else if (state is LatestSolarMeasurementsLoaded) {
      opencircuitvoltage =
          state.lastFiveDaysMeasurements.first.opencircuitvoltage;
      resistorvoltage = state.lastFiveDaysMeasurements.first.resistorvoltage;
      createdon = state.lastFiveDaysMeasurements.first.createdon;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: TableCellHeaderContainer(
                  "Zeit",
                ),
              ),
              TableCell(
                child: TableCellHeaderContainer(
                  "Uo [V]",
                ),
              ),
              TableCell(
                child: TableCellHeaderContainer(
                  "Ur [V]",
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: TableCellContentContainer(
                  createdon.toString(),
                ),
              ),
              TableCell(
                child: TableCellContentContainer(
                  opencircuitvoltage.toString(),
                ),
              ),
              TableCell(
                child: TableCellContentContainer(
                  resistorvoltage.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TableCellContentContainer extends StatelessWidget {
  final String content;

  TableCellContentContainer(this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class TableCellHeaderContainer extends StatelessWidget {
  final String content;

  TableCellHeaderContainer(this.content);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      color: Colors.grey,
    );
  }
}

class LoadingTableProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.orange,
    );
  }
}
