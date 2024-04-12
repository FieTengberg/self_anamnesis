import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/saveOrRepeat_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_application_test/Record_model/audioRecord.dart';

class RecordScreen extends StatefulWidget {
  final int index;
  RecordScreen({required this.index});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false; // Flag to track recording status
  bool isInitialized = false; // Flag to track initialization status
  String questionString =
      ""; // Empty string for the current question to be added
  late AudioPlayer audioPlayer;
  late int questionsAnswered;
  late int totalQuestions;
  late double progress;
  final recorder = FlutterSoundRecorder();
  late AnimationController animationController;
  final AudioRecorder audioRecorder = AudioRecorder();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.repeat(reverse: true);

    super.initState();

    if (!isInitialized) {
      // Only initialize if not already initialized
      audioRecorder.initRecorder();
      isInitialized = true; // flag set to true after initialization
    }

    totalQuestions = 2;
    questionsAnswered = widget.index + 1;
    audioPlayer = AudioPlayer();
    progress = questionsAnswered / totalQuestions;

    playAudio(
        'audio_files/question$questionsAnswered.mp3'); // Call function for playing audio file

    loadQuestionText(
        'assets/text_strings/question$questionsAnswered.txt'); // Load question text
  }

  Future<void> playAudio(path) async {
    await audioPlayer.play(AssetSource(path));
  }

  Future loadQuestionText(String path) async {
    String questionText = await rootBundle.loadString(path);
    setState(() {
      questionString = questionText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              height: 300,
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
                                      await audioRecorder.startRecording();
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
                                fontSize: 20,
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
                                      await audioRecorder
                                          .stopRecording(questionsAnswered);
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
                                fontSize: 20,
                                color: isRecording ? Colors.black : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isRecording) // Show message only when recording is in progress
                    FadeTransition(
                      opacity: animationController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Optagelse igang',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
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
