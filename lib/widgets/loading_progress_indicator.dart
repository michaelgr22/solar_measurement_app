import 'package:flutter/material.dart';

class LoadingTableProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.orange,
    ));
  }
}
