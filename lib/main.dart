import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/intro_screen.dart';
import 'NLP_models/ElevenLabTTS.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  runApp(const MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const LogInScreen(title: 'Self-anamnesis'),
    );
  }
}

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key, required this.title});

  final String title;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 400.0,
          height: 300.0,
          alignment: Alignment.bottomCenter, // Align content to the bottom
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Indtast dit CPR nummer',
                ),
              ),
              const SizedBox(
                  height: 30), // Adding space between TextField and Button
              ElevatedButton(
                onPressed: () async {
                  // Handle button press
                  // Make the text-to-speech request
                  //TextToSpeechState textProvider = TextToSpeechState();
                  //textProvider.locateIndexInJsonFile(0);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(450, 50),
                ),
                child: Text(
                  'Log ind',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
