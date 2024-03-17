
import 'package:flutter/material.dart';
import 'package:flutter_application_test/NLP_models/ElevenLabTTS.dart';
import 'package:flutter_application_test/screens/anamnesisFinish_screen.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:flutter_application_test/screens/askQuestion_screen.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/services.dart' show rootBundle;


class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  late String text;
  Future<void> playAudio(path) async {
    await audioPlayer.play(AssetSource(path));
  }

  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    loadQuestionText();
    playAudio('audio_files/intro1.mp3');
  }
  
  
  Future<void> loadQuestionText() async {
    try {
      String question;
      question = await rootBundle.loadString('assets/text_strings/intro.txt');
     setState(() {
        text = question;
      });
    } catch (e) {
      setState(() {
        // Set text to an empty string in case of error
        text = 'It does not work!';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large square for text
            Container(
              width: 600,
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
                    SizedBox(height: 10), // space between sections
                    Text(
                      '',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30), // Spacer

            Center(
              // Wrap the text with Center widget
              child: Text(
                'Tryk på knappen for at starte',
                style: TextStyle(fontSize: 14),
              ),
            ),
            // Pressable button

            SizedBox(height: 15), // Spacer

            ElevatedButton(
              onPressed: () async {
                // Handle button press
              
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordScreen(index: 0)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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