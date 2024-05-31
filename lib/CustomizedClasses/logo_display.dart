import 'package:flutter/material.dart';

// A StatelessWidget to display the logo image
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //with logo
      child: Image.asset(
        'assets/logo.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
