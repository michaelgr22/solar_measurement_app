import 'package:flutter/material.dart';

class WeatherIconOfWeatherBox extends StatelessWidget {
  final String weathermain;
  final int clouds;
  final double width;
  WeatherIconOfWeatherBox(
      {@required this.weathermain,
      @required this.clouds,
      @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: _chooseIcon(),
      ),
    );
  }

  Widget _chooseIcon() {
    String iconname;
    switch (weathermain) {
      case 'Clear':
        {
          iconname = 'clear';
          break;
        }
      case 'Clouds':
        {
          if (clouds <= 25) iconname = 'fewclouds';
          if (clouds > 25 && clouds <= 50) iconname = 'scatteredclouds';
          if (clouds > 50) iconname = 'brokenclouds';
          break;
        }
      case 'Snow':
        {
          iconname = 'snow';
          break;
        }
      case 'Rain':
        {
          iconname = 'rain';
          break;
        }
      case 'Drizzle':
        {
          iconname = 'rain';
          break;
        }
      case 'Thunderstorm':
        {
          iconname = 'thunderstorm';
          break;
        }
      default:
        {
          iconname = 'mist';
          break;
        }
    }

    return Image.asset(
      'assets/weathericons/' + iconname + '.png',
    );
  }
}
