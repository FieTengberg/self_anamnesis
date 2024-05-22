import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

// Class for managing audio playback functionality
class AnamnesisAudioPlayer {
  late AudioPlayer audioPlayer; // Instance of AudioPlayer

// Method to play audio from a specified path
  Future<void> playAudio(path) async {
    audioPlayer = AudioPlayer();
    await audioPlayer
        .play(AssetSource(path)); // Play the audio from the asset source
  }

// Method to stop the audio playback
  Future<void> stop() async {
    await audioPlayer.stop();
  }

// Method to dispose the audio playback
  Future<void> dispose() async {
    await audioPlayer.dispose();
  }
}
