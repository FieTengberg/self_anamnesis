import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class MyAudioPlayer {
  late AudioPlayer audioPlayer ;


Future<void> playAudio(path) async {
  audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource(path));
  }

Future<void> stop() async {
    await audioPlayer.stop();
  }

Future<void> dispose() async {
    await audioPlayer.dispose();
  }
}
