import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/saveOrRepeat_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;


class RecordScreen extends StatefulWidget {
  final int index;
  RecordScreen({required this.index});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

const audioFiles = ['audio_files/question1.mp3', 'audio_files/question1.mp3'];
const questionText = ['assets/text_strings/question1.txt','text_strings/question2.txt'];

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  late AudioPlayer audioPlayer;
  late String text; // Store question text here

  Future<void> playAudio(path) async {
    await audioPlayer.play(AssetSource(path));
  }

Future<void> loadQuestionText() async {
  try {
    String question;
    question = await rootBundle.loadString(questionText[0]);
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
  void initState() {
    super.initState();
    
    audioPlayer = AudioPlayer();
    loadQuestionText(); // Load question text when screen initializes
    playAudio(audioFiles[widget.index]);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text: Question
            Text(
          text,
  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
     textAlign: TextAlign.center, // Align text center
),
            SizedBox(height: 10), // Spacer
            // Text: Added explanation
            Text(
              '',
              //'1 er ingen smerte og 10 er den værst tænkelige smerte, som du kan forestille dig',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            SizedBox(height: 50), // Spacer

            // Large square container with black border
            Container(
              width: 800,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Green square for play symbol
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: isRecording
                                  ? null // Disable onTap when recording
                                  : () {
                                      setState(() {
                                        isRecording = true;
                                      });
                                    },
                              child: Container(
                                width: 100,
                                height: 100,
                                color: isRecording
                                    ? Colors.green.withOpacity(0.5)
                                    : Colors.green,
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Spacer
                            Text(
                              'Start',
                              style: TextStyle(
                                fontSize: 18,
                                color: isRecording ? Colors.grey : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Red square for stop button
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: !isRecording
                                  ? null // Disable onTap when not recording
                                  : () {
                                      setState(() {
                                        isRecording = false;
                                      });
                                      // Navigate to the other screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SaveOrRepeatScreen(
                                                    index: widget.index)),
                                      );
                                    },
                              child: Container(
                                width: 100,
                                height: 100,
                                color: isRecording
                                    ? Colors.red
                                    : Colors.red.withOpacity(0.5),
                                child: Icon(
                                  Icons.stop,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 5), // Spacer
                            Text(
                              'Stop',
                              style: TextStyle(
                                fontSize: 18,
                                color: isRecording ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isRecording) // Show message only when recording is in progress
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Optagelsen er igang', // Your message here
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Customize the color as needed
                        ),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 60), // Spacer

            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress bar
                Container(
                  width: 450,
                  height: 10,
                  child: LinearProgressIndicator(
                    value:
                        0.5, // Change this value dynamically based on user's progress
                    backgroundColor: const Color.fromARGB(255, 223, 220, 220),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),

                SizedBox(width: 20), // Spacer between progress bar and text

                // Text displaying progress
                Text(
                  'Du har svaret på 5 ud af 10 spørgsmål', // Change this text dynamically based on user's progress
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}