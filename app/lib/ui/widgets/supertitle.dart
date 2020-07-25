import 'package:flutter/material.dart';

class Supertitle extends StatelessWidget {
  const Supertitle({
    Key key,
    this.style,
    @required this.supertitle,
    @required this.child,
  })  : assert(supertitle != null),
        assert(child != null),
        super(key: key);

  final TextStyle style;
  final Widget child;
  final Widget supertitle;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: style,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle(
            style: Theme.of(context)
                .textTheme
                .overline
                .merge(style ?? const TextStyle()),
            child: supertitle,
          ),
          child,
        ],
      ),
    );
  }
}
