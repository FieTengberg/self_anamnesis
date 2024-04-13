import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';

class FinishScreen extends StatefulWidget {
  @override
  FinishScreenState createState() => FinishScreenState();
}

class FinishScreenState extends State<FinishScreen> {
  String text = ""; //for displaying the finish text
  AnamnesisAudioPlayer audioPlayer = AnamnesisAudioPlayer();
  TextForDisplay textString = TextForDisplay();

  @override
  void initState() {
    super.initState();

    audioPlayer.playAudio(
        'audio_files/finish.mp3'); // Call function for playing audio file

    textString
        .getText('assets/text_strings/finish.txt')
        .then((String fetchedText) {
      setState(() {
        text = fetchedText; // Updating the state with the fetched text
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large square containing finish text
            Container(
              width: 700,
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40), // Spacer

            Center(
              // Wrapping the text with Center widget
              child: Text(
                'Tryk på knappen for at afslutte',
                style: TextStyle(fontSize: 14),
              ),
            ),

            SizedBox(height: 15), // Spacer

            ElevatedButton(
              onPressed: () {
                exit(0); // Closing the application if pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(450, 50),
              ),
              child: Text(
                'Afslut',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
