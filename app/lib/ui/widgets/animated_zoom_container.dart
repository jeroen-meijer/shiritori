import 'package:flutter/material.dart';
import 'package:shiritori/ui/screens/home/home.dart';

typedef AnimatedZoomBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  double scale,
  Widget child,
);

class AnimatedZoomContainer extends StatelessWidget {
  const AnimatedZoomContainer({
    Key key,
    this.scale,
    this.parentAnimation,
    this.curve,
    this.reverseCurve,
    this.builder = defaultBuilder,
    @required this.child,
  }) : super(key: key);

  final double scale;
  final Animation<double> parentAnimation;
  final Curve curve;
  final Curve reverseCurve;
  final AnimatedZoomBuilder builder;
  final Widget child;

  static Widget defaultBuilder(
    BuildContext context,
    Animation<double> animation,
    double scale,
    Widget child,
  ) {
    return Transform.scale(
      scale: 1.0 + (animation.value * scale),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // See [BugfixAnimation] for more info.
    final bugFixedAnimation = BugfixAnimation(
      parentAnimation ?? ModalRoute.of(context).secondaryAnimation,
    );
    final animation = CurvedAnimation(
      parent: bugFixedAnimation,
      curve: curve ?? Curves.easeInOut,
      reverseCurve: reverseCurve ?? Curves.easeInCubic,
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return builder(
          context,
          animation,
          scale ?? 1.0,
          child,
        );
      },
      child: child,
    );
  }
}
