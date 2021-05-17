import 'package:flutter/material.dart';

import 'package:solar_measurement_app/data/models/weatherdata_model.dart';
import 'package:solar_measurement_app/widgets/prediction_page/clouds_of_weather_box.dart';
import 'package:solar_measurement_app/widgets/prediction_page/date_of_weather_box.dart';
import 'package:solar_measurement_app/widgets/prediction_page/sunrise_sunset_of_weatherbox.dart';
import 'package:solar_measurement_app/widgets/prediction_page/temperature_of_weather_box.dart';
import 'package:solar_measurement_app/widgets/prediction_page/weather_icon_of_weather_box.dart';

class WeatherBox extends StatelessWidget {
  final WeatherdataModel weather;
  final Size screenSize;
  WeatherBox({@required this.weather, @required this.screenSize});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Row(
            children: [
              DateOfWeatherBox(
                date: weather.dt,
                width: screenSize.width * 0.2,
              ),
              WeatherIconOfWeatherBox(
                weathermain: weather.weathermain,
                clouds: weather.clouds,
                width: screenSize.width * 0.2,
              ),
              TemperatureOfWeatherBox(
                tempmax: weather.tempmax,
                tempmin: weather.tempmin,
                width: screenSize.width * 0.175,
              ),
              SunriseSunsetOfWeatherBox(
                sunrise: weather.sunrise,
                sunset: weather.sunset,
                width: screenSize.width * 0.2125,
              ),
              CloudsOfWeatherBox(
                clouds: weather.clouds,
                width: screenSize.width * 0.1375,
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.lightBlue.shade800,
          ),
        )
      ],
    );
  }
}
