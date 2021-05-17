import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;

  TextDivider({@required this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
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
      ),
    );
  }
}
