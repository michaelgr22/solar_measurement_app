import 'package:flutter/material.dart';

class LastMeasurementText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Letzte Messung",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 3.0),
      margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.orange,
      ),
    );
  }
}
