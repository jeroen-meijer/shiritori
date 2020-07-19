import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/intl/intl.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class QuickPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intl = ShiritoriLocalizations.of(context).quickPlay;
    final uiIntl = ShiritoriLocalizations.of(context).ui;
    final textTheme = Theme.of(context).textTheme;

    return DefaultStylingColor(
      color: AppTheme.colorQuickPlay,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ShiritoriSliverNavigationBar(
              title: Text(intl.title),
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
