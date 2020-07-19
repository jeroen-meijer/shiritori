import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';
import 'package:shiritori/ui/routes/routes.dart';
import 'package:shiritori/utils/utils.dart';

class ZoomContainer extends StatefulWidget {
  const ZoomContainer({
    Key key,
    @required this.routeNotifier,
    this.scaleFactor = 1.0,
    @required this.child,
  })  : assert(scaleFactor != null),
        assert(routeNotifier != null),
        super(key: key);

  final RouteNotifier<ZoomPageRoute> routeNotifier;
  final double scaleFactor;
  final Widget child;

  @override
  _ZoomContainerState createState() => _ZoomContainerState();
}

class _ZoomContainerState extends State<ZoomContainer>
    with
        SingleTickerProviderStateMixin,
        RouteNotifierStateMixin<ZoomPageRoute, ZoomContainer> {
  static const _zoomInCurve = Curves.easeInOut;
  static const _zoomOutCurve = Curves.easeOutCubic;

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
      curve: _zoomInCurve,
      reverseCurve: _zoomOutCurve.flipped,
    );
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route.isFirst) {
      return;
    }

    _tryAnimateForwardOnce();
  }

  @override
  void didPop(Route route, Route previousRoute) {
    _tryAnimateBackwardOnce();
  }

  @override
  void didRemove(Route route, Route previousRoute) {}

  @override
  void didReplace({Route newRoute, Route oldRoute}) {}

  void _tryAnimateForwardOnce() {
    log('_tryAnimateForwardOnce');
    _routeDepth += 1;
    if (_routeDepth > 1) {
      // No animations have been implemented yet for a route depth greater than
      // one.
      return;
    }

    log('  animating forward (routeDepth: $_routeDepth)');
    if (_animationController.isAnimating) {
      _animationController.stop(canceled: true);
    }
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

    if (_animationController.isAnimating) {
      _animationController.stop(canceled: true);
    }
    _animationController.animateBack(_routeDepth.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // FIXME: Super hacky, but works ¯\_(ツ)_/¯
        final value = _animation.value % 1.0;

        return Transform.scale(
          scale: 1.0 + ((value * 0.6) * widget.scaleFactor),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
