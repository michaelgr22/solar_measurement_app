import 'package:flutter/material.dart';

class TemperatureOfWeatherBox extends StatelessWidget {
  final double tempmax;
  final double tempmin;
  final double width;
  TemperatureOfWeatherBox(
      {@required this.tempmax, @required this.tempmin, @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$tempmax°',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              '$tempmin°',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
