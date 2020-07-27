import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.backgroundColor = AppTheme.colorButtonBackgroundPrimary,
    this.backgroundColorDisabled =
        AppTheme.colorButtonBackgroundPrimaryDisabled,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final Color shadowColor;
  final double elevation;
  final ShapeBorder shape;
  final Color backgroundColor;
  final Color backgroundColorDisabled;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: WideButton(
        backgroundColor: backgroundColor,
        backgroundColorDisabled: backgroundColorDisabled,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
