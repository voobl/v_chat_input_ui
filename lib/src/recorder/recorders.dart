// Copyright 2023, the hatemragab project author.
// All rights reserved. Use of this source code is governed by a
// MIT license that can be found in the LICENSE file.

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

abstract class AppRecorder {
  Future<void> start([String? path]);

  Future<String?> stop();

  Future pause();

  Future<bool> isRecording();

  Future<void> close();
}

class MobileRecorder extends AppRecorder {
  final recorder = RecorderController();

  @override
  Future<void> start([String? path]) async {
    await recorder.record(path: path);
  }

  @override
  Future<String?> stop() async {
    final path = await recorder.stop();
    if (path != null) {
      return Uri.parse(path).path;
    }
    return null;
  }

  @override
  Future pause() async {
    await recorder.pause();
  }

  @override
  Future close() async {
    recorder.dispose();
  }

  @override
  Future<bool> isRecording() async {
    return recorder.isRecording;
  }
}

class PlatformRecorder extends AppRecorder {
  //final recorder = AudioRecorder();
  final record = Record();

  @override
  Future close() async {
    //  await recorder.dispose();
    await record.dispose();
  }

  @override
  Future pause() async {
    //   await recorder.pause();
    await record.pause();
  }

  @override
  Future<void> start([String? path]) async {
    // var encoder = const RecordConfig(encoder: AudioEncoder.aacLc);
    // if (kIsWeb) {
    //   encoder = const RecordConfig(encoder: AudioEncoder.opus);
    // }
    // await recorder.start(
    //   encoder,
    //   path: path ?? "",
    // );

    await record.start(path: path ?? "");


  }

  @override
  Future<bool> isRecording() async {
    // return recorder.isRecording();
    return record.isRecording();
  }

  @override
  Future<String?> stop() async {
    // return recorder.stop();
    return record.stop();
  }
}