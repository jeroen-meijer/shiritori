import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shiritori/app/app.dart';
import 'package:shiritori/backend/backend.dart';

import 'assets/assets.dart';

void main() async {
  var level = 0;
  void _log(String message) {
    log(
      message,
      name: 'main',
      sequenceNumber: level++,
      time: DateTime.now(),
    );
  }

  _log('Initializing bindings...');

  final initStopwatch = Stopwatch()..start();
  WidgetsFlutterBinding.ensureInitialized();
  _log('Loading background image...');
  final backgroundImage = await Images.loadBackground();
  _log('Loading dictionaries...');
  // Poor phone :(
  final dictionaries = await Dictionaries.loadFromDisk();
  initStopwatch.stop();

  final seconds = (initStopwatch.elapsedMilliseconds / 1000).toStringAsFixed(3);
  _log('Initialization done. (took $seconds seconds)');

  runApp(
    AppRoot(
      backgroundImage: backgroundImage,
      dictionaries: dictionaries,
    ),
  );
}
