import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/app_colors.dart';
import 'package:flutter_application_test/bubble_text_widget.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BubbleText(text: text),
            // Large square containing intro text
            /*Container(
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
                      style: TextStyle(fontSize: 20, color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
            ),*/

            SizedBox(height: 40), // Spacer

            Center(
              // Wraping the intro text with Center widget
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
    );
  }
}
