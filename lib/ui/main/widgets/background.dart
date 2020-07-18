import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shiritori/assets/assets.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/routes/routes.dart';
import 'package:shiritori/utils/utils.dart';

class Background extends StatefulWidget {
  const Background({
    Key key,
    @required this.routeNotifier,
  })  : assert(routeNotifier != null),
        super(key: key);

  final RouteNotifier<ZoomPageRoute> routeNotifier;

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>
    with
        SingleTickerProviderStateMixin,
        RouteNotifierStateMixin<ZoomPageRoute, Background> {
  static const _curve = AppTheme.curveDefault;

  AnimationController _animationController;
  Animation<double> _animation;

  var _routeDepth = 0;

  @override
  RouteNotifier<ZoomPageRoute> get routeNotifier => widget.routeNotifier;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppTheme.durationAnimationDefault,
      lowerBound: 0.0,
      // Can be increased to animate multiple stages.
      upperBound: 1.0,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: _curve,
      reverseCurve: _curve.flipped,
    );
  }

  @override
  void didPush(Route route, Route previousRoute) {
    log(
      '!!! didPush '
      'route: ${route?.runtimeType} (${route?.settings?.name}) | '
      'previousRoute: ${previousRoute?.runtimeType} '
      '(${previousRoute?.settings?.name})',
    );

    if (route.isFirst) {
      return;
    }

    _tryAnimateForwardOnce();
  }

  @override
  void didPop(Route route, Route previousRoute) {
    log(
      '!!! didPop '
      'route: ${route?.runtimeType} (${route?.settings?.name}) | '
      'previousRoute: ${previousRoute?.runtimeType} '
      '(${previousRoute?.settings?.name})',
    );

    _tryAnimateBackwardOnce();
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    log(
      'didRemove '
      'route: ${route?.runtimeType} (${route?.settings?.name}) | '
      'previousRoute: ${previousRoute?.runtimeType} '
      '(${previousRoute?.settings?.name})',
    );
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    log(
      'didReplace '
      'newRoute: ${newRoute?.runtimeType} (${newRoute?.settings?.name}) | '
      'oldRoute: ${oldRoute?.runtimeType} (${oldRoute?.settings?.name})',
    );
  }

  void _tryAnimateForwardOnce() {
    log('_tryAnimateForwardOnce');
    _routeDepth += 1;
    if (_routeDepth > 1) {
      // No animations have been implemented yet for a route depth greater than
      // one.
      return;
    }

    log('  animating forward (routeDepth: $_routeDepth)');
    _animationController.animateTo(_routeDepth.toDouble());
  }

  void _tryAnimateBackwardOnce() {
    log('_tryAnimateBackwardOnce');
    _routeDepth -= 1;
    if (_routeDepth != 0) {
      // No animations have been implemented yet for a route depth greater than
      // one.
      return;
    }

    log('  animating back (routeDepth: $_routeDepth)');

    _animationController.animateBack(_routeDepth.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage = Provider.of<ui.Image>(context, listen: false);
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value;

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Opacity(
            opacity: 1.0 - value,
            child: Transform.scale(
              scale: 1.0 + (value * 0.6),
              child: child,
            ),
          ),
        );
      },
      child: RawImage(
        image: backgroundImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
