import 'package:flutter/material.dart';
import 'package:flutter_application_test/bubble_text_widget.dart';
import 'package:flutter_application_test/screens/saveOrRepeat_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioRecorder.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/app_colors.dart';
import 'package:flutter_application_test/bubble_text_widget.dart';

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
  String question = ""; // Empty string for the current question to be added
  late AnamnesisAudioPlayer audioPlayer;
  late int questionsAnswered;
  late int totalQuestions;
  late double progress;
  final recorder = FlutterSoundRecorder();
  late AnimationController animationController;
  final AnamnesisAudioRecorder audioRecorder = AnamnesisAudioRecorder();
  TextForDisplay textString = TextForDisplay();

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

    totalQuestions = 7;
    questionsAnswered = widget.index + 1;
    audioPlayer = AnamnesisAudioPlayer();
    progress = questionsAnswered / totalQuestions;

    audioPlayer.playAudio(
        'audio_files/question$questionsAnswered.mp3'); // Call function for playing audio file

    textString
        .getText('assets/text_strings/question$questionsAnswered.txt')
        .then((String fetchedText) {
      setState(() {
        question = fetchedText; // Updating the state with the fetched text
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
            SizedBox(height: 15), // Spacer

            // Text: Question
            BubbleText(text: question),

            SizedBox(height: 70), // Spacer

            // Large square container with black border
            Container(
              width: 800,
              height: 200,
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
                                width: 120,
                                height: 120,
                                color: isRecording
                                    ? AppColors.playBtnColor.withOpacity(0.5)
                                    : AppColors.playBtnColor,
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
                                                    questionString: question)),
                                      );
                                    },
                              child: Container(
                                width: 120,
                                height: 120,
                                color: isRecording
                                    ? AppColors.stopBtnColor
                                    : AppColors.stopBtnColor.withOpacity(0.5),
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
                ],
              ),
            ),

            // Blinking text container
            Container(
              height:
                  50.0, // Fixed space reserved for the text to appear when recording
              child: isRecording
                  ? FadeTransition(
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
                    )
                  : SizedBox(), // Empty SizedBox when not recording
            ),

            SizedBox(height: 60), // Spacer

            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress bar
                Container(
                  width: 450,
                  height: 12,
                  child: LinearProgressIndicator(
                    value:
                        progress, // value changes dynamically based on user's progress
                    backgroundColor: const Color.fromARGB(255, 223, 220, 220),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.btnColor),
                  ),
                ),

                SizedBox(width: 20), // Spacer between progress bar and text

                // Text displaying progress
                Text(
                  'Du er nået til $questionsAnswered ud af $totalQuestions spørgsmål', // Change this text dynamically based on user's progress
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
