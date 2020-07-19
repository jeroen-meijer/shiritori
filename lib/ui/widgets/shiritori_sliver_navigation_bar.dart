import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShiritoriSliverNavigationBar extends StatelessWidget {
  ShiritoriSliverNavigationBar({
    @required this.title,
    this.leading,
    this.trailing,
  });

  final Widget title;
  final Widget leading;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return CupertinoSliverNavigationBar(
      automaticallyImplyLeading: false,
      automaticallyImplyTitle: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      border: Border.all(
        width: 0,
        color: Colors.transparent,
        style: BorderStyle.none,
      ),
      brightness: Brightness.light,
      largeTitle: Center(
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: textTheme.headline4.color,
            fontFamily: textTheme.headline3.fontFamily,
            fontWeight: textTheme.headline3.fontWeight,
            letterSpacing: textTheme.headline3.letterSpacing,
          ),
          child: title,
        ),
      ),
      leading: SizedBox(
        width: 64.0,
        child: leading,
      ),
      trailing: SizedBox(
        width: 64.0,
        child: trailing,
      ),
    );
  }
}
