import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shiritori/app/app.dart';
import 'package:shiritori/backend/backend.dart';

import 'assets/assets.dart';

void main() async {
  log('Initializing bindings...');

  final initStopwatch = Stopwatch()..start();
  WidgetsFlutterBinding.ensureInitialized();
  log('Loading background image...');
  final backgroundImage = await Images.loadBackground();
  log('Loading dictionaries...');
  // Poor phone :(
  final dictionaries = await Dictionaries.loadFromDisk();
  initStopwatch.stop();

  final seconds = (initStopwatch.elapsedMilliseconds / 1000).toStringAsFixed(3);
  log('Initialization done. (took $seconds seconds)');

  runApp(
    AppRoot(
      backgroundImage: backgroundImage,
      dictionaries: dictionaries,
    ),
  );
}
