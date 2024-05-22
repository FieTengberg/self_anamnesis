import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';
import 'package:flutter_application_test/CustomizedClasses/text_bubble_display.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

// Defining the FinishScreen widget as a StatefulWidget
class FinishScreen extends StatefulWidget {
  @override
  FinishScreenState createState() => FinishScreenState();
}

// Defining the state for the FinishScreen widget
class FinishScreenState extends State<FinishScreen> {
  String text =
      ""; // Variable to hold the text for displaying the final message
  AnamnesisAudioPlayer audioPlayer =
      AnamnesisAudioPlayer(); // Audio player instance
  TextForDisplay textString = TextForDisplay(); // Text loader instance

  // Overriding the initState method to perform initializations
  @override
  void initState() {
    super.initState();

    audioPlayer.playAudio(
        'audio_files/finish.mp3'); // Call function for playing audio file

    // Using Text loader instance to load intro text from the specified path
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
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the final message text in a bubble
                BubbleText(text: text),

                SizedBox(height: 60),

                Center(
                  // Wrapping the text with Center widget
                  child: Text(
                    'Tryk på knappen for at afslutte',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                SizedBox(height: 15),

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

          // Position the logo at the bottom-left of the screen
          Positioned(
            left: 8.0,
            bottom: 0,
            child: Logo(), // Logo widget
          ),
        ],
      ),
    );
  }
}
