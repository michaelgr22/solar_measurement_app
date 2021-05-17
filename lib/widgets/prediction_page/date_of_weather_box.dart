import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfWeatherBox extends StatelessWidget {
  final DateTime date;
  final double width;
  DateOfWeatherBox({@required this.date, @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format(date),
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Text(
              '${DateFormat('MMMMd').format(date)}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
