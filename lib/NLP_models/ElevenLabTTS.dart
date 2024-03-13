import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TextToSpeech extends StatefulWidget {
  @override
  State<TextToSpeech> createState() => TextToSpeechState();
}

class TextToSpeechState extends State<TextToSpeech> {
  Future<void> locateIndexInJsonFile(int index) async {
    final String response =
        await rootBundle.loadString('assets/tts_data.json');
    final data = await json.decode(response);
    String text =
        data["tts_data"][index]["text"]; // Fetch the text based on index
    print("Input Text: $text"); // Print the input text for debugging
    makeTextToSpeechRequest(text); // Pass the fetched text to makeTextToSpeechRequest
  }

  @override
  Widget build(BuildContext context) {
    
    return Container();
  }
}

Future<void> makeTextToSpeechRequest(String input) async {
  final channel = WebSocketChannel.connect(Uri.parse(
      'wss://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM/stream-input?model_id=eleven_multilingual_v2'));
  const key = "50c3b39252b5ddfc0816eea3d64641f5";

  print('Connecting to WebSocket...'); // Debugging print statement

  // Send the initial message
  final bosMessage = {
    "text": " ",
    "voice_settings": {"stability": 0.5, "similarity_boost": 0.8},
    "xi_api_key": key,
  };
  channel.sink.add(json.encode(bosMessage));

  print('Initial message sent.'); // Debugging print statement

  // Send the input text message
  final textMessage = {
    "text": input,
    "try_trigger_generation": true,
  };
  channel.sink.add(json.encode(textMessage));

  print('Input text message sent: $input'); // Debugging print statement

  // Send the EOS message with an empty string
  final eosMessage = {"text": ""};
  channel.sink.add(json.encode(eosMessage));

  print('EOS message sent.'); // Debugging print statement
  

  // Close the WebSocket connection after a brief delay
  await Future.delayed(Duration(seconds: 5));

  print('Closing WebSocket connection...'); // Debugging print statement

  // Close the WebSocket connection
  await channel.sink.close();

  print('WebSocket connection closed.'); // Debugging print statement
}
