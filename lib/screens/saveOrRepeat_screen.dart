import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/anamnesisFinish_screen.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/NLP_models/ElevenLabTTS.dart';
import 'package:flutter_application_test/screens/intro_screen.dart';
import 'package:audioplayers/audioplayers.dart';


const questionText = [
  'assets/text_strings/question1.txt',
  'assets/text_strings/question2.txt'
];
class SaveOrRepeatScreen extends StatelessWidget {
  final int index;
  SaveOrRepeatScreen({required this.index});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SaveOrRepeat Screen'),
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
                                // Make the text-to-speech request
                                if (index == questionText.length -1) {
                                  print(index);
                                  print(questionText.length);
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
                                width: 100,
                                height: 100,
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

            SizedBox(height: 60), // Spacer

            // Additional text
            Text(
              'Optagelsen af dit svar skal gemmes for at kunne komme videre til næste spørgsmål',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
