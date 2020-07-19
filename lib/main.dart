import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shiritori/app/app.dart';

import 'assets/assets.dart';

void main() async {
  log('Initializing binding...');
  WidgetsFlutterBinding.ensureInitialized();
  log('Loading background image...');
  final backgroundImage = await Images.loadBackground();
  log('Initialization done.');
  runApp(AppRoot(backgroundImage: backgroundImage));
}
