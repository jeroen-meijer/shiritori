import 'package:flutter/material.dart';
import 'package:shiritori/ui/widgets/widgets.dart';

class TextButton extends StatelessWidget {
  const TextButton({
    Key key,
    this.color,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.5 : 1.0,
      child: ScaleButton(
        tappedScale: 0.9,
        onTap: onTap,
        child: DefaultStylingColor(
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                style: Theme.of(context).textTheme.subtitle1,
                child: child,
              ),
              const SubtitleLine(),
            ],
          ),
        ),
      ),
    );
  }
}
