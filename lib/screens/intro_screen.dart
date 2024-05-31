import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';
import 'package:flutter_application_test/CustomizedClasses/text_bubble_display.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

// Defining the IntroScreen widget as a StatefulWidget
class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

// Defining the state for the IntroScreen widget
class IntroScreenState extends State<IntroScreen> {
  String text = ""; // Variable to hold the text for displaying the intro
  AnamnesisAudioPlayer audioPlayer =
      AnamnesisAudioPlayer(); // Audio player instance
  TextForDisplay textString = TextForDisplay(); // Text loader instance

  // Overriding the initState method to perform initializations
  @override
  void initState() {
    super.initState();

    // Play the introduction audio
    audioPlayer.playAudio(
        'audio_files/intro.mp3'); // playAudio function for playing audio file

    // Using Text loader instance to load intro text from the specified path
    textString
        .getText('assets/text_strings/intro.txt')
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
                // Display the intro text in a bubble
                BubbleText(text: text),
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'Tryk på knappen for at starte',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () async {
                    // Stop and dispose the audio player when the button is pressed
                    await audioPlayer.stop();
                    await audioPlayer.dispose();

                    // Navigating to RecordScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecordScreen(index: 0)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnColor,
                    minimumSize: Size(450, 50),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),

          // Position the logo at the bottom-left of the screen
          Positioned(
            left: 30, 
            bottom: 0.8, 
            child:
                Logo(), // Logo widget 
          ),
        ],
      ),
    );
  }
}
