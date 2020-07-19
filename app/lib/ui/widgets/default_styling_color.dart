import 'package:flutter/material.dart';

class DefaultStylingColor extends StatelessWidget {
  const DefaultStylingColor({
    Key key,
    @required this.color,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Color color;
  final Widget child;

  static DefaultStylingColor of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<DefaultStylingColor>();
  }

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return child;
    }

    return IconTheme.merge(
      data: IconThemeData(color: color),
      child: DividerTheme(
        data: DividerTheme.of(context).copyWith(color: color),
        child: child,
      ),
    );
  }
}
