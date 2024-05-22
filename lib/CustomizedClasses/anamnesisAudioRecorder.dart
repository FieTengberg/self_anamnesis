import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// Class for managing audio recording functionality
class AnamnesisAudioRecorder {
  late FlutterSoundRecorder recorder; // Instance of FlutterSoundRecorder

  // Method to initialize the audio recorder
  Future<void> initRecorder() async {
    // Requesting microphone permission
    final status = await Permission.microphone.request();

    // Check if microphone permission is granted
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    // Initialize the recorder
    recorder = FlutterSoundRecorder();
    await recorder.openRecorder();
  }

  // Method to start recording audio
  Future<void> startRecording() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  // Method to stop recording and save the file
  Future<String?> stopRecording(int questionNumber) async {
    final internalFilePath = await recorder
        .stopRecorder(); // Stop the recorder and get the path to the recorded file
    if (internalFilePath != null) {
      //if there is content in file
      // Get the path to the external storage directory
      final externalStoragePath = (await getExternalStorageDirectory())!.path;
      try {
        // Construct the new file path
        final newFilePath = '$externalStoragePath/question$questionNumber.mp3';
        final internalFile = File(internalFilePath);

        await internalFile
            .copy(newFilePath); // Copy the recorded file to the new location
        return newFilePath;
      } catch (e) {
        print('Error copying file: $e'); // Print error if copy fails
        return null;
      }
    }
    return null; // Return null if internalFilePath is null
  }

  // Method to dispose of the recorder
  Future<void> disposeRecorder() async {
    await recorder.closeRecorder(); // Closing the recorder to free up resources
  }
}
