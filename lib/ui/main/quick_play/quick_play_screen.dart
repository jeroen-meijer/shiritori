import 'package:flutter/material.dart';
import 'package:shiritori/intl/intl.dart';

class QuickPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).home;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          intl.quickPlayCardTitle,
          style: textTheme.headline4,
        ),
      ),
    );
  }
}
