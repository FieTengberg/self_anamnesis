import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text: Question
            Text(
              'Hvor intense er dine smerter på en skala fra 1 til 10?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Spacer
            // Text: Added explanation
            Text(
              '1 er ingen smerte og 10 er den værst tænkelige smerte, som du kan forestille dig',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            SizedBox(height: 50), // Spacer

            // Large square container with black border
            Container(
              width: 800,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Green square for play symbol
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Handle play button press
                          },
                          child: Container(
                            width: 100,
                            height: 100,
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
                          'Start',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  // Red square for stop button
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Handle stop button press
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            color: Colors.red,
                            child: Icon(
                              Icons.stop,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 5), // Spacer
                        Text(
                          'Stop',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
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
