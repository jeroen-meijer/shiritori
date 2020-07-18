import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/main/main.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({
    @required this.backgroundImage,
  });

  final ui.Image backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Provider<ui.Image>.value(
      value: backgroundImage,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeDataLight,
        localizationsDelegates: const [
          ShiritoriLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: MainContainer(),
      ),
    );
  }
}
