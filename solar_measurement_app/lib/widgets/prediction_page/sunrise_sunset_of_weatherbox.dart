import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class SunriseSunsetOfWeatherBox extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final double width;
  SunriseSunsetOfWeatherBox(
      {@required this.sunrise, @required this.sunset, @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRow(
                Icon(
                  WeatherIcons.sunrise,
                  color: Colors.orange.shade300,
                ),
                sunrise),
            SizedBox(
              height: 10,
            ),
            _buildRow(
                Icon(
                  WeatherIcons.sunset,
                  color: Colors.orange.shade300,
                ),
                sunset),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Widget icon, DateTime time) {
    return Row(
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Text(
            '${DateFormat.Hm().format(time)}',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        )
      ],
    );
  }
}
