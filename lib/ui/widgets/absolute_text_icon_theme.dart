import 'package:flutter/material.dart';

class AbsoluteTextIconTheme extends StatelessWidget {
  const AbsoluteTextIconTheme({
    Key key,
    this.size,
    this.color,
    @required this.child,
  }) : super(key: key);

  final double size;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: DefaultTextStyle.merge(
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size,
          color: color,
        ),
        child: IconTheme.merge(
          data: IconThemeData(
            size: size,
            color: color,
          ),
          child: child,
        ),
      ),
    );
  }
}
