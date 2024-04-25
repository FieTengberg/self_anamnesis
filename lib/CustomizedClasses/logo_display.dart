import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/logo.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
