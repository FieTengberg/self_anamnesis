import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/saveOrRepeat_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordScreen extends StatefulWidget {
  final int index;
  RecordScreen({required this.index});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

const audioFiles = ['audio_files/question1.mp3', 'audio_files/question2.mp3'];
const questionText = [
  'assets/text_strings/question1.txt',
  'assets/text_strings/question2.txt'
];

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  String questionString = ""; // Store question text here
  late AudioPlayer audioPlayer;
  late int questionsAnswered;
  late int totalQuestions;
  late double progress;
  final recorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    initRecorder();
    audioPlayer = AudioPlayer();
    playAudio(audioFiles[widget.index]);
    loadQuestionText(); // Load question text when screen initializes
    totalQuestions = questionText.length;
    questionsAnswered = widget.index + 1;
    progress = questionsAnswered / totalQuestions;
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
  }

  Future<void> playAudio(path) async {
    await audioPlayer.play(AssetSource(path));
  }

  Future<void> loadQuestionText() async {
    try {
      String getQuestion;
      getQuestion = await rootBundle.loadString(questionText[widget.index]);
      setState(() {
        questionString = getQuestion;
      });
    } catch (e) {
      setState(() {
        // Set text to an empty string in case of error
        questionString = 'It does not work!';
      });
    }
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    final path = await recorder.stopRecorder();
    if (path != null) {
      final audioFile = File(path);

      //connect to database
      // SAVE IN DATABASE 
      // send to API

      print(path);
      print('Recorded audio: $audioFile');

    } else {
      print('File not saved');
    }
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
              questionString,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 60), // Spacer

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
                                  : () async {
                                      //stop and dispose question reading if recording started
                                      await audioPlayer.stop();
                                      await audioPlayer.dispose();
                                      //start recording answer
                                      await record();
                                      //update state
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
                                  : () async {
                                      await stop();
                                      setState(() {
                                        isRecording = false;
                                      });
                                      // Navigate to the other screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SaveOrRepeatScreen(
                                                    index: widget.index,
                                                    questionString:
                                                        questionString)),
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
                        progress, // Change this value dynamically based on user's progress
                    backgroundColor: const Color.fromARGB(255, 223, 220, 220),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),

                SizedBox(width: 20), // Spacer between progress bar and text

                // Text displaying progress
                Text(
                  'Du er nået til $questionsAnswered ud af $totalQuestions spørgsmål', // Change this text dynamically based on user's progress
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
