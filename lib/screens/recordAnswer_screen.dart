import 'package:flutter/material.dart';
import 'package:flutter_application_test/CustomizedClasses/text_bubble_display.dart';
import 'package:flutter_application_test/screens/saveOrRepeat_screen.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioRecorder.dart';
import 'package:flutter_application_test/CustomizedClasses/anamnesisAudioPlayer.dart';
import 'package:flutter_application_test/CustomizedClasses/textForDisplay.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

// RecordScreen widget for recording answers to questions
class RecordScreen extends StatefulWidget {
  final int index;
  RecordScreen({required this.index});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

// State class for the RecordScreen widget
class _RecordScreenState extends State<RecordScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false; // Flag to track recording status
  bool isInitialized = false; // Flag to track initialization status

  String question = ""; // Empty string for the current question to be added

  // Instances for audio player and recorder
  late AnamnesisAudioPlayer audioPlayer;
  final recorder = FlutterSoundRecorder();
  late AnimationController animationController;
  final AnamnesisAudioRecorder audioRecorder = AnamnesisAudioRecorder();

  //Instances of other variables initialized and used later in the code
  late int questionsAnswered;
  final int totalQuestions = 7; //fixed number of questions in prototype
  late double progress;

  //Initializing widget for fetching question in text
  TextForDisplay textString = TextForDisplay();

  @override
  void initState() {
    // Initializing animation controller
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.repeat(reverse: true);

    super.initState();

    // Only initialize recorder if not already initialized
    if (!isInitialized) {
      audioRecorder.initRecorder();
      isInitialized = true; // flag set to true after initialization
    }

    //Intializing variables for progress bar calculation and other
    questionsAnswered = widget.index + 1;
    progress = questionsAnswered / totalQuestions;

    // Initializing audio player and playing current question audio
    audioPlayer = AnamnesisAudioPlayer();
    audioPlayer.playAudio(
        'audio_files/question$questionsAnswered.mp3'); // Call function for playing audio file

    //fetching text for current question
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
            SizedBox(height: 90),

            // Displaying the question text using BubbleText widget
            BubbleText(text: question),

            SizedBox(height: 65),

            // Large square container with buttons
            Container(
              width: 800,
              height: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Green square for recording answer
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
                            SizedBox(height: 5),
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

                      // Red square for stopping recording
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
                                      // Navigate to SaveOrRepeatScreen
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
                            SizedBox(height: 5),
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

            // Blinking text container indicating recording active
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

            // Progress indicator and logo
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(), //logo
                      SizedBox(
                          width: 20), // Spacer between logo and progress bar

                      // Progress bar indicating user's progress
                      Container(
                        width: 450,
                        height: 12,
                        child: LinearProgressIndicator(
                          value:
                              progress, // value changes dynamically based on user's progress
                          backgroundColor:
                              const Color.fromARGB(255, 223, 220, 220),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.btnColor),
                        ),
                      ),

                      SizedBox(
                          width: 20), // Spacer between progress bar and text

                      // Text displaying progress
                      Text(
                        'Du er nået til $questionsAnswered ud af $totalQuestions spørgsmål', // Changes dynamically
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(
                          width: 200), // Spacer between text and right border
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
