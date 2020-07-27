import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class ToggleCardButton extends StatefulWidget {
  const ToggleCardButton({
    Key key,
    @required this.value,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final bool value;
  final VoidCallback onTap;
  final Widget child;

  @override
  _ToggleCardButtonState createState() => _ToggleCardButtonState();
}

class _ToggleCardButtonState extends State<ToggleCardButton> {
  static const duration = AppTheme.durationAnimationDefault;
  static const curve = AppTheme.curveDefault;

  bool get _isOn => widget.value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rawActiveColor = AppTheme.colorButtonBackgroundPrimary;
    final rawInactiveColor = AppTheme.white;

    final rawBackgroundColor = _isOn ? rawActiveColor : rawInactiveColor;
    final rawForegroundColor = _isOn ? rawInactiveColor : rawActiveColor;

    return TweenAnimationBuilder<Color>(
      duration: duration,
      curve: curve,
      tween: ColorTween(end: rawBackgroundColor),
      builder: (context, backgroundColor, child) {
        return TweenAnimationBuilder<Color>(
          duration: duration,
          curve: curve,
          tween: ColorTween(end: rawForegroundColor),
          builder: (context, foregroundColor, child) {
            return Theme(
              data: theme.copyWith(splashColor: foregroundColor),
              child: CardButton(
                elevation: _isOn ? null : AppTheme.elevationDisabled,
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.borderRadiusCardDefault,
                  side: BorderSide(
                    color: rawActiveColor,
                    width: 4.0,
                  ),
                ),
                onTap: widget.onTap,
                child: DefaultTextStyle(
                  style: theme.textTheme.button.copyWith(
                    color: rawForegroundColor,
                  ),
                  child: child,
                ),
              ),
            );
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
