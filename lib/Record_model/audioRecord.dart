import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder {
  late FlutterSoundRecorder recorder;

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    recorder = FlutterSoundRecorder();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future<String?> stopRecording(int questionNumber) async {
    final internalFilePath = await recorder.stopRecorder();
    if (internalFilePath != null) {
      final externalStoragePath = (await getExternalStorageDirectory())!.path;
      try {
        final newFilePath = '$externalStoragePath/question$questionNumber.mp3';
        final internalFile = File(internalFilePath);
        await internalFile.copy(newFilePath);
        return newFilePath;
      } catch (e) {
        print('Error copying file: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> disposeRecorder() async {
    await recorder.closeRecorder();
  }
}
