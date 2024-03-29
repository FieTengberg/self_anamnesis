import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/recordAnswer_screen.dart';
import 'package:audioplayers/audioplayers.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    //audioPlayer = AudioPlayer();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio() async {
    String soundPath = "audio_files/intro.mp3";
    await audioPlayer.play(AssetSource(soundPath));
  }

  @override
  Widget build(BuildContext context) {
    playAudio();
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
                      'Hej!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10), // space between sections
                    Text(
                      'For at hjælpe din fysioterapeut med at målrette sin behandlingsindsats, skal vi have dig til at besvare nogle spørgsmål omhandlende din problematik og grunden til at du er her.',
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
