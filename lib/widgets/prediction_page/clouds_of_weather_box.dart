import 'package:flutter/material.dart';

class CloudsOfWeatherBox extends StatelessWidget {
  final int clouds;
  final double width;
  CloudsOfWeatherBox({@required this.clouds, @required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.cloud,
              size: width * 0.81,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.5),
              child: Text(
                '$clouds%',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
