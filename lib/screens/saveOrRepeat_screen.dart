import 'package:flutter/material.dart';
import 'package:flutter_application_test/text_bubble_display.dart';
import 'package:flutter_application_test/screens/anamnesisFinish_screen.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';

class SaveOrRepeatScreen extends StatelessWidget {
  final int index;
  final String questionString;
  SaveOrRepeatScreen({required this.index, required this.questionString});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text: Question
            BubbleText(text: questionString),

            SizedBox(height: 20), // Spacer

            // Large square container with black border
            Container(
              width: 800,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Green square for play again symbol
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

                      // Blue square for save button
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

            SizedBox(height: 40), // Spacer

            // Additional text at bottom
            Text(
              'Optagelsen af dit svar skal gemmes for at kunne komme videre til næste spørgsmål',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
