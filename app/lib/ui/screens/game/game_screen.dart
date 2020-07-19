import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).game;
    final uiIntl = ShiritoriLocalizations.of(context).ui;

    return DefaultStylingColor(
      color: AppTheme.colorSingleplayer,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            AppSliverNavigationBar(
              title: Text(intl.singleplayerTitle),
              leading: TextButton(
                onTap: Navigator.of(context).pop,
                child: Text(uiIntl.back),
              ),
            ),
            const SliverFillRemaining(
              child: ColoredBox(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
