import 'package:flutter/material.dart';
import 'package:shiritori/app/app.dart';

import 'assets/assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final backgroundImage = await Images.loadBackground();
  runApp(AppRoot(backgroundImage: backgroundImage));
}
