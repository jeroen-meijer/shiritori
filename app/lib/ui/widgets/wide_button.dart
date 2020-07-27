import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    Key key,
    this.transparent = false,
    this.backgroundColor = AppTheme.colorButtonBackgroundPrimary,
    this.backgroundColorDisabled =
        AppTheme.colorButtonBackgroundPrimaryDisabled,
    @required this.onTap,
    @required this.child,
  })  : assert(transparent != null),
        super(key: key);

  final bool transparent;
  final Color backgroundColor;
  final Color backgroundColorDisabled;
  final VoidCallback onTap;
  final Widget child;

  bool get _enabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: !_enabled ? backgroundColorDisabled : backgroundColor,
      type: transparent ? MaterialType.transparency : MaterialType.canvas,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 64.0,
          child: Center(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.button,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
