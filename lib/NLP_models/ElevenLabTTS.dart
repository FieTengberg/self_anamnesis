/*
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_libwinmedia/just_audio_libwinmedia.dart';

final player = AudioPlayer(); //audio player obj that will play audio

// Feed your own stream of bytes into the player
class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}

class TextToSpeech extends StatefulWidget {
  @override
  State<TextToSpeech> createState() => TextToSpeechState();
}

class TextToSpeechState extends State<TextToSpeech> {
  Future<void> locateIndexInJsonFile(int index) async {
    final String response = await rootBundle.loadString('assets/tts_data.json');
    final data = await json.decode(response);
    String text =
        data["tts_data"][index]["text"]; // Fetch the text based on index
    makeTextToSpeechRequest(
        text); // Pass the fetched text to makeTextToSpeechRequest
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<void> makeTextToSpeechRequest(String input) async {
  const key = "50c3b39252b5ddfc0816eea3d64641f5";
  String url =
      'https://api.elevenlabs.io/v1/text-to-speech/21m00Tcm4TlvDq8ikWAM';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'accept': 'audio/mpeg',
      'xi-api-key': key,
      'Content-Type': 'application/json',
    },
    body: json.encode({
      "text": input,
      "model_id": "eleven_multilingual_v2",
      "voice_settings": {"stability": .15, "similarity_boost": .75}
    }),
  );
  if (response.statusCode == 200) {
    print('YAY: Text to speech request successful');

    final bytes = response.bodyBytes; //get the bytes ElevenLabs sent back
    await player.setAudioSource(MyCustomSource(
        bytes)); //send the bytes to be read from the JustAudio library
    player.play(); //play the audio
    // Request was successful
  } else {
    // Request failed
    print('ØV: Error: ${response.statusCode}');
  }
}
*/