import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';

// A StatelessWidget to display text inside a speech bubble
class BubbleText extends StatelessWidget {
  final String text; // The text to be displayed inside the bubbl

  const BubbleText({required this.text}); // Constructor to initialize the text

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container for the main bubble
        Container(
          width: 800,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: AppColors.bubbleColor,
              borderRadius: BorderRadius.circular(20), // Rounded corners
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.6), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: Offset(0, 3))
              ]),
          // Display the text inside the bubble
          child: Text(text,
              style: TextStyle(color: AppColors.textColor, fontSize: 30)),
        ),
        // Small triangle below the bubble to make it look like a speech bubble
        Container(
          margin: EdgeInsets.only(left: 180),
          width: 60,
          height: 30,
          child: CustomPaint(
            painter: TrianglePainter(
                color: AppColors
                    .bubbleColor), // Custom painter to draw the triangle
          ),
        ),
      ],
    );
  }
}

// CustomPainter class to draw the triangle below the bubble
class TrianglePainter extends CustomPainter {
  final Color color; //color of triangle

  TrianglePainter({required this.color}); // Constructor to initialize the color

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color; // Set the paint color

    // Creating a path to draw a triangle
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint); // Draw the triangle on the canvas
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint since the triangle does not change
  }
}
