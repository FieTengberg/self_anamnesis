import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';

class AskQuestionScreen extends StatefulWidget {
  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spørgsmål x'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large square container with black border
            Container(
              width: 800,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5), // Spacer
                  Text(
                    'Hvor intense er dine smerter på en skala fra 1 til 10',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 50), // Adding space between TextField and Button
                  Text(
                    '1 er ingen smerte og 10 er den værst tænkelige smerte, som du kan forestille dig',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 60), // Spacer

            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress bar
                Container(
                  width: 450,
                  height: 10,
                  child: LinearProgressIndicator(
                    value:
                        0.5, // Change this value dynamically based on user's progress
                    backgroundColor: const Color.fromARGB(255, 223, 220, 220),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),

                SizedBox(width: 20), // Spacer between progress bar and text

                // Text displaying progress
                Text(
                  'Du har svaret på 5 ud af 10 spørgsmål', // Change this text dynamically based on user's progress
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
