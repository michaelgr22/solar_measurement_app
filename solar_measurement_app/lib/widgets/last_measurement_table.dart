import 'package:flutter/material.dart';
import 'package:solar_measurement_app/data/models/solar_measurement_model.dart';

class LastMeasurementTable extends StatelessWidget {
  final List<SolarMeasurementModel> data;

  LastMeasurementTable({@required this.data});
  @override
  Widget build(BuildContext context) {
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
                  data.last.createdon.toString(),
                ),
              ),
              TableCell(
                child: TableCellContentContainer(
                  data.last.opencircuitvoltage.toString(),
                ),
              ),
              TableCell(
                child: TableCellContentContainer(
                  data.last.resistorvoltage.toString(),
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
