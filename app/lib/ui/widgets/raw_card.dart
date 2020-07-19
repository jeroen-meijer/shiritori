import 'package:flutter/material.dart';

class RawCard extends StatelessWidget {
  const RawCard({
    Key key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.animationDuration,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null),
        super(key: key);

  static const double _defaultElevation = 1.0;

  final Color color;
  final Color shadowColor;
  final double elevation;
  final ShapeBorder shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final bool semanticContainer;
  final Duration animationDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cardTheme = CardTheme.of(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(4.0),
        child: Material(
          animationDuration: animationDuration ?? Duration.zero,
          type: MaterialType.card,
          shadowColor: shadowColor ?? cardTheme.shadowColor ?? Colors.black,
          color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
          elevation: elevation ?? cardTheme.elevation ?? _defaultElevation,
          shape: shape ??
              cardTheme.shape ??
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}
