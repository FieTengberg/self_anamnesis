import 'package:flutter/material.dart';
import 'package:flutter_application_test/app_colors.dart';

class BubbleText extends StatelessWidget {
  final String text;

  const BubbleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(        
            color: Colors.grey.withOpacity(0.5), // Shadow color                   
            spreadRadius: 5, // Spread radius                   
            blurRadius: 7, // Blur radius                  
            offset: Offset(0, 3))] // Offset from the container
          ),
          child: Text(
            text,
            style: TextStyle(color: AppColors.textColor),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 180),
          width: 50,
          height: 25,
          child: CustomPaint(
              painter: TrianglePainter( color: Colors.blue),
            ),
          ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
 
  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
  
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }
  
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
