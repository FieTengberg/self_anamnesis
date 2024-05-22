import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/text_bubble_display.dart';
import 'package:flutter_application_test/screens/anamnesisFinish_screen.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

// SaveOrRepeatScreen widget for displaying options to save or repeat a recorded answer
class SaveOrRepeatScreen extends StatelessWidget {
  final int index;
  final String questionString;

  // Constructor with required parameters
  SaveOrRepeatScreen({required this.index, required this.questionString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90), // Spacer

            // Displaying the question text using BubbleText widget
            BubbleText(text: questionString),

            SizedBox(height: 50), // Spacer

            // Large container for buttons
            Container(
              width: 800,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Green square button for recording new answer
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigate back to RecordScreen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecordScreen(index: index)));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                color: Colors.green,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Spacer
                            Text(
                              'Optag nyt svar',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Blue button for saving the recorded answer
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigate to either next question or finish screen
                                if (index == 6) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FinishScreen()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RecordScreen(index: index + 1)),
                                  );
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                color: Colors.blue,
                                child: Icon(
                                  Icons.save,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Spacer
                            Text(
                              'Gem optagelse',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 35), // Spacer

            // Additional text at bottom wrapped in a row with logo
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Logo(),
                      SizedBox(width: 30), // Spacer
                      Expanded(
                        child: Text(
                          'Optagelsen af dit svar skal gemmes for at kunne komme videre til næste spørgsmål',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
