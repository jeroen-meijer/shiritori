import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shiritori/theme/theme.dart';

class ScaleButton extends StatefulWidget {
  const ScaleButton({
    Key key,
    this.tappedScale = 0.95,
    @required this.onTap,
    @required this.child,
  })  : assert(
          tappedScale != null && tappedScale >= 0.0 && tappedScale <= 1.0,
          'tappedScale must not be null '
          'and must be between 0.0 and 1.0 (inclusive).',
        ),
        super(key: key);

  final double tappedScale;
  final VoidCallback onTap;
  final Widget child;

  @override
  _ScaleButtonState createState() => _ScaleButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('tappedScale', tappedScale))
      ..add(DiagnosticsProperty<Widget>('child', child))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}

class _ScaleButtonState extends State<ScaleButton>
    with SingleTickerProviderStateMixin {
  static const _tapCurve = AppTheme.defaultCurve;

  AnimationController _controller;
  Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _tapAnimation = CurvedAnimation(
      parent: _controller,
      curve: _tapCurve,
      reverseCurve: _tapCurve.flipped,
    ).drive(Tween(begin: 1.0, end: widget.tappedScale));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onTapDown(TapDownDetails details) async {
    _controller.forward();
  }

  Future<void> _onTapUp(TapUpDetails details) async {
    widget.onTap();
    _controller.reverse();
  }

  Future<void> _onTapCancel() async {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _tapAnimation,
      builder: (context, child) {
        return Transform.scale(
          alignment: Alignment.center,
          scale: _tapAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: widget.child,
      ),
    );
  }
}
