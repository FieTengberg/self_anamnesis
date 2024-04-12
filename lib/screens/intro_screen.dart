import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  String text = ""; //for displaying question
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    getText();
  }

  Future<void> playAudio() async {
    String soundPath = "audio_files/intro.mp3";
    await audioPlayer.play(AssetSource(soundPath));
  }

  Future<void> getText() async {
    try {
      String introText;
      introText = await rootBundle.loadString('assets/text_strings/intro.txt');
      setState(() {
        text = introText;
      });
    } catch (e) {
      setState(() {
        // Message in case of error
        text = 'It does not work!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    playAudio();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large square containing intro text
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
