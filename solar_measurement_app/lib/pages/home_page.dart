import 'package:flutter/material.dart';
import 'package:solar_measurement_app/pages/measurements_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solar Measurement"),
        backgroundColor: Color.fromRGBO(204, 154, 16, 1),
      ),
      body: Column(
        children: [NavigationButton()],
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.orange, onPrimary: Colors.white),
        child: Text("Messungen"),
        onPressed: () {
          Navigator.pushNamed(context, '/measurements');
        },
      ),
    );
  }
}
