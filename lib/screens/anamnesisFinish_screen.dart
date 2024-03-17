import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;

class FinishScreen extends StatefulWidget {
  @override
  FinishScreenState createState() => FinishScreenState();
}

class FinishScreenState extends State<FinishScreen> {
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
    playAudio('audio_files/finalMessage.mp3');
  }

  Future<void> loadQuestionText() async {
    try {
      String question;
      question = await rootBundle.loadString('assets/text_strings/finish.txt');
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
        title: Text('Finish Screen'),
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
                   /* Text(
                      'Dine svar bliver nu sendt videre til din fysioterapeut, som vil læse det igennem, inden du kaldes ind til videre undersøgelse og tests. I mellemtiden kan du finde dig til rette i venteværelset med et magasin og en kop te eller kaffe.',
                      style: TextStyle(fontSize: 20),
                    ),*/
                  ],
                ),
              ),
            ),

            SizedBox(height: 30), // Spacer

            Center(
              // Wrap the text with Center widget
              child: Text(
                'Tryk på knappen for at afslutte',
                style: TextStyle(fontSize: 14),
              ),
            ),
            // Pressable button

            SizedBox(height: 15), // Spacer

            ElevatedButton(
              onPressed: () {}, // Empty function body
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
