import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';
import 'package:flutter_application_test/CustomizedClasses/text_bubble_display.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  String text = ""; //for displaying question
  AnamnesisAudioPlayer audioPlayer = AnamnesisAudioPlayer();
  TextForDisplay textString = TextForDisplay();

  @override
  void initState() {
    super.initState();

    audioPlayer.playAudio(
        'audio_files/intro.mp3'); // Call function for playing audio file

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
                BubbleText(text: text),

                SizedBox(height: 40), // Spacer

                Center(
                  // Wrapping the intro text with Center widget
                  child: Text(
                    'Tryk på knappen for at starte',
                    style: TextStyle(fontSize: 14),
                  ),
                ),

                SizedBox(height: 15), // Spacer

                ElevatedButton(
                  onPressed: () async {
                    // Handle button press
                    await audioPlayer.stop();
                    await audioPlayer.dispose();
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
          Positioned(
            left: 8.0, // adjust left position as needed
            bottom: 0, // adjust bottom position as needed
            child:
                Logo(), // Add Logo widget outside of the main content container
          ),
        ],
      ),
    );
  }
}
