import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin:
          EdgeInsets.only(left: 8.0, bottom: 8.0), // adjust margin as needed
      child: Image.asset(
        'assets/logo.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
