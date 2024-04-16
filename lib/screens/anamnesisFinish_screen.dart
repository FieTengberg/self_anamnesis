import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/app_colors.dart';
import 'package:flutter_application_test/bubble_text_widget.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BubbleText(text: text),

            SizedBox(height: 60), // Spacer

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
                backgroundColor: AppColors.btnColor,
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
