import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shiritori/theme/theme.dart';

typedef ScaleButtonBuilder = Widget Function(
  BuildContext context,
  double scale,
);

class ScaleButton extends StatefulWidget {
  const ScaleButton({
    Key key,
    this.tappedScale = defaultTappedScale,
    @required this.onTap,
    @required this.child,
  })  : builder = null,
        assert(child != null),
        assert(
          tappedScale != null && tappedScale >= 0.0 && tappedScale <= 1.0,
          'tappedScale must not be null '
          'and must be between 0.0 and 1.0 (inclusive).',
        ),
        super(key: key);

  const ScaleButton.builder({
    Key key,
    this.tappedScale = defaultTappedScale,
    @required this.onTap,
    @required this.builder,
  })  : child = null,
        assert(builder != null),
        assert(
          tappedScale != null && tappedScale >= 0.0 && tappedScale <= 1.0,
          'tappedScale must not be null '
          'and must be between 0.0 and 1.0 (inclusive).',
        ),
        super(key: key);

  static const defaultTappedScale = 0.95;

  final double tappedScale;
  final VoidCallback onTap;
  final Widget child;
  final ScaleButtonBuilder builder;

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
  static const _tapCurve = AppTheme.curveDefault;

  AnimationController _controller;
  Animation<double> _tapAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
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
    try {
      widget.onTap();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      rethrow;
    } finally {
      _controller.reverse();
    }
  }

  Future<void> _onTapCancel() async {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;

    return AnimatedBuilder(
      animation: _tapAnimation,
      builder: (context, child) {
        return Transform.scale(
          alignment: Alignment.center,
          scale: _tapAnimation.value,
          child: MouseRegion(
            cursor: !enabled
                ? MouseCursor.defer
                : MaterialStateMouseCursor.clickable,
            child: GestureDetector(
              onTapDown: !enabled ? null : _onTapDown,
              onTapUp: !enabled ? null : _onTapUp,
              onTapCancel: !enabled ? null : _onTapCancel,
              child:
                  widget.child ?? widget.builder(context, _tapAnimation.value),
            ),
          ),
        );
      },
    );
  }
}
