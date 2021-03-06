import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class ExpandingRouteButton extends StatelessWidget {
  const ExpandingRouteButton({
    Key key,
    @required this.routeBuilder,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final WidgetBuilder routeBuilder;
  final Widget child;

  bool get _enabled => routeBuilder != null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: OpenContainer(
        transitionDuration: AppTheme.durationAnimationDefault,
        openBuilder: (context, close) {
          return routeBuilder?.call(context);
        },
        closedColor: !_enabled
            ? AppTheme.colorButtonBackgroundPrimaryDisabled
            : AppTheme.colorButtonBackgroundPrimary,
        closedShape: AppTheme.shapeDefault,
        closedElevation:
            !_enabled ? AppTheme.elevationDisabled : AppTheme.elevationDefault,
        closedBuilder: (context, open) {
          return WideButton(
            transparent: true,
            onTap: !_enabled ? null : open,
            child: child,
          );
        },
      ),
    );
  }
}
